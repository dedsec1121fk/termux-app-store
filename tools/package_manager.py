#!/usr/bin/env python3
"""
Package Manager Core - Dual Mode Architecture
Supports both local (parse build.sh) and remote (fetch JSON) modes
"""

import json
import os
import subprocess
import urllib.request
import urllib.error
import time
import platform
from pathlib import Path
from typing import Dict, List, Optional, Tuple

# ──────────────────────────────────────────────
# CONSTANTS
# ──────────────────────────────────────────────

APP_VERSION = "0.1.4"  # Current version
GITHUB_REPO = "djunekz/termux-app-store"
GITHUB_API_LATEST = f"https://api.github.com/repos/{GITHUB_REPO}/releases/latest"
GITHUB_INDEX_URL = f"https://raw.githubusercontent.com/{GITHUB_REPO}/main/tools/index.json"

CACHE_DIR = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "termux-app-store"
CACHE_FILE = CACHE_DIR / "index.json"
CACHE_TTL = 6 * 3600  # 6 hours

PREFIX = os.environ.get("PREFIX", "/data/data/com.termux/files/usr")

# ──────────────────────────────────────────────
# HELPER FUNCTIONS
# ──────────────────────────────────────────────

def get_architecture() -> str:
    """Detect current architecture"""
    arch = platform.machine().lower()
    arch_map = {
        'aarch64': 'aarch64',
        'armv7l': 'arm',
        'armv8l': 'arm',
        'x86_64': 'x86_64',
        'i686': 'i686',
        'i386': 'i686',
    }
    return arch_map.get(arch, 'unknown')


def download_file(url: str, destination: Path, timeout: int = 30) -> bool:
    """Download file from URL"""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "termux-app-store"})
        with urllib.request.urlopen(req, timeout=timeout) as response:
            data = response.read()
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_bytes(data)
            return True
    except Exception as e:
        print(f"[ERROR] Download failed: {e}")
        return False


def fetch_json(url: str, timeout: int = 10) -> Optional[Dict]:
    """Fetch JSON from URL"""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "termux-app-store"})
        with urllib.request.urlopen(req, timeout=timeout) as response:
            return json.loads(response.read().decode())
    except Exception as e:
        print(f"[ERROR] Failed to fetch JSON: {e}")
        return None


# ──────────────────────────────────────────────
# VERSION COMPARISON
# ──────────────────────────────────────────────

def parse_version(version: str) -> Tuple[int, ...]:
    """Parse version string to tuple for comparison"""
    try:
        # Remove 'v' prefix if exists
        version = version.lstrip('v')
        # Split and convert to integers
        return tuple(int(x) for x in version.split('.'))
    except:
        return (0, 0, 0)


def compare_versions(current: str, latest: str) -> int:
    """
    Compare two version strings
    Returns: -1 if current < latest, 0 if equal, 1 if current > latest
    """
    current_tuple = parse_version(current)
    latest_tuple = parse_version(latest)
    
    if current_tuple < latest_tuple:
        return -1
    elif current_tuple > latest_tuple:
        return 1
    else:
        return 0


# ──────────────────────────────────────────────
# PACKAGE SOURCE DETECTOR
# ──────────────────────────────────────────────

class PackageSource:
    """Detect and manage package source (local or remote)"""
    
    @staticmethod
    def detect_mode(packages_dir: Optional[Path] = None) -> str:
        """
        Detect mode:
        - 'local' if packages/ directory exists
        - 'remote' otherwise
        """
        # Force mode via env
        if mode := os.getenv("TERMUX_APP_STORE_MODE"):
            return mode.lower()
        
        # Auto-detect
        if packages_dir and packages_dir.exists() and packages_dir.is_dir():
            # Check if there are any build.sh files
            if any((packages_dir / d / "build.sh").exists() for d in packages_dir.iterdir() if d.is_dir()):
                return "local"
        
        return "remote"


# ──────────────────────────────────────────────
# PACKAGE MANAGER
# ──────────────────────────────────────────────

