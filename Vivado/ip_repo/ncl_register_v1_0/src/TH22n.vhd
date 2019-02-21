library ieee;
use ieee.std_logic_1164.all;

entity TH22n is
  port(iA : in  std_logic;
       iB : in  std_logic;
       reset : in  std_logic;
       osig : out std_logic := '0');
end TH22n;

architecture simple of TH22n is
  signal fb : std_logic;
  signal LUT4_inputs : std_logic_vector(3 downto 0);
begin
  LUT4_inputs <= iA & iB & fb & reset; 
  osig <= fb;
  
  with LUT4_inputs select fb <= 
    '0' when "0000",
    '0' when "0001",
    '0' when "0010",
    '0' when "0011",
    '0' when "0100",
    '0' when "0101",
    '1' when "0110",
    '0' when "0111",
    '0' when "1000",
    '0' when "1001",
    '1' when "1010",
    '0' when "1011",
    '1' when "1100",
    '0' when "1101",
    '1' when "1110",
    '0' when "1111",
	'0' when others;
     
end simple;