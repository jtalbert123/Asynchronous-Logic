library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity FullAdder is
  port(iA_0 : in std_logic;
       iA_1 : in std_logic;
       iB_0 : in std_logic;
       iB_1 : in std_logic;
       iC_0 : in std_logic;
       iC_1 : in std_logic;
       oS_0 : out std_logic;
       oS_1 : out std_logic;
       oC_0 : out std_logic;
       oC_1 : out std_logic);
end FullAdder;

architecture functional of FullAdder is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Ci : ncl_pair;
  signal S : ncl_pair;
  signal Co : ncl_pair;
begin
  
  A.DATA0 <= iA_0;
  A.DATA1 <= iA_1;

  B.DATA0 <= iB_0;
  B.DATA1 <= iB_1;

  Ci.DATA0 <= iC_0;
  Ci.DATA1 <= iC_1;

  process(A, B, Ci)
    variable results : ncl_pair_vector(1 downto 0);
  begin
    results := (S & Co);
    results := add(results, A, B, Ci);
    S <= results(0);
    Co <= results(1);
  end process;

  oS_0 <= S.DATA0;
  oS_1 <= S.DATA1;

  oC_0 <= Co.DATA0;
  oC_1 <= Co.DATA1;

end functional;

architecture behavioral of FullAdder is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Ci : ncl_pair;
  signal S : ncl_pair;
  signal Co : ncl_pair;
begin
  
  A.DATA0 <= iA_0;
  A.DATA1 <= iA_1;

  B.DATA0 <= iB_0;
  B.DATA1 <= iB_1;

  Ci.DATA0 <= iC_0;
  Ci.DATA1 <= iC_1;

  process(A, B, Ci)
  begin
    if (A = NCL_PAIR_NULL AND
        B = NCL_PAIR_NULL AND
        Ci = NCL_PAIR_NULL) then
      S <= NCL_PAIR_NULL;
      Co <= NCL_PAIR_NULL;

    elsif (A = NCL_PAIR_NULL OR
           B = NCL_PAIR_NULL OR
           Ci = NCL_PAIR_NULL) then
      S <= S;
      Co <= Co;

    elsif (A = NCL_PAIR_DATA0 AND
           B = NCL_PAIR_DATA0 AND
           Ci = NCL_PAIR_DATA0) then
      S <= NCL_PAIR_DATA0;
      Co <= NCL_PAIR_DATA0;

    elsif (A = NCL_PAIR_DATA0 AND
           B = NCL_PAIR_DATA1 AND
           Ci = NCL_PAIR_DATA1) then
      S <= NCL_PAIR_DATA0;
      Co <= NCL_PAIR_DATA1;

    elsif (A = NCL_PAIR_DATA0 AND
           B /= Ci) then
      S <= NCL_PAIR_DATA1;
      Co <= NCL_PAIR_DATA0;


    elsif (A = NCL_PAIR_DATA1 AND
           B = NCL_PAIR_DATA0 AND
           Ci = NCL_PAIR_DATA0) then
      S <= NCL_PAIR_DATA1;
      Co <= NCL_PAIR_DATA0;

    elsif (A = NCL_PAIR_DATA1 AND
           B = NCL_PAIR_DATA1 AND
           Ci = NCL_PAIR_DATA1) then
      S <= NCL_PAIR_DATA1;
      Co <= NCL_PAIR_DATA1;

    elsif (A = NCL_PAIR_DATA1 AND
           B /= Ci) then
      S <= NCL_PAIR_DATA0;
      Co <= NCL_PAIR_DATA1;

    end if;

  end process;

  oS_0 <= S.DATA0;
  oS_1 <= S.DATA1;

  oC_0 <= Co.DATA0;
  oC_1 <= Co.DATA1;

end behavioral;