library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity ncl_constant is
  generic(N : integer;
          value : integer);
  port(value_0 : out  std_logic_vector(N-1 downto 0);
       value_1 : out  std_logic_vector(N-1 downto 0);
       from_next : in std_logic;
       reset     : in std_logic);
end ncl_constant;

architecture simple of ncl_constant is
  constant datawave : ncl_pair_vector(N-1 downto 0) := to_ncl_pair_data_vector(to_signed(value, N+1))(N-1 downto 0);
  constant nullwave : ncl_pair_vector(N-1 downto 0) := ncl_pair_null_vector(N);
begin

  process(from_next)
  begin
    if (reset = '1') then
      value_0 <= to_data0_vector(nullwave);
      value_1 <= to_data1_vector(nullwave);
    elsif (from_next = '0') then -- send null
      value_0 <= to_data0_vector(nullwave);
      value_1 <= to_data1_vector(nullwave);
    elsif (from_next = '1') then -- send data
      value_0 <= to_data0_vector(datawave);
      value_1 <= to_data1_vector(datawave);
    end if;
  end process;
  
end simple;