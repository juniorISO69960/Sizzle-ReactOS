@echo off
::Joe's simple shitty script for intializating a developer prompt for ReactOS with Visual Studio

::Variables
::change these to match your directory or maybe I will just add the code to allow you to change it when executing this
::too lazy right now
set RoSBEDir=E:\source\RosBE
set ReactDir=E:\source\RoS\reactos-master

::move to our directory
pushd %reactdir%
::set BISON variable
set BISON_PKGDATADIR=%RosBEDir\share\bison
::set M4 variable
set M4=%RosBEDir%\bin\m4.exe

::our new choice picker whether to execute and generate solution files or tell the user how to
set /P solutionMakerChoice=Generate Visual Studio solutions now[Y/N][Y]?
if /I "%solutionMakerChoice%" EQU "Y" goto :generate_solutions
if /I "%solutionMakerChoice%" EQU "N" goto :exit
if /I "%solutionMakerChoice%" EQU "" goto :generate_solutions

::generate solutions call
:generate_solutions
%ReactDir%\configure.cmd VSSolution -DENABLE_ROSTESTS=1 -DENABLE_ROSAPPS=1

::exit mode
::Tell a dumb dumb what to do
:exit
echo run %ReactDir%\configure.cmd VSSolution -DENABLE_ROSTESTS=1 -DENABLE_ROSAPPS=1
pause