class PackageManager:
    """Universal package manager - works in both local and remote modes"""
    
    def __init__(self, packages_dir: Optional[Path] = None):
        self.packages_dir = packages_dir
        self.mode = PackageSource.detect_mode(packages_dir)
        self.cache_file = CACHE_FILE
        self.cache_ttl = CACHE_TTL
    
    # ─────────────────────────────────────────
    # CACHE MANAGEMENT
    # ─────────────────────────────────────────
    
    def _is_cache_valid(self) -> bool:
        """Check if cache is still fresh"""
        if not self.cache_file.exists():
            return False
        age = time.time() - self.cache_file.stat().st_mtime
        return age < self.cache_ttl
    
    def _save_cache(self, data: Dict):
        """Save JSON to cache"""
        self.cache_file.parent.mkdir(parents=True, exist_ok=True)
        self.cache_file.write_text(json.dumps(data, indent=2))
    
    def _load_cache(self) -> Optional[Dict]:
        """Load JSON from cache"""
        try:
            if self.cache_file.exists():
                return json.loads(self.cache_file.read_text())
        except Exception as e:
            print(f"[ERROR] Failed to load cache: {e}")
        return None
    
    def clear_cache(self):
        """Clear cache"""
        if self.cache_file.exists():
            self.cache_file.unlink()
    
    # ─────────────────────────────────────────
    # LOAD PACKAGES
    # ─────────────────────────────────────────
    
    def load_packages(self) -> List[Dict]:
        """Load packages from appropriate source"""
        if self.mode == "local":
            return self._load_local()
        else:
            return self._load_remote()
    
    def _load_local(self) -> List[Dict]:
        """Parse packages from local build.sh files"""
        if not self.packages_dir or not self.packages_dir.exists():
            return []
        
        packages = []
        for pkg_dir in sorted(self.packages_dir.iterdir()):
            if not pkg_dir.is_dir():
                continue
            
            build_sh = pkg_dir / "build.sh"
            if not build_sh.exists():
                continue
            
            pkg_data = self._parse_build_sh(pkg_dir)
            packages.append(pkg_data)
        
        return packages
    
    def _parse_build_sh(self, pkg_dir: Path) -> Dict:
        """Parse a single build.sh file"""
        data = {
            "package": pkg_dir.name,
            "name": pkg_dir.name,  # alias
            "desc": "-",
            "description": "-",  # alias
            "version": "?",
            "deps": "-",
            "depends": [],  # alias
            "maintainer": "-",
            "homepage": "-",
            "license": "-",
            "srcurl": "",
            "sha256": "",
        }
        
        build_sh = pkg_dir / "build.sh"
        try:
            with build_sh.open(errors="ignore") as f:
                for line in f:
                    line = line.strip()
                    
                    if line.startswith("TERMUX_PKG_DESCRIPTION="):
                        val = line.split("=", 1)[1].strip().strip('"\'')
                        data["desc"] = val
                        data["description"] = val
                    
                    elif line.startswith("TERMUX_PKG_VERSION="):
                        data["version"] = line.split("=", 1)[1].strip().strip('"\'')
                    
                    elif line.startswith("TERMUX_PKG_DEPENDS="):
                        deps_str = line.split("=", 1)[1].strip().strip('"\'')
                        data["deps"] = deps_str
                        data["depends"] = [d.strip() for d in deps_str.split(",") if d.strip()]
                    
                    elif line.startswith("TERMUX_PKG_MAINTAINER="):
                        data["maintainer"] = line.split("=", 1)[1].strip().strip('"\'')
                    
                    elif line.startswith("TERMUX_PKG_HOMEPAGE="):
                        data["homepage"] = line.split("=", 1)[1].strip().strip('"\'')
                    
                    elif line.startswith("TERMUX_PKG_LICENSE="):
                        data["license"] = line.split("=", 1)[1].strip().strip('"\'')
                    
                    elif line.startswith("TERMUX_PKG_SRCURL="):
                        data["srcurl"] = line.split("=", 1)[1].strip().strip('"\'')
                    
                    elif line.startswith("TERMUX_PKG_SHA256="):
                        data["sha256"] = line.split("=", 1)[1].strip().strip('"\'')
        
        except Exception as e:
            print(f"[WARNING] Failed to parse {build_sh}: {e}")
        
        return data
    
    def _load_remote(self) -> List[Dict]:
        """Fetch packages from remote index.json with caching"""
        # Check cache first
        if self._is_cache_valid():
            cached = self._load_cache()
            if cached and "packages" in cached:
                return cached["packages"]
        
        # Fetch from remote
        print("[*] Fetching package index from GitHub...")
        data = fetch_json(GITHUB_INDEX_URL)
        
        if data and "packages" in data:
            self._save_cache(data)
            return data["packages"]
        
        # Fallback to stale cache if exists
        cached = self._load_cache()
        if cached and "packages" in cached:
            print("[!] Using cached data (offline mode)")
            return cached["packages"]
        
        return []
    
    # ─────────────────────────────────────────
    # PACKAGE INFO
    # ─────────────────────────────────────────
    
    def get_package(self, name: str) -> Optional[Dict]:
        """Get package info by name"""
        packages = self.load_packages()
        for pkg in packages:
            if pkg.get("package") == name or pkg.get("name") == name:
                return pkg
        return None
    
    def get_installed_version(self, name: str) -> Optional[str]:
        """Get installed version of a package"""
        try:
            out = subprocess.check_output(
                ["pkg", "info", name],
                stderr=subprocess.DEVNULL,
                text=True,
            )
            for line in out.splitlines():
                if line.startswith("Version:"):
                    return line.split(":", 1)[1].strip()
        except Exception:
            pass
        return None
    
    def get_status(self, name: str, version: str) -> Tuple[str, str]:
        """
        Get package status
        Returns: (status_code, status_label)
        """
        installed = self.get_installed_version(name)
        
        if installed is None:
            return "NOT_INSTALLED", "not installed"
        
        if compare_versions(installed, version) < 0:
            return "UPDATE", f"update available ({installed} → {version})"
        
        return "INSTALLED", f"up-to-date ({version})"


