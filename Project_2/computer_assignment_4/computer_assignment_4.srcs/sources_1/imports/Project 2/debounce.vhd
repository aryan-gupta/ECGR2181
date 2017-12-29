library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debounce is
  Port ( CLK_100M  : in std_logic;
         SW       : in std_logic;
         sglPulse : out std_logic;
         Sig      : out std_logic);
end debounce;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture Behavioral of debounce is
  type stateType is (Rest, Kounting, wait4zero, singlePulse, deadTime);
  signal state, nextState : stateType := Rest;
  
  signal k           : std_logic_vector (20 downto 0);
  constant kountTime : std_logic_vector (20 downto 0) := (others => '1');

-------------------------------------------------------------------------------
-- BEGIN
-------------------------------------------------------------------------------
begin

  
  -- stateMemory 
  process (CLK_100M)
  begin
    if CLK_100M'event and CLK_100M = '1' then
      state <= nextState;
      if state = Kounting or state = deadTime then k <= k + 1; end if;
      if state = wait4zero or state = Rest then k <= (others => '0'); end if;
    end if;
  end process;
  
  -- nextState_logic 
  process (k, state, SW)
  begin
    case state is
      
      when Rest =>
        if SW = '1' then 
          nextState <= Kounting; 
        else
          nextState <= Rest;
        end if;
        
      when Kounting =>
        -- wait for 10.5 msec.(kountTime * 10 nsec.) before going to wait4zero state
        if k < kountTime then
          nextState <= Kounting;
        else
          nextState <= wait4zero;
        end if;
        
      when wait4zero =>
        -- wait for the user to release the switch
        if SW = '1' then 
          nextState <= wait4zero;
        else
          nextState <= singlePulse;
        end if;
        
      when singlePulse =>
        nextState <= deadTime;
        
      when deadTime =>				
        -- wait for 10.5 msec. (kountTime * 20 nsec.) before going to the Rest state
        if k < kountTime then
          nextState <= deadTime;
        else
          nextState <= Rest;
        end if;
        
      when others =>
        nextState <= Rest;
        
    end case;
    
  end process;
  
  -- Output variables
  
  sig <= '1' when (state = Kounting or state = wait4zero) else '0';
  
  sglPulse <= '1' when state = singlePulse else '0';
  
end Behavioral;
  
