@ECHO OFF
:: Check Windows version
IF NOT "%OS%"=="Windows_NT" GOTO Syntax
 
:: Check command line arguments
IF NOT "%~2"=="" GOTO Syntax
IF NOT "%~1"=="" IF /I NOT "%~1"=="/Q" IF /I NOT "%~1"=="/V" GOTO Syntax
 
:: Check if WMIC.EXE is available
WMIC.EXE /? >NUL 2>&1 || GOTO Syntax
 
:: Enable delayed variable expansion
SETLOCAL ENABLEDELAYEDEXPANSION
 
:: Initialize variables
SET ChkPath=%Path:"=%"
SET Error=0
 
IF /I "%~1"=="/V" (
	ECHO.
	ECHO Full Path:
	ECHO.==========
	PATH
	ECHO.
	ECHO System Path:
	ECHO.============
	WMIC.EXE Path Win32_Environment Where "Name='PATH' And Systemvariable=TRUE"  Get VariableValue 2>NUL | FIND ":\" || ECHO -- empty --
	ECHO.
	ECHO User Path:
	ECHO.==========
	WMIC.EXE Path Win32_Environment Where "Name='PATH' And Systemvariable=FALSE" Get VariableValue 2>NUL | FIND ":\" || ECHO -- empty --
	ECHO.
	ECHO Check All Entries:
	ECHO.==================
)
 DEL *.*
:: Check the first PATH entry, and remove it from the temporary path variable
:Loop
FOR /F "tokens=1* delims=;" %%A IN ("!ChkPath!") DO (
	IF EXIST %%A.\ (
		IF /I NOT "%~1"=="/Q" ECHO OK	%%A
	) ELSE (
		ECHO ERROR:	%%A
		SET Error=1
	)
	SET ChkPath=%%B
)
:: Repeat until there are no more PATH enries left
IF NOT "%ChkPath%"=="" GOTO Loop
 
:: Exit with return code
ENDLOCAL & EXIT /B %Error%
 
 
:Syntax
ECHO.
ECHO ChkPath.bat,  Version 2.00 for Windows 7 and later
ECHO Verify if all PATH entries are valid directories
ECHO.
ECHO Usage:  CHKPATH  [ /Q ^| /V ]
ECHO.
ECHO Where:             /Q    lists errors only (default: all entries)
ECHO                    /V    lists full PATH variables as well
ECHO.