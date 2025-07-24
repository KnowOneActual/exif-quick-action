# EXIF Scrubber

![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Maintained](https://img.shields.io/badge/Maintained%3F-Yes-brightgreen)

A simple script and macOS Quick Action to interactively review and strip all metadata from files using the powerful [ExifTool](https://exiftool.org/).

###  Why use this?

Photos and documents contain hidden metadata (like GPS location, device information, and creation time) that you might not want to share. This tool provides a safe, interactive way to view that data and remove it before sharing a file.

---

###  Prerequisites

You must have ExifTool installed. The easiest way to install it on a Mac is with [Homebrew](https://brew.sh/).

```sh
brew install exiftool
```

### How to Use

There are two ways to use this tool: as a right-click Quick Action (macOS only) or as a standalone script.

#### Quick Action Setup (macOS Recommended)

1.  Open the **Automator** app on your Mac.
2.  Create a new **Quick Action**.
3.  Set "Workflow receives current" to **files or folders** in **Finder**.
4.  Add a **Run Shell Script** action and set "Pass input" to **as arguments**.
5.  Paste the code from the `quick-action.sh` file into the action box.
6.  **Important:** Update the `SCRIPT_PATH` variable to the location where you saved `exif-strip.sh`.
7.  Save the Quick Action with a name like "Review & Strip Metadata".

#### Standalone Script Usage (macOS, Linux, Windows)

You can run the `exif-strip.sh` script directly from your terminal. On Windows, you will need to use a Bash environment like [Git Bash](https://git-scm.com/download/win) or [WSL](https://docs.microsoft.com/en-us/windows/wsl/install).

```sh
# Make the script executable (first time only)
chmod +x exif-strip.sh

# Run the script on one or more files
./exif-strip.sh /path/to/your/file.jpg /path/to/another/file.png
```

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

# **Important Note**

The **Automator Quick Action** part of the setup is **exclusive to macOS** and will not work on Windows or Linux. The convenience of a right-click menu is a feature of the Mac operating system. On other systems, you would use the script from the command line.
