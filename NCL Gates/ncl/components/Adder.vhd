library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity Adder is
  generic(NumAdderBits : integer := 4);
  port(iC : in  ncl_pair;
       iA : in  ncl_pair_vector(NumAdderBits-1 downto 0);
       iB : in  ncl_pair_vector(NumAdderBits-1 downto 0);
       oS : out ncl_pair_vector(NumAdderBits-1 downto 0);
       oC : out ncl_pair);
end Adder;

architecture RippleCarry of Adder is

  signal carries : ncl_pair_vector(NumAdderBits downto 0);

begin
  carries(0) <= iC;
  bits: for iBit in NumAdderBits-1 downto 0 generate
    adderBit: FullAdder
      port map(iC => carries(iBit),
               iA => iA(iBit),
               iB => iB(iBit),
               oS => oS(iBit),
               oC => carries(iBit+1));
  end generate;

  oC <= carries(NumAdderBits);

end RippleCarry;