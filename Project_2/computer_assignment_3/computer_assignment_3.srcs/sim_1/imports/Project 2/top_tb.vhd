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

	--this entity needs to be defined in your top.vhd file 
	component top is
	Port (
		sw       : in  STD_LOGIC_VECTOR (15 downto 0);
		seg      : out std_logic_vector(6 downto 0);
		dp       : out std_logic;
		an       : out std_logic_vector(3 downto 0);
		led      : out STD_LOGIC_VECTOR (15 downto 0);
		clk      : in  std_logic
	);
	end component;

	--clock period. Set to 100 MHz here
	constant clk_per : time := 10ns;

	--signals to do the binding to the "top" entity
	signal sw        : std_logic_vector(15 downto 0);
	signal seg       : std_logic_vector(6 downto 0);
	signal dp        : std_logic;
	signal an        : std_logic_vector(3 downto 0);
	signal led       : STD_LOGIC_VECTOR (15 downto 0);
	signal clk       : std_logic := '0';
	
	--signal counter   : unsigned(15 downto 0) := '000000000000000';
begin

	uut: top port map (
		sw     => sw,
		seg    => seg,
		dp     => dp,
		an     => an,
		led    => led,
		clk    => clk
	);		
	
	--add code here to test your outputs for correct operation (change the value of "sw")
	--only needs code to be added in simulation, not in the final file to be uploaded to the FPGA
	--this is step 7 and 8 in Part 1
	
	sw_proc: process
	begin
	    sw <= x"7b10";
	    wait for clk_per;
	end process sw_proc;
	
	--clock process, high and low for half the clock period
	clk_proc: process
	begin
		wait for clk_per;
		clk <= not(clk);
		
		-- counter <= counter + 1;
	end process clk_proc;

end Behavioral;