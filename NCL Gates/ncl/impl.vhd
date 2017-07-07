library ieee;
use ieee.std_logic_1164.all;

use work.ncl.all;

entity THmn is
  generic(M : integer := 1;
          N : integer := 1;
          Delay : time := 1 ns);
  port(inputs : in  std_logic_vector(0 to N-1);
       output : out std_logic := '0');
end THmn;

architecture simple of THmn is
begin
  
  ThresholdGate: process(inputs)
    --variable num_0 : integer;
    variable num_1 : integer;
    --variable i     : integer;
  begin
    --num_0 := 0;
    num_1 := 0;
    for i in 0 to N-1 loop
      if inputs(i) = '1' then
        num_1 := num_1 + 1;
      --elsif inputs(i) = '0' then
      --  num_0 := num_0 + 1;
      end if;
    end loop;
    if num_1 >= M then
      output <= '1' after Delay;
    elsif num_1 = 0 then
      output <= '0' after Delay;
    end if;
  end process;
end simple;
