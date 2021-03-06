library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real."ceil";
use ieee.math_real."log2";

package ncl is
  type ncl_pair is record
    data0 : std_logic;
    data1 : std_logic;
  end record ncl_pair;

  constant NCL_PAIR_NULL : ncl_pair;
  constant NCL_PAIR_DATA0 : ncl_pair;
  constant NCL_PAIR_DATA1 : ncl_pair;
  
  type ncl_pair_vector is array (integer range <>) of ncl_pair;

  type ncl_pair_enum is ('N', '0', '1');
  type ncl_pair_enum_vector is array (integer range<>) of ncl_pair_enum;

  function to_ncl_pair_vector(initializer : ncl_pair_enum_vector) return ncl_pair_vector;
  function to_ncl_pair_enum_vector(initializer : ncl_pair_vector) return ncl_pair_enum_vector;
  function ncl_pair_null_vector(N : integer) return ncl_pair_vector;
  function to_ncl_pair_data_vector(value : std_logic_vector) return ncl_pair_vector;
  function to_ncl_pair_data_vector(value : bit_vector) return ncl_pair_vector;
  function to_ncl_pair_data_vector(value : unsigned) return ncl_pair_vector;
  function to_ncl_pair_data_vector(value : signed) return ncl_pair_vector;

  function clog2(input : integer) return integer;
  function to_ncl_pair(data0 : std_logic; data1 : std_logic) return ncl_pair;
  function to_ncl_pair_vector(data0 : std_logic_vector; data1 : std_logic_vector) return ncl_pair_vector;
  function to_data0_vector(vec : ncl_pair_vector) return std_logic_vector;
  function to_data1_vector(vec : ncl_pair_vector) return std_logic_vector;

  function TH12_f(prev : std_logic; a : std_logic; b : std_logic) return std_logic;
  function TH22_f(prev : std_logic; a : std_logic; b : std_logic) return std_logic;
  function TH13_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic;
  function TH23_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic;
  function TH33_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic;
  function TH23w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic;
  function TH33w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic;
  function TH14_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH24_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH34_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH44_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH24w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH34w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH44w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH34w3_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH44w3_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH24w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH34w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH44w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH54w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH34w32_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH54w32_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH44w322_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH54w322_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function THxor0_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function THand0_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;
  function TH24comp_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic;

  function "not"(val : ncl_pair) return ncl_pair;
  function ncl_and(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair;
  function ncl_or(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair;
  function ncl_xor(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair;

  -- Requires 2*N ncl_pairs of storage. use add_extractsum(retval) to get the result
  function add(prev : ncl_pair_vector; left : ncl_pair_vector; right : ncl_pair_vector; ci : ncl_pair) return ncl_pair_vector;
  -- Requires 7 ncl_pairs of storage, with the sum being at index 0, and the carry at index 1.
  function add(prev : ncl_pair_vector(6 downto 0); a : ncl_pair; b : ncl_pair; c : ncl_pair) return ncl_pair_vector;
  -- The extractor for the sum from the N-bit add function. Returns the sum and the last carry (N+1 bits).
  function add_extractsum(state : ncl_pair_vector) return ncl_pair_vector;
  
  component TH12 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH13 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH23 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH14 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH24 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH34 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH23w2 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH33w2 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH24w2 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH34w2 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH44w2 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH34w3 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH44w3 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH24w22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH34w22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH44w22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH54w22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH34w32 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH54w32 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH44w322 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH54w322 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component THxor0 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component THand0 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH24comp is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;

  -- an OR gate
  component TH1n is
    generic(N : integer := 2);
    port(isig : in  std_logic_vector(N-1 downto 0);
         osig : out std_logic := '0');
  end component;
  
  function max(a : integer; b : integer) return integer;

end ncl;

package body ncl is
  constant NCL_PAIR_NULL : ncl_pair := (DATA0 => '0', DATA1 => '0');
  constant NCL_PAIR_DATA0 : ncl_pair := (DATA0 => '1', DATA1 => '0');
  constant NCL_PAIR_DATA1 : ncl_pair := (DATA0 => '0', DATA1 => '1');

  function clog2(input : integer) return integer is
  begin
    return integer(ceil(log2(real(input))));
  end function;

  function to_ncl_pair(data0 : std_logic; data1 : std_logic) return ncl_pair is
  begin
    return (data0, data1);
  end function;

  function to_ncl_pair_vector(data0 : std_logic_vector; data1 : std_logic_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(data0'length-1 downto 0);
  begin
    for i in data0'length-1 downto 0 loop
	toReturn(i) := (data0(data0'low+i), data1(data1'low+i));
    end loop;
    return toReturn;
  end function;

  function to_data0_vector(vec : ncl_pair_vector) return std_logic_vector is
    variable toReturn : std_logic_vector(vec'length-1 downto 0);
  begin
    for i in vec'length-1 downto 0 loop
      toReturn(i) := vec(vec'low+i).data0;
    end loop;
    return toReturn;
  end function;

  function to_data1_vector(vec : ncl_pair_vector) return std_logic_vector is
    variable toReturn : std_logic_vector(vec'length-1 downto 0);
  begin
    for i in vec'length-1 downto 0 loop
      toReturn(i) := vec(vec'low+i).data1;
    end loop;
    return toReturn;
  end function;

  function "not"(val : ncl_pair) return ncl_pair is
  begin
    return (val.DATA1, val.DATA0);
  end function;

  function ncl_and(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair is
  begin
    if (left = NCL_PAIR_NULL AND right = NCL_PAIR_NULL) then return NCL_PAIR_NULL;
    elsif (left = NCL_PAIR_NULL OR right = NCL_PAIR_NULL) then return prev;
    elsif (left = NCL_PAIR_DATA1 AND right = NCL_PAIR_DATA1) then return NCL_PAIR_DATA1;
    else return NCL_PAIR_DATA0;
    end if;
  end function;

  function ncl_or(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair is
  begin
    if (left = NCL_PAIR_NULL AND right = NCL_PAIR_NULL) then return NCL_PAIR_NULL;
    elsif (left = NCL_PAIR_NULL OR right = NCL_PAIR_NULL) then return prev;
    elsif (left = NCL_PAIR_DATA1 OR right = NCL_PAIR_DATA1) then return NCL_PAIR_DATA1;
    else return NCL_PAIR_DATA0;
    end if;
  end function;

  function ncl_xor(prev : ncl_pair; left : ncl_pair; right : ncl_pair) return ncl_pair is
  begin
    if (left = NCL_PAIR_NULL AND right = NCL_PAIR_NULL) then return NCL_PAIR_NULL;
    elsif (left = NCL_PAIR_NULL OR right = NCL_PAIR_NULL) then return prev;
    elsif (left /= right) then return NCL_PAIR_DATA1;
    else return NCL_PAIR_DATA0;
    end if;
  end function;

  function TH12_f(prev : std_logic; a : std_logic; b : std_logic) return std_logic is
  begin
    if (a OR b) = '0' then return '0';
    elsif (a OR b) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH22_f(prev : std_logic; a : std_logic; b : std_logic) return std_logic is
  begin
    if (a OR b) = '0' then return '0';
    elsif (a AND b) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH13_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic is
  begin
    if (a OR b OR c) = '0' then return '0';
    elsif (a OR b OR c) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH23_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic is
  begin
    if (a OR b OR c) = '0' then return '0';
    elsif ((a AND b) OR (b AND c) OR (c AND a)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH33_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic is
  begin
    if (a OR b OR c) = '0' then return '0';
    elsif (a AND b AND c) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH23w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic is
  begin
    if (a OR b OR c) = '0' then return '0';
    elsif (a OR (b AND c)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH33w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic) return std_logic is
  begin
    if (a OR b OR c) = '0' then return '0';
    elsif ((a AND b) OR (a AND c)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH14_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a OR b OR c OR d) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH24_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (a AND d) OR (b AND c) OR (b AND d) OR (c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH34_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b AND c) OR (a AND b AND d) OR (a AND c AND d) OR (b AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH44_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a AND b AND c AND d) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH24w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a OR (b AND c) OR (b AND d) OR (c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH34w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (a AND d) OR (b AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH44w2_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b AND c) OR (a AND b AND d) OR (a AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH34w3_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a OR (b AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH44w3_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (a AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH24w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a OR b OR (c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH34w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (a AND d) OR (b AND c) OR (b AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH44w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c AND d) OR (b AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH54w22_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b AND c) OR (a AND b AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH34w32_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif (a OR (b AND c) OR (b AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH54w32_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH44w322_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (a AND d) OR (b AND c)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function TH54w322_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (a AND c) OR (b AND c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function THxor0_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b) OR (c AND d)) = '1' then return '1';
    else return prev;
    end if;
  end function;

  function THand0_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND b)OR (b AND c) OR (a AND d)) = '1' then return '1';
    else return prev; 
    end if;
  end function;

  function TH24comp_f(prev : std_logic; a : std_logic; b : std_logic; c : std_logic; d : std_logic) return std_logic is
  begin
    if (a OR b OR c OR d) = '0' then return '0';
    elsif ((a AND c) OR (b AND c) OR (a AND d) OR (b AND d)) = '1' then return '1';
    else return prev; 
    end if;
  end function;

  function add(prev : ncl_pair_vector(6 downto 0); a : ncl_pair; b : ncl_pair; c : ncl_pair) return ncl_pair_vector is
    variable state : ncl_pair_vector(prev'length - 1 downto 0);
  begin
    -- a1b1
    state(2).DATA0 := TH34_f(prev(2).DATA0, a.DATA1, b.DATA1, c.DATA0, c.DATA1);
    -- a1c1
    state(2).DATA1 := TH34_f(prev(2).DATA1, a.DATA1, c.DATA1, b.DATA0, b.DATA1);
    -- b1c1
    state(3).DATA0 := TH34_f(prev(3).DATA0, b.DATA1, c.DATA1, a.DATA0, a.DATA1);
    state(1).DATA1 := TH13_f(prev(1).DATA1, state(2).DATA0, state(2).DATA1, state(3).DATA0);
    
    -- all 0
    state(3).DATA1 := TH33_f(prev(3).DATA1, a.DATA0, b.DATA0, c.DATA0);
    -- 2 0's
    state(4).DATA0 := TH23_f(prev(4).DATA0, a.DATA0, b.DATA0, c.DATA0);
    -- 1 1
     state(4).DATA1 := TH13_f(prev(4).DATA1, a.DATA1, b.DATA1, c.DATA1);
    -- all 0, or 2 zeros and a 1
    state(1).DATA0 := TH23w2_f(prev(1).DATA0, state(3).DATA1, state(4).DATA0, state(4).DATA1);
    
    -- all 1
    state(5).DATA0 := TH33_f(prev(5).DATA0, a.DATA1, b.DATA1, c.DATA1);
    -- all 1, or 2 zeros and a 1
    state(0).DATA1 := TH23w2_f(prev(0).DATA1, state(5).DATA0, state(4).DATA0, state(4).DATA1);
    
    -- 2 1's
    state(6).DATA0 := TH23_f(prev(6).DATA0, a.DATA1, b.DATA1, c.DATA1);
    -- 1 0
    state(6).DATA1 := TH13_f(prev(6).DATA1, a.DATA0, b.DATA0, c.DATA0);
    -- all 0, or 2 ones and a 0
    state(0).DATA0 := TH23w2_f(prev(0).DATA0, state(3).DATA1, state(6).DATA0, state(6).DATA1); 
    
    return state;
  end function;
  
  function add_extractsum(state : ncl_pair_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(state'length/7 downto 0);
  begin
    toReturn(state'length/7) := state(state'length-6);
    for i in state'length/7-1 downto 0 loop
      toReturn(i) := state(7*i);
    end loop;
	return toReturn;
  end function;
  
  -- sum is the first N entries of the return.
  function add(prev : ncl_pair_vector; left : ncl_pair_vector; right : ncl_pair_vector; ci : ncl_pair) return ncl_pair_vector is
    -- Even indexes are the sums, odd are the carries.
    variable states : ncl_pair_vector(7*left'length - 1 downto 0);
  begin
    -- Do the addition
    states(6 downto 0) := add(prev(6 downto 0), left(0), right(0), ci);
    for i in 1 to left'length - 1 loop
      states(7*i+6 downto 7*i) := add(prev(7*i+6 downto 7*i), left(i), right(i), states(7*(i-1)+1));
    end loop;
    return states;
  end function;

  function to_ncl_pair_vector(initializer : ncl_pair_enum_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(initializer'length - 1 downto 0);
  begin
    for i in initializer'length - 1 downto 0 loop
      if (initializer(i) = 'N') then toReturn(i) := NCL_PAIR_NULL;
      elsif (initializer(i) = '0') then toReturn(i) := NCL_PAIR_DATA0;
      elsif (initializer(i) = '1') then toReturn(i) := NCL_PAIR_DATA1;
      end if;
    end loop;
    return toReturn;
  end function;

  function to_ncl_pair_enum_vector(initializer : ncl_pair_vector) return ncl_pair_enum_vector is
    variable toReturn : ncl_pair_enum_vector(initializer'length - 1 downto 0);
  begin
    for i in initializer'length - 1 downto 0 loop
      if (initializer(i) = NCL_PAIR_NULL) then toReturn(i) := 'N';
      elsif (initializer(i) = NCL_PAIR_DATA0) then toReturn(i) := '0';
      elsif (initializer(i) = NCL_PAIR_DATA1) then toReturn(i) := '1';
      end if;
    end loop;
    return toReturn;
  end function;

  function ncl_pair_null_vector(N : integer) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(N - 1 downto 0);
  begin
    for i in N - 1 downto 0 loop
      toReturn(i) := NCL_PAIR_NULL;
    end loop;
    return toReturn;
  end function;

  function to_ncl_pair_data_vector(value : std_logic_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(value'length - 1 downto 0);
  begin
    for i in value'length - 1 downto 0 loop
      if (value(i + value'low) = '0') then toReturn(i) := NCL_PAIR_DATA0;
      elsif (value(i + value'low) = '1') then toReturn(i) := NCL_PAIR_DATA1;
      end if;
    end loop;
    return toReturn;
  end function;

  function to_ncl_pair_data_vector(value : bit_vector) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(value'length - 1 downto 0);
  begin
    for i in value'length - 1 downto 0 loop
      if (value(i + value'low) = '0') then toReturn(i) := NCL_PAIR_DATA0;
      elsif (value(i + value'low) = '1') then toReturn(i) := NCL_PAIR_DATA1;
      end if;
    end loop;
    return toReturn;
  end function;

  function to_ncl_pair_data_vector(value : unsigned) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(value'length - 1 downto 0);
  begin
    for i in value'length - 1 downto 0 loop
      if (value(i + value'low) = '0') then toReturn(i) := NCL_PAIR_DATA0;
      elsif (value(i + value'low) = '1') then toReturn(i) := NCL_PAIR_DATA1;
      end if;
    end loop;
    return toReturn;
  end function;

  function to_ncl_pair_data_vector(value : signed) return ncl_pair_vector is
    variable toReturn : ncl_pair_vector(value'length - 1 downto 0);
  begin
    for i in value'length - 1 downto 0 loop
      if (value(i + value'low) = '0') then toReturn(i) := NCL_PAIR_DATA0;
      elsif (value(i + value'low) = '1') then toReturn(i) := NCL_PAIR_DATA1;
      end if;
    end loop;
    return toReturn;
  end function;
  
  function max(a : integer; b : integer) return integer is
  begin
    if (a > b) then return a;
    else return b;
    end if;
  end function;

end package body ncl;