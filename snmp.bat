SET Location = 
Set CommunityName = 
Set TrapIP=
SET AnsFile=%TEMP%\ocm.txt


ECHO [NetOptionalComponents] >%AnsFile%
ECHO SNMP = 1 >>%AnsFile%
ECHO WbemMSI = On >>%AnsFile%
ECHO WBEMSNMP= 1 >>%AnsFile%
ECHO Fax = 1 >>%AnsFile%
ECHO. >>%AnsFile%  
ECHO [SNMP] >>%AnsFile%
ECHO Contact_Name = %UserName%>>%AnsFile%
ECHO Location = %Location%>>%AnsFile%
ECHO.  >>%AnsFile%
ECHO Service = Physical, Applications, End-to-End >>%AnsFile%
ECHO.  >>%AnsFile%
ECHO Community_Name = %CommunityName% >>%AnsFile%
ECHO Traps = %TrapIP%>>%AnsFile%
ECHO.  >>%AnsFile%
ECHO Send_Authentication = No >>%AnsFile%
ECHO Accept_CommunityName = public:Read_Only >>%AnsFile%
ECHO Any_Host = No >>%AnsFile%
ECHO Limit_Host = %TrapIP%>>%AnsFile%
ECHO.>>%AnsFile%
%windir%\system32\sysocmgr.exe /i:%windir%\inf\sysoc.inf /u:%TEMP%\ocm.txt /r
)
