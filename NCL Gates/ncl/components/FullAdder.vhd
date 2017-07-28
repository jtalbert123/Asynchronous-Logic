library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity FullAdder is
  port(iC  : in ncl_pair;
       iA    : in ncl_pair;
       iB    : in ncl_pair;
       oS  : out ncl_pair;
       oC : out ncl_pair);
end FullAdder;


architecture structural of FullAdder is
  type first_layer is array (integer range <>) of std_logic_vector(0 to 2);
  signal first_layer_inputs : first_layer(0 to 7);
  signal intermedate : std_logic_vector(0 to 7);
  signal inputs : ncl_pair_vector(0 to 2);

begin
  inputs(2) <= iA;
  inputs(1) <= iB;
  inputs(0) <= iC;
  input_layer: for i in 0 to 7 generate
    bits: for ibit in 0 to 2 generate
      Input0Selection: if (to_unsigned(2**ibit, 3) and to_unsigned(i, 3)) = 0 generate
        first_layer_inputs(i)(ibit) <= inputs(ibit).Data0;
      end generate;
      Input1Selection: if (to_unsigned(2**ibit, 3) and to_unsigned(i, 3)) > 0 generate
        first_layer_inputs(i)(ibit) <= inputs(ibit).Data1;
      end generate;
    end generate;
    gate: THmn
            generic map(M => 3, N => 3)
            port map(inputs => first_layer_inputs(i),
                     output => intermedate(i));
  end generate;

  oS0: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermedate(0),
                  inputs(1) => intermedate(3),
                  inputs(2) => intermedate(5),
                  inputs(3) => intermedate(6),
                  output => oS.DATA0);

  oS1: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermedate(1),
                  inputs(1) => intermedate(2),
                  inputs(2) => intermedate(4),
                  inputs(3) => intermedate(7),
                  output => oS.DATA1);

  oC0: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermedate(0),
                  inputs(1) => intermedate(1),
                  inputs(2) => intermedate(2),
                  inputs(3) => intermedate(4),
                  output => oC.DATA0);

  oC1: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermedate(3),
                  inputs(1) => intermedate(5),
                  inputs(2) => intermedate(6),
                  inputs(3) => intermedate(7),
                  output => oC.DATA1);
end structural;

architecture optimized of FullAdder is
  signal sLT2 : std_logic;
  signal sLT3 : std_logic;
  signal sGE2 : std_logic;
  signal sGE1 : std_logic;
  signal sEQ3 : std_logic;
  signal sEQ2 : std_logic;
  signal sEQ1 : std_logic;
  signal sEQ0 : std_logic;

begin
  LT2: THmn
         generic map(M => 2, N => 3)
         port map(inputs(0) => iA.DATA0,
                  inputs(1) => iB.DATA0,
                  inputs(2) => iC.DATA0,
                  output => sLT2);

  GE2: THmn
         generic map(M => 2, N => 3)
         port map(inputs(0) => iA.DATA1,
                  inputs(1) => iB.DATA1,
                  inputs(2) => iC.DATA1,
                  output => sGE2);

  GE1: THmn
         generic map(M => 1, N => 3)
         port map(inputs(0) => iA.DATA1,
                  inputs(1) => iB.DATA1,
                  inputs(2) => iC.DATA1,
                  output => sGE1);

  EQ1: THmn
         generic map(M => 2, N => 2)
         port map(inputs(0) => sGE1,
                  inputs(1) => sLT2,
                  output => sEQ1);

  EQ3: THmn
         generic map(M => 3, N => 3)
         port map(inputs(0) => iA.DATA1,
                  inputs(1) => iB.DATA1,
                  inputs(2) => iC.DATA1,
                  output => sEQ3);

  S1: THmn
        generic map(M => 1, N => 2)
        port map(inputs(0) => sEQ1,
                 inputs(1) => sEQ3,
                 output => oS.DATA1);

  EQ0: THmn
         generic map(M => 3, N => 3)
         port map(inputs(0) => iA.DATA0,
                  inputs(1) => iB.DATA0,
                  inputs(2) => iC.DATA0,
                  output => sEQ0);
  LT3: THmn
         generic map(M => 1, N => 3)
         port map(inputs(0) => iA.DATA0,
                  inputs(1) => iB.DATA0,
                  inputs(2) => iC.DATA0,
                  output => sLT3);

  EQ2: THmn
         generic map(M => 2, N => 2)
         port map(inputs(0) => sGE2,
                  inputs(1) => sLT3,
                  output => sEQ2);

  S0: THmn
        generic map(M => 1, N => 2)
        port map(inputs(0) => sEQ2,
                 inputs(1) => sEQ0,
                 output => oS.DATA0);

  oC.DATA0 <= sLT2;
  oC.DATA1 <= sGE2;

end optimized;