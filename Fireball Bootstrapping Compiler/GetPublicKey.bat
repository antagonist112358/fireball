@ECHO OFF
SET sn="C:\Program Files (x86)\Microsoft SDKs\Windows\v8.1A\bin\NETFX 4.5.1 Tools\sn.exe"
ECHO %sn%
%sn% -p resources\keys\Fireball.snk Fireball.PublicKey
%sn% -tp Fireball.PublicKey
PAUSE