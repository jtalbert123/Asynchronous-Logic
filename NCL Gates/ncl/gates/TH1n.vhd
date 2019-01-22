library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- an OR gate
entity TH1n is
  generic(N : integer := 2);
  port(isig : in  std_logic_vector(0 to N-1);
       osig : out std_logic := '0');
end TH1n;

architecture simple of TH1n is
  signal fb : std_logic;
begin

  osig <= fb;

  process(isig, fb) begin
    if (to_integer(unsigned(isig)) = 0) then fb <= '0';
    else fb <= '1';
    end if;
  end process;
  
end simple;
