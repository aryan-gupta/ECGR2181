library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task1_tb is
--  Port ( );
end task1_tb;

architecture Behavioral of task1_tb is

	--declaring the component
	component task1
	    Port ( 
		   a : in STD_LOGIC;
           b : in STD_LOGIC;
		   y : out STD_LOGIC);
	end component;

	--declaring the signals needed
	--these a, b, and y signals are different from the
	--internal ones of the component
	signal a, b, y : std_logic;
	
	--signal to assign values to a and b
	signal counter : unsigned(1 downto 0) := "00";

begin
	-- component assignment
	uut: task1 port map(
		a => a,
		b => b,
		y => y
	);

	--assign a (bit 1) and b (bit 0) to the counter bits so that
	--all possible inputs are tested
	--Enter your code 
	a <= counter(1);
	b <= counter(0);
	
	--increments the counter using a process
	--use a 20ns delay between each combination
	--Enter your code here
	tb : process is
	begin
		wait for 20ns;
		counter <= counter + 1;
	end process tb;

end Behavioral;