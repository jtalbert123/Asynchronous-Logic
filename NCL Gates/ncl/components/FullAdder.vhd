library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity FullAdder is
  port(cin  : in ncl_pair;
       a    : in ncl_pair;
       b    : in ncl_pair;
       sum  : out ncl_pair;
       cout : out ncl_pair);
end FullAdder;

architecture structural of FullAdder is
  signal c0a0b0_ins : std_logic_vector(0 to 2);
  signal c0a0b0_out : std_logic;

  signal c1a1b1_ins : std_logic_vector(0 to 2);
  signal c1a1b1_out : std_logic;

  signal sum1_ins : std_logic_vector(0 to 4);
  signal sum1_out : std_logic;

  signal sum0_ins : std_logic_vector(0 to 4);
  signal sum0_out : std_logic;

begin
  c0a0b0_ins(0) <= cin.DATA0;
  c0a0b0_ins(1) <= a.DATA0;
  c0a0b0_ins(2) <= b.DATA0;
  T32_C0A0B0 : THmn
               generic map(N => 3, M => 2)
               port map(inputs => c0a0b0_ins,
                        output => c0a0b0_out);

  c1a1b1_ins(0) <= cin.DATA1;
  c1a1b1_ins(1) <= a.DATA1;
  c1a1b1_ins(2) <= b.DATA1;
  T32_C1A1B1 : THmn
               generic map(N => 3, M => 2)
               port map(inputs => c1a1b1_ins,
                        output => c1a1b1_out);

  cout.DATA0 <= c0a0b0_out;
  cout.DATA1 <= c1a1b1_out;

  sum1_ins(0) <= cin.DATA1;
  sum1_ins(1) <= a.DATA1;
  sum1_ins(2) <= b.DATA1;
  sum1_ins(3) <= c0a0b0_out;
  sum1_ins(4) <= c0a0b0_out;
  T53_sum1 : THmn
               generic map(N => 5, M => 3)
               port map(inputs => sum1_ins,
                        output => sum1_out);
  sum.DATA1 <= sum1_out;

  sum0_ins(0) <= cin.DATA0;
  sum0_ins(1) <= a.DATA0;
  sum0_ins(2) <= b.DATA0;
  sum0_ins(3) <= c1a1b1_out;
  sum0_ins(4) <= c1a1b1_out;
  T53_sum0 : THmn
               generic map(N => 5, M => 3)
               port map(inputs => sum0_ins,
                        output => sum0_out);
  sum.DATA0 <= sum0_out;
end structural;