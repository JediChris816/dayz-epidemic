@echo off
echo Stopping game server...
taskkill /F /IM arma2oaserver2.exe
ping 127.0.0.1 -n 5 >NUL
echo.
echo.
echo.
echo Cleaning dead from database older than 7 days...
perl db_utility.pl cleandead 7 --host 192.168.1.103 --user root --pass root --name dayz_epidemic --port 3306
ping 127.0.0.1 -n 5 >NUL
echo.
echo.
echo.
echo Executing spawn script...
db_spawn_vehicles.pl --instance 1 --limit 900 --host 192.168.1.103 --user root --pass root --name dayz_epidemic --port 3306 --cleanup bounds
ping 127.0.0.1 -n 5 >NUL
echo.
echo.
echo.
echo Starting server...
start C:\Users\Administrator\Desktop\Overwatch\arma2oaserver2.exe -config=dayz_epidemic\config_Epidemic.cfg -cfg=dayz_1.dayz_epidemic\basic.cfg -profiles=dayz_1.dayz_epidemic -name=dayz_epidemic -mod=@dayz_epidemic;@realityepidemic -port=2302 -noPause -noSound -cpuCount=2 -exThreads=1 -maxMem=2048
ping 127.0.0.1 -n 5 >NUL
echo.
echo.
echo.
echo Leaving the launcher...
ping 127.0.0.1 -n 5 >NUL
echo.
echo.
echo.
exit