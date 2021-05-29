@echo off
::Joe's simple shitty script for intializating a developer prompt for ReactOS with Visual Studio
::now git compatable!
::Created 5-27-21

::TODO: add detection for whether or not we are running within a VS command prompt window. 

::Variables
::change these to match your directory or maybe I will just add the code to allow you to change it when executing this
::too lazy right now

::presetting parameters
set RoSBEDir=
set RoSSrcDir=

::parameters that we can use
::help parameters
if "%1" == "help" goto Usage
if "%1" == "-?" goto Usage
if "%1" == "/?" goto Usage
if "%1" == "-help" goto Usage
if "%1" == "/help" goto Usage
::directory parameters
if /I "%1" == "RoSBE_dir" set RosBEDir=%2
if /I "%3" == "RoSSrc_dir" set RoSSrcDir=%4

echo %RosBEDir%
echo %RosSrcDir%

::if the variables are blank, don't use them and use our defaults, which will be straight
::from react OS's website
if "%RosBEDir%" == "" (
    set RosBEDir=C:\RosBEDir
    ::tell the idiot he/she didn't set the environments are we are using defaults
    echo React OS build environment not set. Using default directory!
)
if "%RosSrcDir%" == "" (
    set RoSSrcDir=C:\RoSSrcDir
    ::again, tell them no var was set
    echo React OS source directory not set. Using default directory!
)


::make our directory? or add code that can see if it exists already or not
mkdir %RosSrcDir%\VSSolutions
::move to our directory
pushd %RosSrcDir%\VSSolutions
::set BISON variable
set BISON_PKGDATADIR=%RosBEDir%\share\bison
::set M4 variable
set M4=%RosBEDir%\bin\m4.exe

::our new choice picker whether to execute and generate solution files or tell the user how to
set /P solutionMakerChoice=Generate Visual Studio solutions now[Y/N][Y]?
if /I "%solutionMakerChoice%" EQU "Y" goto :generate_solutions
if /I "%solutionMakerChoice%" EQU "N" goto :exitRunCommand
if /I "%solutionMakerChoice%" EQU "" goto :generate_solutions


::functions are PLACED HERE

::help menu
:Usage
echo ------------------------------------------------------------------------------------------------------------
echo Sizzle Help Menu
echo Valid Parameters:
echo 1. RoSBE_dir: sets the build environment directory. Defaults to C:\RoSBE, ex: RoSBE_dir=C:\RosBE
echo 2. RoSSrc_dir: sets the ReactOS source directory. Defaults to C:\RosSrcDir, ex: RoSSrc_dir=C:\reactos-master
echo 3. Help: displays parameters and info for sizzle.bat
echo ------------------------------------------------------------------------------------------------------------
goto :exit
::generate solutions call
:generate_solutions
%RosSrcDir%\configure.cmd VSSolution -DENABLE_ROSTESTS=1 -DENABLE_ROSAPPS=1

::exit mode
::Tell a dumb dumb what to do
:exitRunCommand
echo run %RosSrcDir%\configure.cmd VSSolution -DENABLE_ROSTESTS=1 -DENABLE_ROSAPPS=1 to generate solutions. 
goto :exit

::just exits the program, simple
:exit
pause