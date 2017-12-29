----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2017 01:22:39 PM
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
use IEEE.NUMERIC_STD.ALL;

--use IEEE.std_logic_arith.all;
--use IEEE.std_logic_unsigned.all;

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
    
    seg  : out std_logic_vector(6 downto 0);
    dp   : out std_logic;
    an   : out std_logic_vector(3 downto 0);
    led  : out std_logic_vector(7 downto 0)
  );
end top;

architecture Behavioral of top is

    component encoder is
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
    end component encoder;
    
    
    component ssd_muxer is
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
    end component ssd_muxer;
    signal a_in, b_in, c_in, d_in, e_in, f_in, g_in : std_logic_vector(3 downto 0) := "0000";
    
    component debounce is
      Port ( 
           CLK_100M : in std_logic;
           SW       : in std_logic;
           sglPulse : out std_logic;
           Sig      : out std_logic);
    end component debounce;
    signal sglPulse : std_logic_vector(2 downto 0);
    signal Sig : std_logic_vector(2 downto 0);
    
    signal accum : std_logic_vector(7 downto 0);
    
    --signal hundreds, tens, ones : unsigned(7 downto 0);
    
    --signal bcd : std_logic_vector(11 downto 0) := "00";
    
begin

    led <= sw;
    
    DEBR: debounce port map (
        CLK_100M => clk,
        SW => btnR,
        sglPulse => sglPulse(0),
        Sig => Sig(0)
    );
    
    DEBL: debounce port map (
        CLK_100M => clk,
        SW => btnL,
        sglPulse => sglPulse(1),
        Sig => Sig(1)
    );
    
    -- set up all the connectors
    -- A true master starts at 0 (who am I kidding?)
    ENC0: encoder port map (
        hex_in => accum(3 downto 0),
        a => a_in(0),
        b => b_in(0),
        c => c_in(0),
        d => d_in(0),
        e => e_in(0),
        f => f_in(0),
        g => g_in(0) 
    );
        
    ENC1: encoder port map (
        hex_in => accum(7 downto 4),
        a => a_in(1),
        b => b_in(1),
        c => c_in(1),
        d => d_in(1),
        e => e_in(1),
        f => f_in(1),
        g => g_in(1) 
    );
    
--    ENC2: encoder port map (
--        hex_in => bcd(3 downto 0),
--        a => a_in(0),
--        b => b_in(0),
--        c => c_in(0),
--        d => d_in(0),
--        e => e_in(0),
--        f => f_in(0),
--        g => g_in(0) 
--    );

    a_in(2) <= '0';
    b_in(2) <= '0';
    c_in(2) <= '0';
    d_in(2) <= '0';
    e_in(2) <= '0';
    f_in(2) <= '0';
    --g_in(2) <= '0';
    a_in(3) <= '0';
    b_in(3) <= '0';
    c_in(3) <= '0';
    d_in(3) <= '0';
    e_in(3) <= '0';
    f_in(3) <= '0';
    g_in(3) <= '0';
    
    
    MUX: ssd_muxer port map (
        a_in => a_in,
        b_in => b_in,
        c_in => c_in,
        d_in => d_in,
        e_in => e_in,
        f_in => f_in,
        g_in => g_in,
        
        decp0_in => '0',
        decp1_in => '0',
        decp2_in => '0',
        decp3_in => '0',
        
        seg_out => seg,
        dp_out => dp,
        an_out => an,
        
        clk => clk
    );
    
    --bcd <= conv_std_logic_vector(hundreds, 4) & conv_std_logic_vector(tens, 4) & conv_std_logic_vector(ones, 4);
    
    LOGIC: process (accum, sw, Sig)
        variable counter : unsigned(3 downto 0) := "0000";
        variable temp    : std_logic_vector(7 downto 0) := "00000000";
    begin 
        if (Sig(1) = '1') then -- if we hit the accumulate button (button left)
            if (sw(7) = '1') then -- we got a negative value from out switches
                for counter in 0 to 7 loop 
                    if (sw(counter) = '0') then
                        temp(counter) := '1';
                    else 
                        temp(counter) := '0';
                    end if;
                end loop;
                accum <= std_logic_vector(unsigned(temp) + 1); -- convert to insiged so we can use + overload 
                g_in(2) <= '1';
            else -- not negative
                accum <= sw;
                g_in(2) <= '0';
            end if;
        else 
            accum <= accum; -- store old value 
        end if;
        
        if (Sig(0) = '1') then -- if Sig 2 is on then we want to reset the accum
            accum <= "00000000";
            g_in(2) <= '0';
        end if;
    end process LOGIC;
    

end Behavioral;
