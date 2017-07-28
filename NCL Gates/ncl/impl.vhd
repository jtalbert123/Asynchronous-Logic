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
  signal sOut : std_logic;
begin

  output <= sOut after Delay;
  
  ThresholdGate: process(inputs)
    variable num_1 : integer;
  begin
    num_1 := 0;
    for i in 0 to N-1 loop
      if inputs(i) = '1' then
        num_1 := num_1 + 1;
      end if;
    end loop;
    if num_1 >= M then
      sOut <= '1';
    elsif num_1 = 0 then
      sOut <= '0';
    end if;
  end process;
end simple;


library ieee;
use ieee.std_logic_1164.all;

use work.ncl.all;

entity THxor0 is
  generic(Delay : time := 1 ns);
  port(A, B, C, D : in  std_logic;
       output : out std_logic);
end THxor0;

architecture behavioral of THxor0 is
  
begin
  process (A, B, C, D)
  begin
    if (A = '0' and B = '0' and C = '0' and D = '0') then
      output <= '0';
    elsif ((A and B) or (C and D)) = '1' then
      output <= '1';
    end if;
  end process;
end behavioral;
