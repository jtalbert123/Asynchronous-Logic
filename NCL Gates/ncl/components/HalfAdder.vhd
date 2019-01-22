library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity HalfAdder is
  port(iA : in ncl_pair;
       iB : in ncl_pair;
       oS : out ncl_pair;
       oC : out ncl_pair);
end HalfAdder;

architecture structural of HalfAdder is
  signal a0b0_ins : std_logic_vector(0 to 1);
  signal a0b0_out : std_logic;
  signal a0b1_ins : std_logic_vector(0 to 1);
  signal a0b1_out : std_logic;
  signal a1b0_ins : std_logic_vector(0 to 1);
  signal a1b0_out : std_logic;
  signal a1b1_ins : std_logic_vector(0 to 1);
  signal a1b1_out : std_logic;

  signal s0_ins : std_logic_vector(0 to 1);
  signal s0_out : std_logic;
  signal s1_ins : std_logic_vector(0 to 1);
  signal s1_out : std_logic;

  signal c0_ins : std_logic_vector(0 to 2);
  signal c0_out : std_logic;
begin

  T21_A1B1 : TH22
               port map(iA => iA.DATA1,
                        iB => iB.DATA1,
                        osig => oC.DATA1);

  THand0_C0: THand0
           port map(iA => iA.DATA0,
                    iB => iB.DATA0,
                    iC => iA.DATA1,
                    iD => iB.DATA1,
                    osig => oC.DATA0);

  THxor0_S0: THxor0
           port map(iA => iA.DATA0,
                    iB => iB.DATA0,
                    iC => iA.DATA1,
                    iD => iB.DATA1,
                    osig => oS.DATA0);

  THxor0_S1: THxor0
           port map(iA => iA.DATA0,
                    iB => iB.DATA1,
                    iC => iA.DATA1,
                    iD => iB.DATA0,
                    osig => oS.DATA1);
end structural;