@echo off
title Backup

REM Define backup source and destination folders
set backupSource=C:\Users\wiesty\BackupSource
set tempbackup=C:\Users\wiesty\temp
set backupDestination=C:\Users\wiesty\FinalBackups


:check_connection
echo checking internet connection....
ping 8.8.8.8 -n 1 -w 1000 >nul
if errorlevel 1 (
    echo You don't have an internet connection. Waiting 10 seconds before retrying...
    timeout /t 10 /nobreak >nul
    goto check_connection
)


echo creating new backup folder...
set backupFolder=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%
set backupFolder=%backupFolder:_=-%
mkdir "%tempbackup%\%backupFolder%"

echo folder created. backup starting...
REM excluded folders after the /np /xd 
robocopy "%backupSource%" "%tempbackup%%backupFolder%" /e /xo /r:0 /np /xd "%backupSource%\yt"
echo Backup complete.
echo.
echo Zip the backup folder
powershell Compress-Archive -Path "%tempbackup%%backupFolder%" -DestinationPath "%backupDestination%\%backupFolder%.zip"
echo done
echo.
echo Delete the original backup folder
rmdir /s /q "%tempbackup%\%backupFolder%"
echo done
echo.
echo deleting old backups...
pushd "%backupDestination%"
for /f "skip=10 delims=" %%f in ('dir /b /o-d /a-d *.zip') do del "%%f"
popd
echo Old backups deleted.
echo.
pause
