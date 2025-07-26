
# EXIF Scrubber
![Platform](https://img.shields.io/badge/Platform-macOS%20%7C%20Linux%20%7C%20Windows-blue)
![License](https://img.shields.io/badge/License-MIT-green)
![Maintained](https://img.shields.io/badge/Maintained%3F-Yes-brightgreen)
[![Open Issues](https://img.shields.io/github/issues/knowoneactual/exif-quick-action)](https://github.com/knowoneactual/exif-quick-action/issues)

A simple way to interactively review and strip all metadata from your files using the powerful [ExifTool](https://exiftool.org/).


### Why use this?

Photos and documents contain hidden metadata (like GPS location, device information, and creation time) that you might not want to share. This tool provides a safe, interactive way to view that data and remove it before sharing a file.

### **Supported File Types**
 
Because this tool uses the powerful ExifTool engine, it supports reading and writing metadata for various file types, including JPEG, PNG, TIFF, MP4, and many others. It can also create metadata-only files like XMP and MIE. I mainly use it for PNGs and JPGs.

Essentially, if a file is known to contain metadata, ExifTool can likely handle it. You can see the complete list of supported file types on the [official ExifTool website](https://exiftool.org/#supported).



### What's New?

I've updated the macOS Quick Action to be more reliable and user-friendly! The new version uses a native AppleScript dialog to display metadata and ask for confirmation, which avoids the old permission issues with the Terminal. It's a much smoother experience.

The original terminal script is still available for users on Linux, Windows, or for those who just prefer the command line.


---


### Prerequisites

You must have ExifTool installed. The easiest way to install it on a Mac is with [Homebrew](https://brew.sh/).

Bash
```
brew install exiftool 
```

---


### How to Use

We have two great ways to use this tool.


#### Method 1: The New & Improved Quick Action (Recommended for macOS)

This method provides a native macOS pop-up to review metadata and is the most stable way to use the tool.



1. Open the **Automator** app on your Mac.
2. Create a new **Quick Action**.
3. Set "Workflow receives current" to **files or folders** in **Finder**.
4. Add a **Run AppleScript** action.
5. Paste the code below into the action box.
6. Save the Quick Action with a name like "Review & Strip Metadata."

AppleScript
```

on run {input, parameters} 
	-- Loop through each file that was selected 
	repeat with aFile in input 
		-- Get the name of the file for the dialog title 
		tell application "Finder" 
			set fileName to name of aFile 
		end tell 
		 
		try 
			-- Run exiftool to get the metadata and store it in a variable 
			set exifData to do shell script "/usr/local/bin/exiftool " & quoted form of POSIX path of aFile 
			 
			-- Show a dialog with the metadata, asking the user what to do 
			display dialog exifData with title "Metadata for " & fileName buttons {"Skip File", "Strip Metadata"} default button "Strip Metadata" 
			 
			-- If the user clicks "Strip Metadata", then run the command to remove it 
			if button returned of result is "Strip Metadata" then 
				do shell script "/usr/local/bin/exiftool -all= -overwrite_original " & quoted form of POSIX path of aFile 
			end if 
			 
		on error errMsg 
			-- If exiftool returns an error (e.g., no EXIF data), show a message 
			display dialog "Could not read metadata for "" & fileName & "". It might not contain any, or the file could be corrupted." & "nnError: " & errMsg buttons {"OK"} default button "OK" 
		end try 
	end repeat 
	 
	-- Let Automator know the script is done 
	return input 
end run 
```


#### Method 2: The Original Terminal Script (For macOS, Linux, and Windows)

This method uses a shell script that you can run from your terminal. On Windows, you will need a Bash environment like [Git Bash](https://git-scm.com/download/win) or [WSL](https://docs.microsoft.com/en-us/windows/wsl/install).


1. Make the script executable (you only have to do this once): 

Bash 
``` 
chmod +x exif-strip.sh 
```

2. Run the script on one or more files: 

Bash 
```
./exif-strip.sh /path/to/your/file.jpg /path/to/another/file.png
```

### **This is the original way I ingrated with Automator.**
#### Quick Action Setup With Bash Script.

1.  Open the **Automator** app on your Mac.
2.  Create a new **Quick Action**.
3.  Set "Workflow receives current" to **files or folders** in **Finder**.
4.  Add a **Run Shell Script** action and set "Pass input" to **as arguments**.
5.  Paste the code from the `quick-action.sh` file into the action box.
6.  **Important:** Update the `SCRIPT_PATH` variable to the location where you saved `exif-strip.sh`.
7.  Save the Quick Action with a name like "Review & Strip Metadata".


### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

# **Important Note**

The **Automator Quick Action** part of the setup is **exclusive to macOS** and will not work on Windows or Linux. The convenience of a right-click menu is a feature of the Mac operating system. On other systems, you would use the script from the command line.
