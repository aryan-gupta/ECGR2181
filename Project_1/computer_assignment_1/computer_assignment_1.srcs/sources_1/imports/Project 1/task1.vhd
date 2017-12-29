library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity task1 is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
		   y : out STD_LOGIC);
end task1;


architecture Behavioral of task1 is
	
begin

-- Enter your code here.
    y <= a and b; -- get a and b and store it in y
     
end Behavioral;