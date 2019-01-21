library ieee;
use ieee.std_logic_1164.all;

entity TH22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
end TH22;

architecture simple of TH22 is
  signal fb : std_logic;
begin

  osig <= fb;

  process(iA, iB, fb) begin
    if (iA AND iB) = '1' then fb <= '1';
    elsif (iA OR iB) = '0' then osig <= '0';
    else osig <= fb;
    end if;
  end process;
  
end simple;