# EXIF Scrubber

A simple macOS script and Automator Quick Action to interactively review and strip all metadata from files using the powerful [ExifTool](https://exiftool.org/).

## Prerequisites

You must have ExifTool installed. The easiest way to install it on a Mac is with [Homebrew](https://brew.sh/).

```sh
brew install exiftool
```

## How to Use

There are two ways to use this tool: as a standalone script or as a convenient right-click Quick Action (recommended).

### 1. Quick Action Setup (Recommended)

This is the easiest way to use the script.

1.  Open the **Automator** app on your Mac.
2.  Create a new **Quick Action**.
3.  Set "Workflow receives current" to **files or folders** in **Finder**.
4.  Add a **Run Shell Script** action.
5.  Set "Pass input" to **as arguments**.
6.  Paste the code from the `quick-action.sh` file into the action box.
7.  **Important:** Update the `SCRIPT_PATH` variable in the code to the location where you saved `exif-strip.sh`.
8.  Save the Quick Action with a name like "Review & Strip Metadata".

You can now right-click any file in Finder and select your Quick Action to run the script.

### 2. Standalone Script Usage

You can also run the `exif-strip.sh` script directly from your terminal.

```sh
# Usage
./exif-strip.sh /path/to/your/file.jpg /path/to/another/file.png
```


Yes, if you're wondering, the `exif-strip.sh` script can be used as a standalone tool on both Linux and Windows, but Windows requires a specific environment to run it.

-----

### Linux 🐧

It will work **natively** on almost any Linux distribution. Bash is the standard shell, so the script will run without any changes.

You just need to make sure you have **ExifTool** installed. You can typically install it using your distribution's package manager.

**For Debian/Ubuntu:**

```sh
sudo apt-get update
sudo apt-get install libimage-exiftool-perl
```

**For Fedora/CentOS:**

```sh
sudo dnf install perl-Image-ExifTool
```

-----

### Windows 💻

The script will **not** run natively in the standard Windows Command Prompt or PowerShell because it's a Bash script (`.sh`). However, you can easily run it using one of these two popular (and free) tools:

1.  **Git Bash**: When you install [Git for Windows](https://git-scm.com/download/win), it includes a tool called "Git Bash," which is a terminal that can run Bash scripts.
2.  **Windows Subsystem for Linux (WSL)**: This lets you run a full Linux environment directly on Windows 10 or 11.

In either case, you'll also need to install **ExifTool** for Windows. Once you have a Bash environment and ExifTool installed, the script will work just as it does on a Mac or Linux machine.

-----

## **Important Note**

The **Automator Quick Action** part of the setup is **exclusive to macOS** and will not work on Windows or Linux. The convenience of a right-click menu is a feature of the Mac operating system. On other systems, you would use the script from the command line.
