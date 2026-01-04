import os, io, requests, threading, platform, zipfile, subprocess, winreg

TOOLS = [
    {
        "name": "JetBrainsMono nerd-fonts",
        "url": "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip",
        "bin": "fonts",
    },
    {
        "name": "GCC",
        "url": "https://winlibs.com/downloads/mingw-gcc-12.2.0-uwp-64.zip",
        "bin": "bin"
    },
    {
        "name": "CMake",
        "url": "https://github.com/Kitware/CMake/releases/download/v3.27.5/cmake-3.27.5-windows-x86_64.zip",
        "bin": "bin"
    },
    {
        "name": "NodeJS",
        "url": "https://nodejs.org/dist/v20.7.0/node-v20.7.0-win-x64.zip",
        "bin": "bin"
    },
]

BIN_DIR = "bin"
TMP_DIR = "tmp"

os.makedirs(BIN_DIR, exist_ok=True)
os.makedirs(TMP_DIR, exist_ok=True)

THREADS = []

def download_extract_to(num: int, target: str) -> None:
    tool = TOOLS[num]
    print(f"Starting to download: {tool['name']}")
    r = requests.get(tool['url'], stream=True)
    r.raise_for_status()
    print(f"Starting to extract {tool['name']}")
    with io.BytesIO(r.content) as zip_file:
        with zipfile.ZipFile(zip_file) as z:
            z.extractall(os.path.join(target, tool.get("bin", "")))
    print(f"Done extracting {tool['name']}")

def add_to_PATH(new_path: str):
    new_path = os.path.abspath(new_path)
    key = winreg.OpenKey(winreg.HKEY_CURRENT_USER,
                         "Environment",
                         0, winreg.KEY_READ | winreg.KEY_WRITE)
    try:
        current_path, _ = winreg.QueryValueEx(key, "Path")
    except FileNotFoundError:
        current_path = ""
    if new_path not in current_path:
        new_path = new_path + ";" + current_path
        winreg.SetValueEx(key, "Path", 0, winreg.REG_EXPAND_SZ, new_path)
        print(f"Added {new_path} to user PATH")
    winreg.CloseKey(key)

# Start threads
for i, _ in enumerate(TOOLS):
    t = threading.Thread(target=download_extract_to, args=(i, BIN_DIR))
    t.start()
    THREADS.append(t)

# Wait for all downloads
for t in THREADS:
    t.join()

print("Adding bin to PATH")
add_to_PATH(BIN_DIR)
print("Done! Enjoy your tools 🎉")
