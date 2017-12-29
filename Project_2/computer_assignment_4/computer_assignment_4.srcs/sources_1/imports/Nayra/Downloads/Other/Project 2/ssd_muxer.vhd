----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:
-- Design Name: 
-- Module Name: top_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd_muxer is
Port (
	a_in       : in  std_logic_vector(3 downto 0);
	b_in       : in  std_logic_vector(3 downto 0);
	c_in       : in  std_logic_vector(3 downto 0);
	d_in       : in  std_logic_vector(3 downto 0);
	e_in       : in  std_logic_vector(3 downto 0);
	f_in       : in  std_logic_vector(3 downto 0);
	g_in       : in  std_logic_vector(3 downto 0);
	decp0_in   : in  std_logic;
	decp1_in   : in  std_logic;
	decp2_in   : in  std_logic;
	decp3_in   : in  std_logic;
	seg_out    : out std_logic_vector(6 downto 0);
	dp_out     : out std_logic;
	an_out     : out std_logic_vector(3 downto 0);
	clk        : in  STD_LOGIC
);
end ssd_muxer;

architecture Behavioral of ssd_muxer is
	--counter signals~
	constant counter_max  : unsigned(15 downto 0) := x"8000"; --fpga
	--constant counter_max  : unsigned(15 downto 0) := x"0002"; --sim
	signal   counter_sel  : unsigned(1  downto 0) :=  "00";
	signal   counter      : unsigned(15 downto 0) := x"0000";

	--so we can combine and negate
	signal a, b, c, d     : std_logic;
	signal e, f, g        : std_logic;
	signal ssd0_en        : std_logic;
	signal ssd1_en        : std_logic;
	signal ssd2_en        : std_logic;
	signal ssd3_en        : std_logic;
	signal decp           : std_logic;
	
begin
	-- _everything_ is active low (enabled when low)
	seg_out <= not(g & f & e & d & c & b & a);
	an_out  <= not(ssd3_en & ssd2_en & ssd1_en & ssd0_en);
	dp_out  <= not(decp);


	--muxing the inputs to the output
	a <= a_in(0) when (counter_sel="00") else
	     a_in(1) when (counter_sel="01") else
	     a_in(2) when (counter_sel="10") else
	     a_in(3);

	b <= b_in(0) when (counter_sel="00") else
	     b_in(1) when (counter_sel="01") else
	     b_in(2) when (counter_sel="10") else
	     b_in(3);

	c <= c_in(0) when (counter_sel="00") else
	     c_in(1) when (counter_sel="01") else
	     c_in(2) when (counter_sel="10") else
	     c_in(3);

	d <= d_in(0) when (counter_sel="00") else
	     d_in(1) when (counter_sel="01") else
	     d_in(2) when (counter_sel="10") else
	     d_in(3);

	e <= e_in(0) when (counter_sel="00") else
	     e_in(1) when (counter_sel="01") else
	     e_in(2) when (counter_sel="10") else
	     e_in(3);

	f <= f_in(0) when (counter_sel="00") else
	     f_in(1) when (counter_sel="01") else
	     f_in(2) when (counter_sel="10") else
	     f_in(3);

	g <= g_in(0) when (counter_sel="00") else
	     g_in(1) when (counter_sel="01") else
	     g_in(2) when (counter_sel="10") else
	     g_in(3);



	--selects the decimal point for the active chip inputs
	decp <= decp0_in when (counter_sel="00") else
	        decp1_in when (counter_sel="01") else
	        decp2_in when (counter_sel="10") else
	        decp3_in;
	
	--selects the active low enable for the digit
	ssd0_en <= '1' when (counter_sel="00") else '0';
	ssd1_en <= '1' when (counter_sel="01") else '0';
	ssd2_en <= '1' when (counter_sel="10") else '0';
	ssd3_en <= '1' when (counter_sel="11") else '0';
		
	--simple counter proc and changes the sel
	counter_proc: process (clk)
	begin
		if (clk'event and clk='1') then
			if (counter >= counter_max) then
				counter      <= x"0000";
				counter_sel <= counter_sel + 1;
			else
				counter      <= counter + 1;
			end if;
		end if;
	end process counter_proc;

end Behavioral;
