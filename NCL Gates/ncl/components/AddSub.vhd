library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity AddSub is
  generic(NumBits : integer := 4);
  port(iA        : in ncl_pair_vector(0 to NumBits-1);
       iB        : in ncl_pair_vector(0 to NumBits-1);
       Operation : in ncl_pair;

       oS       : out ncl_pair_vector(0 to NumBits-1);
       oC       : out ncl_pair);
end AddSub;

architecture structural of AddSub is

  -- iB into adder, potentially inverted from entity input
  signal adder_iB : ncl_pair_vector(0 to NumBits-1);

begin

  plainAdder: Adder
    generic map(NumAdderBits => NumBits)
    port map(iC => Operation,
             iA => iA,
             iB => adder_iB,
             oS => oS,
             oC => oC);

  bits: for iBit in 0 to NumBits-1 generate

    inverter0: THxor0 -- DATA0, Potentially inverted
      port map(A => iB(iBit).DATA0,
               B => Operation.DATA0,
               C => iB(iBit).DATA1,
               D => Operation.DATA1,
               output => adder_iB(iBit).DATA0);

    inverter1: THxor0 -- DATA1, Potentially inverted
      port map(A => iB(iBit).DATA0,
               B => Operation.DATA1,
               C => iB(iBit).DATA1,
               D => Operation.DATA0,
               output => adder_iB(iBit).DATA1);

  end generate;

end structural;
