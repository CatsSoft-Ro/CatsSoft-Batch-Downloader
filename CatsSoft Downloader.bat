@echo off
Title CatsSoft Downloader
color 0B
mode con:cols=90 lines=26
echo.
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
SET "DestDir=%USERPROFILE%\Downloads\CatsSoft Downloader"
SET "VideoDestDir=%USERPROFILE%\Videos\CatsSoft Video Downloader"
SET "AudioDestDir=%USERPROFILE%\Music\CatsSoft Audio Downloader"
echo.
if exist "%DestDir%" (
 goto menu
) else (
 MD "%DestDir%"
 MD "%VideoDestDir%"
 MD "%AudioDestDir%"
 goto menu
)
goto menu
goto :eof
:: /*************************************************************************************/
:: Menu of tool.
:: void menu();
:: /*************************************************************************************/
:menu
    @cls
    Title CatsSoft Downloader
    color 0B
    mode con:cols=90 lines=26
    @cls
    echo.    -----------------------------------
    echo.      ===  Welcome to main menu! ===   
    echo.    -----------------------------------
    echo.                                       
    echo.    [1] Download files with aria2c.
    echo.
    echo.    [2] Download files with axel.
    echo.
    echo.    [3] Download files with curl.
    echo.
    echo.    [4] Download files with dcat.
    echo.
    echo.    [5] Download files with inetget.
    echo.
    echo.    [6] Download files with pget.
    echo.
    echo.    [7] Download files with url2file.
    echo.
    echo.    [8] Download files with wget.
    echo.
    echo.    [9] Download video with youtube-dl.
    echo.
    echo.    [0] Close.
    echo.
    echo.

    set /p "option=Type 1, 2, 3, 4, 5, 6, 7, 8, 9 or 0 then press ENTER: "

    if %option% EQU 0 (
        goto close
    ) else if %option% EQU 1 (
        call :aria2c
    ) else if %option% EQU 2 (
        call :axel
    ) else if %option% EQU 3 (
        call :curl
    ) else if %option% EQU 4 (
        call :dcat
    ) else if %option% EQU 5 (
        call :inetget
    ) else if %option% EQU 6 (
        call :pget
    ) else if %option% EQU 7 (
        call :url2file
    ) else if %option% EQU 8 (
        call :wget
    ) else if %option% EQU 9 (
        call :youtube
    ) else (
        echo.
        echo.Invalid option.
        echo.
        echo ---------------------------------------------------------------------------------
        echo.
        echo   	=== Press any key to return to the main menu ===
        echo.
        echo ---------------------------------------------------------------------------------
        echo.
        pause>nul
        goto menu
    )
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void aria2c();
:: /*************************************************************************************/
:aria2c
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_aria2c
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_aria2c
     If /I "%choice%"=="N" goto no_aria2c
     echo Incorrect input & goto choice_aria2c
     rem If yes, rename the file
     :yes_aria2c
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_aria2c
     rem If no, delete the file
     :no_aria2c
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_aria2c
    ) else (
     goto down_aria2c
    )
    :down_aria2c
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using Aria2c...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    aria2c.exe -c "%Linkaddress%" -o "%FileName%" -d "%DestDir%" --http-user=%Username% --http-passwd=%Password%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_aria2c
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_aria2c
    )
    :close_aria2c
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void axel();
:: /*************************************************************************************/
:axel
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_axel
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     if /I "%choice%"=="Y" goto yes_axel
     if /I "%choice%"=="N" goto no_axel
     echo Incorrect input & goto choice_axel
     rem If yes, rename the file
     :yes_axel
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_axel
     rem If no, delete the file
     :no_axel
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_axel
    ) else (
     goto down_axel
    )
    :down_axel
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using Axel ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    axel.exe -q -a -n 1000 "%Linkaddress%" -o "%DestDir%\%FileName%"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_axel
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_axel
    )
    :close_axel
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void curl();
:: /*************************************************************************************/
:curl
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_curl
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_curl
     If /I "%choice%"=="N" goto no_curl
     echo Incorrect input & goto choice_curl
     rem If yes, rename the file
     :yes_curl
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_curl
     rem If no, delete the file
     :no_curl
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_curl
    ) else (
     goto down_curl
    )
    :down_curl
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using curl ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    curl.exe -C -k -# --url "%Linkaddress%" -o "%DestDir%\%FileName%" -u %Username%:%Password%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_curl
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_curl
    )
    :close_curl
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void dcat();
:: /*************************************************************************************/
:dcat
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_dcat
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_dcat
     If /I "%choice%"=="N" goto no_dcat
     echo Incorrect input & goto choice_dcat
     rem If yes, rename the file
     :yes_dcat
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_dcat
     rem If no, delete the file
     :no_dcat
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_dcat
    ) else (
     goto down_dcat
    )
    :down_dcat
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start download using dcat ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    dcat.exe -r "%Linkaddress%" -o "%DestDir%" "-su%Username%" "-sp%Password%"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_dcat
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_dcat
    )
    :close_dcat
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void inetget();
:: /*************************************************************************************/
:inetget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_inetget
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_inetget
     If /I "%choice%"=="N" goto no_inetget
     echo Incorrect input & goto choice_inetget
     rem If yes, rename the file
     :yes_inetget
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_inetget
     rem If no, delete the file
     :no_inetget
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_inetget
    ) else (
     goto down_inetget
    )
    :down_inetget
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using inetget ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    INetGet.exe --notify "%Linkaddress%" "%DestDir%\%FileName%"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_inetget
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_inetget
    )
    :close_inetget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void pget();
