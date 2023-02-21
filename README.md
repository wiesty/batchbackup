# batchbackup
Simple batch script for backing up stuff. (In my case used for my unraid appdata folder)

![console output from the script.bat](https://i.imgur.com/5PAXPaL.png)

-   The script first checks for an internet connection by pinging the Google DNS server (8.8.8.8) and waits until a connection is established.
-   The script then defines a list of folders to exclude from the backup (specified after `/e /xo /r:0 /np /xd` ) and the backup source and destination folders (specified by the `backupSource` and `backupDestination` variables).
-   The script creates a new folder in the backup destination directory with a timestamped name and sets it as the current directory.
-   The script uses the `robocopy` command to copy all the files and subdirectories from the backup source directory to the current directory, excluding the folders specified after `/e /xo /r:0 /np /xd` 
-   After the backup is complete, the script checks if there are more than 10 `.zip` files in the backup destination directory and deletes the 10 oldest `.zip` files to save disk space.
-   Finally, the script compresses the backup folder into a `.zip` file, deletes the original backup folder, and outputs a log message indicating that the backup is complete.

Note: This script assumes that the `7z.exe` command-line tool is installed and added to the system PATH for compressing the backup folder into a `.zip` file. If it's not installed, you can download it from the 7-Zip website and add it to the system PATH manually.

The reason for the temp folder is to prevent cloud errors. (If the backupDestination is OneDrive or Nextcloud, it would start to sync the folder before the .zip is made) 
