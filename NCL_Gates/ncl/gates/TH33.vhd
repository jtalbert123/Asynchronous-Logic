library ieee;
use ieee.std_logic_1164.all;

entity TH33 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
end TH33;

architecture simple of TH33 is
  signal fb : std_logic;
begin

  osig <= fb;

  process(iA, iB, iC, fb) begin
    if (iA AND iB AND iC) = '1' then fb <= '1';
    elsif (iA OR iB OR iC) = '0' then fb <= '0';
    else fb <= fb;
    end if;
  end process;
  
end simple;