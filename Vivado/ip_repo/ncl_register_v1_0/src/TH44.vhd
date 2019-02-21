library ieee;
use ieee.std_logic_1164.all;

entity TH44 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       reset : in  std_logic;
       osig : out std_logic := '0');
end TH44;

architecture simple of TH44 is
  signal fb : std_logic;
  signal LUT5_inputs : std_logic_vector(4 downto 0);
begin
  LUT5_inputs <= iA & iB & iC & iD & fb; 
  osig <= fb;
  
  with LUT5_inputs select fb <= 
    '0' when "00000",
    '0' when "00001",
    '0' when "00010",
    '1' when "00011",
    '0' when "00100",
    '1' when "00101",
    '0' when "00110",
    '1' when "00111",
    '0' when "01000",
    '1' when "01001",
    '0' when "01010",
    '1' when "01011",
    '0' when "01100",
    '1' when "01101",
    '0' when "01110",
    '1' when "01111",
	'0' when "10000",
    '1' when "10001",
    '0' when "10010",
    '1' when "10011",
    '0' when "10100",
    '1' when "10101",
    '0' when "10110",
    '1' when "10111",
    '0' when "11000",
    '1' when "11001",
    '0' when "11010",
    '1' when "11011",
    '0' when "11100",
    '1' when "11101",
    '1' when "11110",
    '1' when "11111",
	'0' when others;
     
end simple;