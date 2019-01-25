library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity FullAdder is
  port(iA : in ncl_pair;
       iB : in ncl_pair;
       iC : in ncl_pair;
       oS : out ncl_pair;
       oC : out ncl_pair);
end FullAdder;

architecture functional of FullAdder is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Ci : ncl_pair;
  signal S : ncl_pair;
  signal Co : ncl_pair;
begin
  
  A <= iA;
  B <= iB;
  Ci <= iC;

  process(A, B, Ci, S, Co)
    variable state : ncl_pair_vector(1 downto 0);
  begin
    state(0) := S;
    state(1) := Co;
    state := add(state, A, B, Ci);
    S <= state(0);
    Co <= state(1);
  end process;

  oS <= S;
  oC <= Co;

end functional;