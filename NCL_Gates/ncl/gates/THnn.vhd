library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- an OR gate
entity THnn is
  generic(N : integer := 2);
  port(isig : in  std_logic_vector(N-1 downto 0);
       osig : out std_logic := '0');
end THnn;

architecture simple of THnn is
  signal fb : std_logic;
begin

  osig <= fb;

  process(isig, fb) begin
    if (to_integer(signed(isig)) = -1) then fb <= '1';
    elsif (to_integer(unsigned(isig)) = 0) then fb <= '0';
    else fb <= fb;
    end if;
  end process;
  
end simple;