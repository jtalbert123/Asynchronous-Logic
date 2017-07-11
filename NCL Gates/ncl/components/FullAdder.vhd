library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity FullAdder is
  port(iC  : in ncl_pair;
       a    : in ncl_pair;
       b    : in ncl_pair;
       oS  : out ncl_pair;
       oC : out ncl_pair);
end FullAdder;

architecture optimized of FullAdder is
  signal c0a0b0_ins : std_logic_vector(0 to 2);
  signal c0a0b0_out : std_logic;

  signal c1a1b1_ins : std_logic_vector(0 to 2);
  signal c1a1b1_out : std_logic;

  signal oS1_ins : std_logic_vector(0 to 4);
  signal oS1_out : std_logic;

  signal oS0_ins : std_logic_vector(0 to 4);
  signal oS0_out : std_logic;

begin
  c0a0b0_ins(0) <= iC.DATA0;
  c0a0b0_ins(1) <= a.DATA0;
  c0a0b0_ins(2) <= b.DATA0;
  T32_C0A0B0 : THmn
               generic map(N => 3, M => 2)
               port map(inputs => c0a0b0_ins,
                        output => c0a0b0_out);

  c1a1b1_ins(0) <= iC.DATA1;
  c1a1b1_ins(1) <= a.DATA1;
  c1a1b1_ins(2) <= b.DATA1;
  T32_C1A1B1 : THmn
               generic map(N => 3, M => 2)
               port map(inputs => c1a1b1_ins,
                        output => c1a1b1_out);

  oC.DATA0 <= c0a0b0_out;
  oC.DATA1 <= c1a1b1_out;

  oS1_ins(0) <= iC.DATA1;
  oS1_ins(1) <= a.DATA1;
  oS1_ins(2) <= b.DATA1;
  oS1_ins(3) <= c0a0b0_out;
  oS1_ins(4) <= c0a0b0_out;
  T53_oS1 : THmn
               generic map(N => 5, M => 3)
               port map(inputs => oS1_ins,
                        output => oS1_out);
  oS.DATA1 <= oS1_out;

  oS0_ins(0) <= iC.DATA0;
  oS0_ins(1) <= a.DATA0;
  oS0_ins(2) <= b.DATA0;
  oS0_ins(3) <= c1a1b1_out;
  oS0_ins(4) <= c1a1b1_out;
  T53_oS0 : THmn
               generic map(N => 5, M => 3)
               port map(inputs => oS0_ins,
                        output => oS0_out);
  oS.DATA0 <= oS0_out;
end optimized;

architecture structural of FullAdder is
  type first_layer is array (integer range <>) of std_logic_vector(0 to 2);
  signal first_layer_inputs : first_layer(0 to 7);
  signal intermediate : std_logic_vector(0 to 7);
  signal inputs : ncl_pair_vector(0 to 2);

begin
  inputs(2) <= a;
  inputs(1) <= b;
  inputs(0) <= iC;
  input_layer: for i in 0 to 7 generate
    bits: for ibit in 0 to 2 generate
      Input0Selection: if (to_unsigned(2**iBit, 3) and to_unsigned(i, 3)) = 0 generate
        first_layer_inputs(i)(iBit) <= inputs(iBit).Data0;
      end generate;
      Input1Selection: if (to_unsigned(2**iBit, 3) and to_unsigned(i, 3)) > 0 generate
        first_layer_inputs(i)(iBit) <= inputs(iBit).Data1;
      end generate;
    end generate;
    gate: THmn
            generic map(M => 3, N => 3)
            port map(inputs => first_layer_inputs(i),
                     output => intermediate(i));
  end generate;

  oS0: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermediate(0),
                  inputs(1) => intermediate(3),
                  inputs(2) => intermediate(5),
                  inputs(3) => intermediate(6),
                  output => oS.DATA0);

  oS1: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermediate(1),
                  inputs(1) => intermediate(2),
                  inputs(2) => intermediate(4),
                  inputs(3) => intermediate(7),
                  output => oS.DATA1);

  oC0: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermediate(0),
                  inputs(1) => intermediate(1),
                  inputs(2) => intermediate(2),
                  inputs(3) => intermediate(4),
                  output => oC.DATA0);

  oC1: THmn
         generic map(M => 1, N => 4)
         port map(inputs(0) => intermediate(3),
                  inputs(1) => intermediate(5),
                  inputs(2) => intermediate(6),
                  inputs(3) => intermediate(7),
                  output => oC.DATA1);
end structural;