@echo off
set xv_path=Z:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 9de417feb94c4ae3b74eb02760e8bfaa -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot encoder_tb_behav xil_defaultlib.encoder_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
