@echo off
set xv_path=Z:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 2e9d4f6c94d346d3a746a82b893921bb -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot task2_tb_behav xil_defaultlib.task2_tb -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
