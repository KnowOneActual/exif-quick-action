# Define the path to your script.
# IMPORTANT: Change this path to where you saved your script!
SCRIPT_PATH="/Users/userx/scripts/exiftool/exif-strip.sh"

# Build the command to run in the terminal.
# The `printf '%q'` part ensures filenames with spaces are handled correctly.
CMD=$(printf '%q' "$SCRIPT_PATH")
for f in "$@"; do
    CMD="$CMD $(printf '%q' "$f")"
done

# Use AppleScript to tell the Terminal to open and run the command.
osascript -e "tell application \"Terminal\" to do script \"$CMD\""
osascript -e "tell application \"Terminal\" to activate"