library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity FullAdder_TB is

end entity FullAdder_TB;

architecture structural of FullAdder_TB is

  component FullAdder is
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
  end component;

  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Ci : ncl_pair;

  signal S : ncl_pair;
  signal Co : ncl_pair;

begin
  
  Adder: FullAdder
           port map(iA_0 => A.DATA0,
                    iA_1 => A.DATA1,
                    iB_0 => B.DATA0,
                    iB_1 => B.DATA1,
                    iC_0 => Ci.DATA0,
                    iC_1 => Ci.DATA1,
                    oS_0 => S.DATA0,
                    oS_1 => S.DATA1,
                    oC_0 => Co.DATA0,
                    oC_1 => Co.DATA1);

  cases: process
  begin
    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT Co = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT Co = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA1;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT Co = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_DATA1;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT Co = NCL_PAIR_DATA1;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT Co = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT Co = NCL_PAIR_DATA1;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA1;
    Ci <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT Co = NCL_PAIR_DATA1;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_DATA1;
    Ci <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT Co = NCL_PAIR_DATA1;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA0;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT Co = NCL_PAIR_NULL;

    wait;
  end process cases;

end structural;