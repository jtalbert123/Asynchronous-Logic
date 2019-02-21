library ieee;
use ieee.std_logic_1164.all;

entity TH12 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
end TH12;

architecture simple of TH12 is
  signal fb : std_logic;
  signal LUT3_inputs : std_logic_vector(1 downto 0);
begin
  LUT3_inputs <= iA & iB;

  with LUT3_inputs select osig <= 
    '0' when "00",
    '1' when "01",
    '1' when "10",
    '1' when "11",
	'0' when others;
    
end simple;