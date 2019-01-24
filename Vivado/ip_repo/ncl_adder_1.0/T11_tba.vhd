library ieee;
use ieee.std_logic_1164.all;
library ncl;

use ncl.ncl.all;

entity T11_tba is
  port(finished : out std_logic := '0');
end entity T11_tba;

architecture testbench of T11_tba is
  signal inputs  : std_logic_vector(0 to 0) := "0";
  signal outputs : std_logic;
begin
  
  gate : ncl.TH12
         port map(inputs => inputs,
                  output => outputs);
  
  process
  begin
    inputs <= "0";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;

    inputs <= "1";
    wait for 50 ns;
    ASSERT outputs='1' REPORT "Expected 1" SEVERITY ERROR;

    inputs <= "0";
    wait for 50 ns;
    ASSERT outputs='0' REPORT "Expected 0" SEVERITY ERROR;

    finished <= '1';

    wait;
  end process;
  
end testbench;