----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2017 07:17:01 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  Port (
    sw   : in std_logic_vector(7 downto 0);
    btnR : in std_logic;
    btnL : in std_logic;
    clk  : in std_logic;
    
    led  : out std_logic_vector(15 downto 0)
  );
end top;

architecture Behavioral of top is
    component debounce is 
        Port ( 
               CLK_100M : in std_logic;
               SW       : in std_logic;
               sglPulse : out std_logic;
               Sig      : out std_logic
        );
    end component;
    signal reset, test : std_logic := '0';
    
    signal value : std_logic_vector(7 downto 0);
    
begin

    DEBL: debounce port map (
        CLK_100M => clk,
        SW => btnL,
        sglPulse => open,
        Sig => test    
    );
    
    DEBR: debounce port map (
        CLK_100M => clk,
        SW => btnR,
        sglPulse => open,
        Sig => reset    
    );

--    test <= btnL;
--    reset <= btnR;
    
    --led(15) <= '0';
    led(14) <= '0';
    led(13) <= '0';
    led(12) <= '0';
    led(11) <= '0';
    led(10) <= '0';
    led(9) <= '0';
    led(8) <= '0';
    led(7) <= sw(7);
    led(6) <= sw(6);
    led(5) <= sw(5);
    led(4) <= sw(4);
    led(3) <= sw(3);
    led(2) <= sw(2);
    led(1) <= sw(1);
    led(0) <= sw(0);
    
    GUESS: process (test)
        variable led_15 : std_logic := '0';
    begin
        if (reset = '1') then
            value <= sw;
            led_15 := '0';
        end if;
    
        if (test = '1') then
            if (value = sw) then
                led_15 := '1';
            else 
                led_15 := '0';
            end if;
            
            value <= value;
        end if;
        
        led(15) <= led_15;
    end process GUESS;

end Behavioral;
