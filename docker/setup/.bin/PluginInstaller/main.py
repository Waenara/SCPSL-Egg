import os
import re
import json
import yaml
import requests
from loguru import logger

SCPSL_EGG_REPO = "https://github.com/Waenara/SCPSL-Egg"
CONFIG_PATH = os.path.join("home", "container", ".config", "PluginInstaller", "config.yaml")

def load_config() -> dict:
    if not os.path.exists(CONFIG_PATH):
        logger.warning("Config file not found. Downloading default config file...")
        os.makedirs(os.path.dirname(CONFIG_PATH), exist_ok=True)
        response = requests.get(f"{SCPSL_EGG_REPO}/raw/main/docker/setup/.config/PluginInstaller/config.yaml")
        with open(CONFIG_PATH, "w") as f:
            f.write(response.content.decode())
        logger.success("Config file downloaded successfully!")

    with open(CONFIG_PATH, "r") as f:
        return yaml.safe_load(f)

def extract_github_info(url: str) -> tuple:
    pattern = r'https://github\.com/([^/]+)/([^/]+)'
    match = re.match(pattern, url)

    if match:
        username = match.group(1)
        repo_name = match.group(2)
        return username, repo_name
    else:
        return None, None

def remove_old_plugin(plugin_name: str, plugin_dir: str) -> None:
    for filename in os.listdir(plugin_dir):
        if filename.startswith(plugin_name):
            file_path = os.path.join(plugin_dir, filename)
            os.remove(file_path)
            logger.info(f"Removed old plugin file: {file_path}")

def github_request(url: str, token: str = None) -> requests.Response:
    headers = {}
    if token:
        headers["Authorization"] = f"token {token}"
    response = requests.get(url, headers=headers)
    if response.status_code == 401:
        logger.error("Invalid GitHub token or token lacks permissions.")
    return response

def install_plugin(url: str, path: str, token: str = None) -> None:
    username, repo_name = extract_github_info(url)

    if not username or not repo_name:
        logger.error(f"Invalid GitHub URL: {url}")
        return

    logger.info(f"########## Installing {repo_name} by {username} ##########")

    response = github_request(f"https://api.github.com/repos/{username}/{repo_name}/releases/latest", token)
    if response.status_code == 200:
        release_data = response.json()
        latest_version = release_data["tag_name"]
        if "assets" in release_data and release_data["assets"]:
            asset = release_data["assets"][0]
            asset_name = asset["name"]
            download_url = asset["browser_download_url"]

            expected_filename = f"{repo_name}-{latest_version}.dll"
            full_path = os.path.join(path, expected_filename)

            if os.path.exists(full_path):
                logger.info(f"{expected_filename} is up-to-date. Skipping download.")
                return
            else:
                remove_old_plugin(repo_name, path)

                os.makedirs(path, exist_ok=True)
                asset_response = github_request(download_url, token)
                with open(full_path, "wb") as f:
                    f.write(asset_response.content)
                logger.success(f"Downloaded {expected_filename} to {full_path}")
        else:
            logger.error(f"No assets found in the latest release of {repo_name}")
    else:
        logger.error(f"Failed to fetch release information for {repo_name}. HTTP status code: {response.status_code}")

if __name__ == "__main__":
    logger.info("Starting plugin installation...")

    config = load_config()
    github_token = config.get("github_token")

    for exiled_plugin in config["plugins"]["exiled"]:
        install_plugin(exiled_plugin, os.path.join("home", "container", ".config", "EXILED", "Plugins"), github_token)

    for nwapi_plugin in config["plugins"]["nwapi"]:
        install_plugin(nwapi_plugin, os.path.join("home", "container", ".config", "SCP Secret Laboratory", "PluginAPI", "plugins", "global"), github_token)
