library ieee;
use ieee.std_logic_1164.all;

use work.ncl.all;

entity T22_tb is
  port(finished : out std_logic := '0');
end entity T22_tb;

architecture testbench of T22_tb is
  signal inputs  : std_logic_vector(0 to 1) := "00";
  signal outputs : std_logic;
begin
  
  gate : THmn
         generic map(N => 2,
                     M => 2)
         port map(inputs => inputs,
                  output => outputs);
  
  process
  begin
    
-- 00:Off
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 00 -> 01
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 00 -> 10
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 00 -> 11
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------
-- 01:Off
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;

    -- 01(off) -> 00
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 01(off) -> 10
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 01(off) -> 11
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-- 01:On
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;

    -- 01(on) -> 00
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 01(on) -> 10
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 01(on) -> 11
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------
-- 10:Off
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 10(off) -> 00
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 10(off) -> 01
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 10(off) -> 11
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-- 10:On
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 10(on) -> 00
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 10(on) -> 01
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 10(on) -> 11
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------

-- 11
    -- 11 -> 00
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 11 -> 01
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 11 -> 10
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    finished <= '1';
    
    wait;
  end process;
  
end testbench;