:: /*************************************************************************************/
:pget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_pget
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_pget
     If /I "%choice%"=="N" goto no_pget
     echo Incorrect input & goto choice_pget
     rem If yes, rename the file
     :yes_pget
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_pget
     rem If no, delete the file
     :no_pget
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_pget
    ) else (
     goto down_pget
    )
    :down_pget
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using pget ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    pget.exe --trace -o "%FileName%" -d "%DestDir%" "%Linkaddress%" 
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_pget
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_pget
    )
    :close_pget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void url2file();
:: /*************************************************************************************/
:url2file
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_url2file
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_url2file
     If /I "%choice%"=="N" goto no_url2file
     echo Incorrect input & goto choice_url2file
     rem If yes, rename the file
     :yes_url2file
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_url2file
     rem If no, delete the file
     :no_url2file
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_url2file
    ) else (
     goto down_url2file
    )
    :down_url2file
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using url2file ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    url2file.exe "%Linkaddress%" "%DestDir%\%FileName%" -u "%Username%" -p "%Password%"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_url2file
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_url2file
    )
    :close_url2file
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download files.
:: void wget();
:: /*************************************************************************************/
:wget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste URL below (right click - Paste) and press Enter
    echo.
    set /P "LinkAddress=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%LinkAddress%") do set "FileName=%%~nxg"
    echo File: %FileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%LinkAddress%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your username (if necessary)
    echo.
    set /P "Username=USERNAME: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Type your login password (if necessary)
    echo.
    set /P "Password=PASSWORD: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%FileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_wget
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_wget
     If /I "%choice%"=="N" goto no_wget
     echo Incorrect input & goto choice_wget
     rem If yes, rename the file
     :yes_wget
       echo Rename the file "%FileName%" ...
       ren "%DestDir%\%FileName%" "backup_%FileName%"
       echo Done.
       goto down_wget
     rem If no, delete the file
     :no_wget
       echo Delete the file "%FileName%" ...
       del "%DestDir%\%FileName%"
       echo Done.
       goto down_wget
    ) else (
     goto down_wget
    )
    :down_wget
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download using wget ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    wget.exe --continue --show-progress --no-check-certificate "%Linkaddress%" -O "%DestDir%\%FileName%" --user=%Username% --password=%Password%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%DestDir%\%FileName%" (
     echo The files "%FileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%DestDir%"
     goto close_wget
    ) else (
     echo The files "%FileName%" could not be downloaded! Try again later.
     goto close_wget
    )
    :close_wget
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto menu
goto :eof
cls
:: /*************************************************************************************/
:: Download audio , video.
:: void youtube();
:: /*************************************************************************************/
:youtube
    @cls
    Title CatsSoft Video Downloader
    color 0E
    mode con:cols=90 lines=26
    @cls
    echo.
    echo.    -----------------------------------
    echo.      ===  Welcome to main menu! ===   
    echo.    -----------------------------------
    echo.                                       
    echo.    [1] Download video with youtube-dl.
    echo.
    echo.    [2] Download audio with youtube-dl.
    echo.
    echo.    [3] Update youtube-dl.
    echo.
    echo.    [0] Close.
    echo.
    echo.

    set /p option=Type 1, 2, 3, or 0 then press ENTER: 

    if %option% EQU 0 (
        goto close
    ) else if %option% EQU 1 (
        call :video
    ) else if %option% EQU 2 (
        call :audio
    ) else if %option% EQU 3 (
        call :update
    ) else if %option% EQU 4 (
        call :help
    ) else (
        echo.
        echo.Invalid option.
        echo.
        echo ---------------------------------------------------------------------------------
        echo.
        echo   	=== Press any key to return to the main menu ===
        echo.
        echo ---------------------------------------------------------------------------------
        echo.
        pause>nul
        goto youtube
    )
    goto youtube
