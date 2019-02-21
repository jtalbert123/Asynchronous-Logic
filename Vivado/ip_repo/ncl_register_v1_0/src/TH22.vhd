library ieee;
use ieee.std_logic_1164.all;

entity TH22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
end TH22;

architecture simple of TH22 is
  signal fb : std_logic;
  signal LUT3_inputs : std_logic_vector(2 downto 0);
begin
  LUT3_inputs <= iA & iB & fb; 
  osig <= fb;
  
  with LUT3_inputs select fb <= 
    '0' when "000",
    '0' when "001",
    '0' when "010",
    '1' when "011",
    '0' when "100",
    '1' when "101",
    '1' when "110",
    '1' when "111",
	'0' when others;
     
end simple;