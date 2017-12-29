library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity encoder_tb is
--    Port ( );
end encoder_tb;

architecture Behavioral of encoder_tb is

    component encoder
        Port (
              hex_in : in STD_LOGIC_VECTOR(3 DOWNTO 0);
              a : out STD_LOGIC;
              b : out STD_LOGIC;
              c : out STD_LOGIC;
              d : out STD_LOGIC;
              e : out STD_LOGIC;
              f : out STD_LOGIC;
              g : out STD_LOGIC
        );
    end component;
        
    signal counter      : unsigned(3 downto 0):="0000";
    signal hex_in       : std_logic_vector(3 downto 0);
    signal a, b, c, d   : std_logic;
    signal e, f, g      : std_logic;
    
begin
    uut: encoder port map(
        hex_in => hex_in,
        a   => a,
        b   => b,
        c   => c,
        d   => d,
        e   => e,
        f   => f,
		g   => g
    );
     
    hex_in <= std_logic_vector(counter);
     
    --increments the counter using a process
	--use a 20ns delay between each combination
	--Enter your code here
	tb2 : process
    begin
          wait for 20ns;
          counter <= counter + 1;
    end process tb2;

end Behavioral;
