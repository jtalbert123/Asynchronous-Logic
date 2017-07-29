library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity Adder_TB is
 port(iA        : in ncl_pair;
      iB        : in ncl_pair;
      iC        : in ncl_pair;
      to_prev   : out std_logic;
--      from_next : in std_logic;
      oS        : out ncl_pair;
      oC        : out ncl_pair);
end entity Adder_TB;

architecture structural of Adder_TB is
  signal A : ncl_pair;
  signal B : ncl_pair;
  signal Cin : ncl_pair;

  signal S : ncl_pair;
  signal Cout : ncl_pair;

  signal outS : ncl_pair;
  signal outC : ncl_pair;

  signal internal_control : std_logic;
  signal from_next : std_logic;
begin
  RegBefore: RegisterN
         generic map(N => 3)
         port map(inputs(0) => iA, inputs(1) => iB, inputs(2) => iC,
                  output(0) =>  A, output(1) =>  B, output(2) =>  Cin,
                  from_next => internal_control, to_prev => to_prev);

  Adder: FullAdder
           port map(iA => iA, iB => iB, iC => Cin,
                    oS => S, oC => Cout);

  RegAfter: RegisterN
         generic map(N => 2)
         port map(inputs(0) =>  S, inputs(1) =>  Cout,
                  output(0) => outS, output(1) => outC,
                  from_next => from_next, to_prev => internal_control);
  oS <= outS;
  oC <= outC;
  AutoCntl: process (outS, outC)
  begin
    if (outS.DATA0 = '0' and outS.DATA1 = '0' and outC.DATA0 = '0' and outC.DATA1 = '0') then
      -- Null Case
      from_next <= '1';
    elsif ((outS.DATA0 = '1' or outS.DATA1 = '1') and (outC.DATA0 = '1' or outC.DATA1 = '1')) then
      -- Data Case
      from_next <= '0';
    end if;
  end process AutoCntl;

end structural;