# ──────────────────────────────────────────────
# APP UPDATE CHECKER
# ──────────────────────────────────────────────

class AppUpdateChecker:
    """Check for termux-app-store updates"""
    
    @staticmethod
    def get_latest_version() -> Optional[str]:
        """Fetch latest version from GitHub releases"""
        data = fetch_json(GITHUB_API_LATEST)
        if data and "tag_name" in data:
            return data["tag_name"].lstrip('v')
        return None
    
    @staticmethod
    def check_update() -> Tuple[bool, Optional[str]]:
        """
        Check if update is available
        Returns: (has_update, latest_version)
        """
        latest = AppUpdateChecker.get_latest_version()
        if not latest:
            return False, None
        
        comparison = compare_versions(APP_VERSION, latest)
        return comparison < 0, latest
    
    @staticmethod
    def get_download_url(version: str) -> str:
        """Get download URL for current architecture"""
        arch = get_architecture()
        return f"https://github.com/{GITHUB_REPO}/releases/download/v{version}/termux-app-store-{arch}"
    
    @staticmethod
    def upgrade_app(latest_version: str) -> bool:
        """
        Download and install latest version
        Returns: True if successful
        """
        print(f"\n[*] Downloading termux-app-store v{latest_version}...")
        
        url = AppUpdateChecker.get_download_url(latest_version)
        temp_file = Path("/tmp/termux-app-store-new")
        
        # Download
        if not download_file(url, temp_file):
            print("[ERROR] Download failed")
            return False
        
        # Make executable
        temp_file.chmod(0o755)
        
        # Replace binary
        target = Path(PREFIX) / "bin" / "termux-app-store"
        try:
            import shutil
            shutil.move(str(temp_file), str(target))
            print(f"[✔] Successfully upgraded to v{latest_version}!")
            print(f"    Restart termux-app-store to use the new version.")
            return True
        except Exception as e:
            print(f"[ERROR] Failed to install: {e}")
            return False


# ──────────────────────────────────────────────
# EXPORTS
# ──────────────────────────────────────────────

__all__ = [
    'PackageManager',
    'AppUpdateChecker',
    'APP_VERSION',
    'compare_versions',
]
