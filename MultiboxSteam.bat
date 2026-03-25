
:: Sets the username of the alternate windows account that will be running Steam
SET WINDOWSUSER=<alternate windows username>

:: Sets the IPC name which will be used by Steam (by default is the same as WINDOWSUSER
SET IPCNAME=%WINDOWSUSER%

:: Sets the installation path of Steam
SET STEAMPATH=C:\Program Files (x86)\Steam\Steam.exe


:: Runs Steam as the alternate user and override the IPC name
runas /profile /user:%WINDOWSUSER% /savecred "\"%STEAMPATH%\" -master_ipc_name_override \"%IPCNAME%\" -userchooser -console"
