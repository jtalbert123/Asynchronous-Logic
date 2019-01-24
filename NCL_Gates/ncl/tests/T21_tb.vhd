library ieee;
use ieee.std_logic_1164.all;

use work.ncl.all;

entity T21_tb is
  port(finished : out std_logic := '0');
end entity T21_tb;

architecture testbench of T21_tb is
  signal inputs  : std_logic_vector(0 to 1) := "00";
  signal outputs : std_logic;
begin
  
  gate : THmn
         generic map(N => 2,
                     M => 1)
         port map(inputs => inputs,
                  output => outputs);
  
  process
  begin
    -- 00 -> 01
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 00 -> 10
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 00 -> 11
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------
    
    -- 01 -> 00
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 01 -> 10
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 01 -> 11
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------

    -- 10 -> 00
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "00";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;
    
    -- 10 -> 01
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "01";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
    -- 10 -> 11
    inputs <= "10";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    inputs <= "11";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;
    
-------------------------------------------------------------

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