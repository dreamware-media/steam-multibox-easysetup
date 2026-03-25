
:: Sets the installation path of Steam
SET STEAMPATH=C:\Program Files (x86)\Steam\Steam.exe


:: Runs Steam as the current user and override the IPC name
start "currentuser" "%STEAMPATH%" -master_ipc_name_override %USERNAME% -userchooser -console

pause