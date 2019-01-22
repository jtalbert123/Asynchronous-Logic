library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity HalfAdder is
  port(iA_0 : in std_logic;
       iA_1 : in std_logic;
       iB_0 : in std_logic;
       iB_1 : in std_logic;
       oS_0 : out std_logic;
       oS_1 : out std_logic;
       oC_0 : out std_logic;
       oC_1 : out std_logic);
end HalfAdder;

architecture structural of HalfAdder is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal S : ncl_pair;
  signal C : ncl_pair;
begin
  
  A.DATA0 <= iA_0;
  A.DATA1 <= iA_1;

  B.DATA0 <= iB_0;
  B.DATA1 <= iB_1;

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

  oS_0 <= S.DATA0;
  oS_1 <= S.DATA1;

  oC_0 <= C.DATA0;
  oC_1 <= C.DATA1;

end structural;