library ieee;
use ieee.std_logic_1164.all;

entity TH34w3 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
end TH34w3;

architecture simple of TH34w3 is
  signal fb : std_logic;
begin

  osig <= fb;

  process(iA, iB, iC, iD, fb) begin
    if (iA OR (iB AND iC AND iD)) = '1' then fb <= '1';
    elsif (iA OR iB OR iC OR iD) = '0' then fb <= '0';
    else fb <= fb;
    end if;
  end process;
  
end simple;