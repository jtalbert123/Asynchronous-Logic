library ieee;
use ieee.std_logic_1164.all;

entity TH12 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
end TH12;

architecture simple of TH12 is
  signal fb : std_logic;
begin

  osig <= fb;

  process(iA, iB, fb) begin
    if (iA OR iB) = '1' then fb <= '1';
    elsif (iA OR iB) = '0' then fb <= '0';
    else fb <= fb;
    end if;
  end process;
  
end simple;