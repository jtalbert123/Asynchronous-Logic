library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real."ceil";
use ieee.math_real."log2";

package ncl is
  type ncl_pair is record
    data0 : std_logic;
    data1 : std_logic;
  end record ncl_pair;
  
  type ncl_pair_vector is array (integer range <>) of ncl_pair;

  constant NCL_PAIR_NULL : ncl_pair;
  constant NCL_PAIR_DATA0 : ncl_pair;
  constant NCL_PAIR_DATA1 : ncl_pair;

  function clog2(input : integer) return integer;
  function to_ncl_pair(data0 : std_logic; data1 : std_logic) return ncl_pair;
  function to_ncl_pair_vector(data0 : std_logic_vector; data1 : std_logic_vector) return ncl_pair_vector;
  function to_data0_vector(vec : ncl_pair_vector) return ncl_pair;
  function to_data1_vector(vec : ncl_pair_vector) return ncl_pair;

end ncl;

package body ncl is
  constant NCL_PAIR_NULL : ncl_pair := ('0', '0');
  constant NCL_PAIR_DATA0 : ncl_pair := ('1', '0');
  constant NCL_PAIR_DATA1 : ncl_pair := ('0', '1');

  function clog2(input : integer) return integer is
  begin
    return integer(ceil(log2(real(input))));
  end function;

  function to_ncl_pair(data0 : std_logic; data1 : std_logic) return ncl_pair is
  begin
    return (data0, data1);
  end function;

  function to_ncl_pair_vector(data0 : std_logic_vector; data1 : std_logic_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(0 to data0'length-1);
  begin
    for i in 0 to data0'length-1 loop
	toReturn(i) := (data0(data0'low+i), data1(data1'low+i));
    end loop;
    return toReturn;
  end function;

  function to_data0_vector(vec : ncl_pair_vector) return ncl_pair is
    variable toReturn : std_logic_vector(0 to vec'length-1);
  begin
    for i in 0 to vec'length-1 loop
      toReturn(i) := vec(vec'low+i).data0;
    end loop;
  end function;

  function to_data1_vector(vec : ncl_pair_vector) return ncl_pair is
    variable toReturn : std_logic_vector(0 to vec'length-1);
  begin
    for i in 0 to vec'length-1 loop
      toReturn(i) := vec(vec'low+i).data1;
    end loop;
  end function;

end package body ncl;
