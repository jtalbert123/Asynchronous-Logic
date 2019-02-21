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
  signal LUT4_inputs : std_logic_vector(3 downto 0);
begin
  LUT4_inputs <= iA & iB & iC & fb; 
  osig <= fb;
  
  with LUT4_inputs select fb <= 
    '0' when "0000",
    '0' when "0001",
    '0' when "0010",
    '1' when "0011",
    '0' when "0100",
    '1' when "0101",
    '0' when "0110",
    '1' when "0111",
    '0' when "1000",
    '1' when "1001",
    '0' when "1010",
    '1' when "1011",
    '0' when "1100",
    '1' when "1101",
    '1' when "1110",
    '1' when "1111",
	'0' when others;
     
end simple;