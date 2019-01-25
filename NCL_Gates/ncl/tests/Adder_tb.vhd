library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity adder_tb is
  port(iA : out std_logic_vector(31 downto 0);
       iB : out std_logic_vector(31 downto 0);
       iC : out std_logic;
       oS : out std_logic_vector(31 downto 0);
       oC : out std_logic);
end entity adder_tb;

architecture structural of adder_tb is

  signal A : ncl_pair_vector(31 downto 0) := ncl_pair_null_vector(32);
  signal B : ncl_pair_vector(31 downto 0) := ncl_pair_null_vector(32);
  signal Ci : ncl_pair;

  signal S : ncl_pair_vector(31 downto 0) := ncl_pair_null_vector(32);
  signal Co : ncl_pair;

  signal adder_state : ncl_pair_vector(63 downto 0) := ncl_pair_null_vector(64);
begin
  
  adder_state <= add(adder_state, A, B, ci);
  S <= add_extractsum(adder_state)(31 downto 0);
  Co <= add_extractsum(adder_state)(32);

  iA <= to_data1_vector(A);
  iB <= to_data1_vector(B);
  iC <= Ci.DATA1;
  oS <= to_data1_vector(S);
  oC <= Co.DATA1;
  
  cases: process
  begin
    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(0, 32));
    B <= to_ncl_pair_data_vector(to_signed(0, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(0, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(1, 32));
    B <= to_ncl_pair_data_vector(to_signed(0, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(1, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(0, 32));
    B <= to_ncl_pair_data_vector(to_signed(1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(1, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(1, 32));
    B <= to_ncl_pair_data_vector(to_signed(1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(2, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(-1, 32));
    B <= to_ncl_pair_data_vector(to_signed(0, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(-1, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(0, 32));
    B <= to_ncl_pair_data_vector(to_signed(-1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(-1, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(-1, 32));
    B <= to_ncl_pair_data_vector(to_signed(1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(0, 32));
    ASSERT Co = NCL_PAIR_DATA1;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(3, 32));
    B <= to_ncl_pair_data_vector(to_signed(1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(4, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(-3, 32));
    B <= to_ncl_pair_data_vector(to_signed(1, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = to_ncl_pair_data_vector(to_signed(-2, 32));
    ASSERT Co = NCL_PAIR_DATA0;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(0, 32));
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= ncl_pair_null_vector(32);
    B <= to_ncl_pair_data_vector(to_signed(0, 32));
    Ci <= NCL_PAIR_DATA0;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= to_ncl_pair_data_vector(to_signed(0, 32));
    B <= to_ncl_pair_data_vector(to_signed(0, 32));
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    A <= ncl_pair_null_vector(32);
    B <= ncl_pair_null_vector(32);
    Ci <= NCL_PAIR_NULL;
    wait for 100 ns;
    ASSERT S = ncl_pair_null_vector(32);
    ASSERT Co = NCL_PAIR_NULL;

    wait;
  end process cases;

end structural;