goto :eof
cls
:: /*************************************************************************************/
:: Download video.
:: void video();
:: /*************************************************************************************/
:video
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste video URL below (right click - Paste) and press Enter
    echo.
    set /P "VideoUrl=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    for /f "delims=" %%a in ('youtube-dl --skip-download --get-filename "%VideoUrl%"') do @set VideoFileName=%%a
    echo File: %VideoFileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%VideoUrl%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%VideoDestDir%\%VideoFileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%VideoFileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_video
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_video
     If /I "%choice%"=="N" goto no_video
     echo Incorrect input & goto choice_video
     rem If yes, rename the video file
     :yes_video
       echo Rename the file "%VideoFileName%" ...
       ren "%VideoDestDir%\%VideoFileName%" "backup_%VideoFileName%"
       echo Done.
       goto down_video
     rem If no, delete the video file
     :no_video
       echo Delete the file "%VideoFileName%" ...
       del "%VideoDestDir%\%VideoFileName%"
       echo Done.
       goto down_video
    ) else (
     goto down_video
    )
    :down_video
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download video file ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    youtube-dl.exe --quiet --no-part --newline --console-title --continue -f mp4 "%VideoUrl%" -o "%VideoDestDir%\%%(title)s-%%(id)s.%%(ext)s"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%VideoDestDir%\%VideoFileName%" (
     echo The video files "%VideoFileName%" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%VideoDestDir%"
     goto close_video
    ) else (
     echo The video files "%VideoFileName%" could not be downloaded! Try again later.
     goto close_video
    )
    :close_video
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto youtube
goto :eof
cls
:: /*************************************************************************************/
:: Download audio.
:: void audio();
:: /*************************************************************************************/
:audio
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Paste video URL below (right click - Paste) and press Enter
    echo.
    set /P "AudioUrl=URL: "
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    for /f "delims=" %%a in ('youtube-dl --skip-download --get-filename "%AudioUrl%"') do @set AudioFileName=%%a
    echo File: %AudioFileName%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    FOR /F "tokens=1,2,3,4,5 delims=/" %%A IN ("%AudioUrl%") DO set "Domain=%%B"
    echo Domain: %Domain%
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    if exist "%AudioDestDir%\%AudioFileName%" (
     echo.
     echo Warning!
     echo.
     echo This file "%AudioFileName%" already exists.
     echo.
     echo Type "Y" and rename the file.
     echo.
     echo Type "N" and delete the file.
     echo.
     :choice_audio
     set /P "choice=Are you sure you want to continue [Y/N]?: %=%"
     If /I "%choice%"=="Y" goto yes_audio
     If /I "%choice%"=="N" goto no_audio
     echo Incorrect input & goto choice_audio
     rem If yes, rename the audio file
     :yes_audio
       echo Rename the file "%AudioFileName%" ...
       ren "%AudioDestDir%\%AudioFileName%" "backup_%AudioFileName%"
       echo Done.
       goto down_audio
     rem If no, delete the audio file
     :no_audio
       echo Delete the file "%AudioFileName%" ...
       del "%AudioDestDir%\%AudioFileName%"
       echo Done.
       goto down_audio
    ) else (
     goto down_audio
    )
    :down_audio
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Start Download audio file ...
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    youtube-dl.exe --quiet --no-part --newline --console-title --continue -x -f bestaudio --audio-quality 0 --audio-format mp3 "%AudioUrl%" -o "%AudioDestDir%\%%(title)s-%%(id)s.%%(ext)s"
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    for %%g in ("%AudioDestDir%\%AudioFileName%") do set "MP3FileName=%%~ng"
    echo %MP3FileName%
    echo.
    if exist "%AudioDestDir%\%MP3FileName%.mp3" (
     echo The audio files "%MP3FileName%.mp3" has been sucessfully downloaded!
     %SystemRoot%\explorer.exe "%AudioDestDir%"
     goto close_audio
    ) else (
     echo The audio files "%MP3FileName%.mp3" could not be downloaded! Try again later.
     goto close_audio
    )
    :close_audio
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto youtube
goto :eof
cls
:: /*************************************************************************************/
:: Youtube-dl update.
:: void update();
:: /*************************************************************************************/
:update
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Check for updates
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    youtube-dl.exe -U
    echo.
    echo Successful update!
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto youtube
goto :eof
cls
:: /*************************************************************************************/
:: Youtube-dl help.
:: void help();
:: /*************************************************************************************/
:help
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo Youtube-dl help
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    rem expression "%~dp0Bin" means the location of an executing batch file
    cd /d "Bin"
    youtube-dl.exe --help
    echo.
    echo Done!
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    cls
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    echo   	=== Press any key to return to the main menu ===
    echo.
    echo ---------------------------------------------------------------------------------
    echo.
    pause>nul
    goto youtube
goto :eof
cls
:: /*************************************************************************************/
:: End tool.
:: void close();
:: /*************************************************************************************/
:close
goto :eof
ENDLOCAL
exit