library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task2 is
    Port ( 
		   a   : in STD_LOGIC;
           b   : in STD_LOGIC;
		   cin : in STD_LOGIC;
           sum : out STD_LOGIC;
		   cout: out STD_LOGIC);
end task2;

architecture Behavioral of task2 is

begin

-- Enter your code here
	sum <= a xor b xor cin;
	cout <= (a and b) or (a and cin) or (b and cin);

end Behavioral;