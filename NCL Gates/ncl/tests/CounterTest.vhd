library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity Counter_TB is
 port(iA        : in ncl_pair;
      iB        : in ncl_pair;
      iC        : in ncl_pair;
      to_prev   : out std_logic;
      from_next : in std_logic;
      oS        : out ncl_pair;
      oC        : out ncl_pair);
end entity Counter_TB;

architecture structural of Counter_TB is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Cin : ncl_pair;

  signal S : ncl_pair;
  signal Cout : ncl_pair;

  signal internal_control : std_logic;
begin
  RegBefore: RegisterN
         generic map(N => 3)
         port map(inputs(0) => iA, inputs(1) => iB, inputs(2) => iC,
                  output(0) =>  A, output(1) =>  B, output(2) =>  Cin,
                  from_next => internal_control, to_prev => to_prev);

  Adder: FullAdder
           port map(a => A, b => B, cin => Cin,
                    sum => S, cout => Cout);

  RegAfter: RegisterN
         generic map(N => 2)
         port map(inputs(0) =>  S, inputs(1) =>  Cout,
                  output(0) => oS, output(1) => oC,
                  from_next => from_next, to_prev => internal_control);

end structural;