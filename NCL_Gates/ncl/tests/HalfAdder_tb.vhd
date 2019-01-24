library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity HalfAdder_TB is

end entity HalfAdder_TB;

architecture structural of HalfAdder_TB is

  component HalfAdder is
    port(iA_0 : in std_logic;
         iA_1 : in std_logic;
         iB_0 : in std_logic;
         iB_1 : in std_logic;
         oS_0 : out std_logic;
         oS_1 : out std_logic;
         oC_0 : out std_logic;
         oC_1 : out std_logic);
  end component;

  signal A : ncl_pair;
  signal B : ncl_pair;

  signal S : ncl_pair;
  signal C : ncl_pair;

begin
  
  Adder: HalfAdder
           port map(iA_0 => A.DATA0,
                    iA_1 => A.DATA1,
                    iB_0 => B.DATA0,
                    iB_1 => B.DATA1,
                    oS_0 => S.DATA0,
                    oS_1 => S.DATA1,
                    oC_0 => C.DATA0,
                    oC_1 => C.DATA1);

  cases: process
  begin
    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT C = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT C = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA0;
    B <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA1;
    ASSERT C = NCL_PAIR_DATA0;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_DATA1;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_DATA0;
    ASSERT C = NCL_PAIR_DATA1;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_DATA1;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    A <= NCL_PAIR_NULL;
    B <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = NCL_PAIR_NULL;
    ASSERT C = NCL_PAIR_NULL;

    wait;
  end process cases;

end structural;
