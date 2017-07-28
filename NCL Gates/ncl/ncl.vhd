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

  constant NCL_NULL : ncl_pair;

  function clog2(input : integer) return integer;
  
  component THmn is
    generic(M : integer := 1;
            N : integer := 1;
            Delay : time := 1 ns);
    port(inputs : in  std_logic_vector(0 to N-1);
         output : out std_logic);
  end component THmn;

  component THxor0 is
    generic(Delay : time := 1 ns);
    port(A, B, C, D : in  std_logic;
         output : out std_logic);
  end component THxor0;

  component RegisterN is
    generic(N : integer := 1;
            RegisterDelay : time := 20 ns);
    port(inputs    : in ncl_pair_vector(0 to N-1);
         from_next : in std_logic;
         output    : out ncl_pair_vector(0 to N-1);
         to_prev   : out std_logic);
  end component;
  
  component FullAdder is    
    port(iC : in  ncl_pair;
         iA : in  ncl_pair;
         iB : in  ncl_pair;
         oS : out ncl_pair;
         oC : out ncl_pair);
  end component;

  component Adder is
    generic(NumAdderBits : integer := 4);
    port(iC : in  ncl_pair;
         iA : in  ncl_pair_vector(0 to NumAdderBits-1);
         iB : in  ncl_pair_vector(0 to NumAdderBits-1);
         oS : out ncl_pair_vector(0 to NumAdderBits-1);
         oC : out ncl_pair);
  end component;

  component MUX is
    generic(NumInputs : integer := 2);
    port(iOptions : in  ncl_pair_vector(0 to NumInputs-1);
         iSel     : in  ncl_pair_vector(0 to clog2(NumInputs)-1);
         output   : out ncl_pair);
  end component;

  component Decoder is
    generic(NumInputs : integer := 2);
    port(inputs  : in  ncl_pair_vector(0 to NumInputs-1);
         outputs : out ncl_pair_vector(0 to (2**NumInputs)-1));
  end component;
end ncl;

package body ncl is
  constant NCL_NULL : ncl_pair := (others => '0');
  function clog2(input : integer) return integer is
  begin
    return integer(ceil(log2(real(input))));
  end function;
end package body ncl;