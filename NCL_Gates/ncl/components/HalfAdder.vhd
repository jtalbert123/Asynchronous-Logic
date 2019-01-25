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
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal S : ncl_pair;
  signal C : ncl_pair;
begin
  
  A <= iA;
  B <= iB;

  T22_C1 : TH22
           port map(iA => A.DATA1,
                    iB => B.DATA1,
                    osig => C.DATA1);

  THand0_C0: THand0
           port map(iA => A.DATA0,
                    iB => B.DATA0,
                    iC => A.DATA1,
                    iD => B.DATA1,
                    osig => C.DATA0);

  THxor0_S0: THxor0
           port map(iA => A.DATA0,
                    iB => B.DATA0,
                    iC => A.DATA1,
                    iD => B.DATA1,
                    osig => S.DATA0);

  THxor0_S1: THxor0
           port map(iA => A.DATA0,
                    iB => B.DATA1,
                    iC => A.DATA1,
                    iD => B.DATA0,
                    osig => S.DATA1);

  oS <= S;
  oC <= C;

end structural;