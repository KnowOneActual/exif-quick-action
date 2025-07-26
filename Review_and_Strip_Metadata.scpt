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
			display dialog "Could not read metadata for \"" & fileName & "\". It might not contain any, or the file could be corrupted." & "\n\nError: " & errMsg buttons {"OK"} default button "OK"
		end try
	end repeat
	
	-- Let Automator know the script is done
	return input
end run
