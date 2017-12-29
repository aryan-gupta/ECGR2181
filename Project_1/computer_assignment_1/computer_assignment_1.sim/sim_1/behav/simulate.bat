@echo off
set xv_path=Z:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xsim task1_tb_behav -key {Behavioral:sim_1:Functional:task1_tb} -tclbatch task1_tb.tcl -view Z:/Users/Nayra/Documents/ECGR2181/Project_1/computer_assignment_1/task1_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
