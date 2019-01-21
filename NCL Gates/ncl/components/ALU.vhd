library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity ALU is
  generic (NumBits : integer := 4);
  port(Operation : in ncl_pair_vector(0 to 2);
           iA        : in ncl_pair_vector(0 to NumBits - 1);
           iB        : in ncl_pair_vector(0 to NumBits - 1);
           output   : out ncl_pair_vector(0 to NumBits - 1));
end entity ALU;


           
architecture structural of ALU  is
  
begin
  
end structural;