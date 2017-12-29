library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task2_tb is
--  Port ( );
end task2_tb;

architecture Behavioral of task2_tb is

	--declaring the component
	component task2
	    Port ( 
		   a   : in STD_LOGIC;
           b   : in STD_LOGIC;
		   cin : in STD_LOGIC;
           sum : out STD_LOGIC;
		   cout: out STD_LOGIC);
	end component;

	--declaring the signals needed
	--these a, b, cin, sum, cout signals are different from the
	--internal ones of the component
	signal a, b, cin, sum, cout : std_logic;
	
	--signal to iterate over all 3 variables and their possible values
	signal counter : unsigned(2 downto 0) := "000";

begin
	-- component assignment
	uut: task2 port map(
		a => a,
		b => b,
		cin => cin,
		sum => sum,
		cout => cout
	);

	--assign a, b, cin (order is: a [MSB], b, cin [LSB])to the counter bits so that
	--all possible inputs are tested
	--Enter your code here
	a   <= counter(2);
	b   <= counter(1);
	cin <= counter(0);
	
	tb : process
	begin       	       
		wait for 20ns;
		counter <= counter + 1;
	end process tb;
	--increments the counter using a process
	--use a 20ns delay between each combination
	--Enter your code here


end Behavioral;