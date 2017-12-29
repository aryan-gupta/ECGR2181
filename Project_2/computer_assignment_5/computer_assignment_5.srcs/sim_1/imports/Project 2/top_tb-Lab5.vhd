----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2015 05:46:51 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_tb is
--  Port ( );
end top_tb;

architecture Behavioral of top_tb is

	component top is
	Port (
		sw       : in  STD_LOGIC_VECTOR (7 downto 0);
		btnL     : in  std_logic;
		btnR     : in  std_logic;
		led      : out STD_LOGIC_VECTOR (15 downto 0);
		clk      : in  std_logic
	);
	end component;

	constant clk_per : time := 10ns;

	signal sw        : std_logic_vector(7 downto 0);
	signal led       : STD_LOGIC_VECTOR (15 downto 0);
	signal btnL      : std_logic;
	signal btnR      : std_logic;
	signal clk       : std_logic := '0';
	

begin


	uut: top port map (
		sw     => sw,
		led    => led,
		btnL   => btnL,
		btnR   => btnR,
		clk    => clk
	);		
	
	-- testing every 4 clock cycles at end 
	btnL_proc: process
	begin
		btnL <= '0';
		wait for clk_per*3;
		
		btnL <= '1';
		wait for clk_per*1;
	end process btnL_proc;

	--setting every 4 clock cycles at 1  
	btnR_proc: process
	begin
		--check one start
		btnR <= '0';
		wait for clk_per*1;

		btnR <= '1';
		wait for clk_per*1;
		
		btnR <= '0';
		wait for clk_per*2;
	end process btnR_proc;

	sw_proc: process
	begin
		--setting 1
		sw <= x"07";
		wait for clk_per*2;
	
		--testing 1
		sw <= x"07";
		wait for clk_per*2;

		--setting 2
		sw <= x"2a";
		wait for clk_per*2;
	
		--testing 2
		sw <= x"31";
		wait for clk_per*2;

		--setting 3
		sw <= x"42";
		wait for clk_per*2;
	
		--testing 3
		sw <= x"42";
		wait for clk_per*2;

		--setting 4
		sw <= x"89";
		wait for clk_per*2;
	
		--testing 4
		sw <= x"4e";
		wait for clk_per*2;
		
		--force end
		wait for clk_per*2;
		assert false report "end of simulation" severity failure;
	end process sw_proc;

	clk_proc: process
	begin
		wait for clk_per/2;
		clk <= not(clk);
	end process clk_proc;


end Behavioral;
