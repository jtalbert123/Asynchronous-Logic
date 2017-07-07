library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity MUX2_tb is
 port(iA        : in ncl_pair;
      iB        : in ncl_pair;
      iSel        : in ncl_pair;
      to_prev   : out std_logic;
--      from_next : in std_logic;
      output    : out ncl_pair);
end entity MUX2_tb;

architecture structural of MUX2_tb is
  signal A   : ncl_pair;
  signal B   : ncl_pair;
  signal Sel : ncl_pair;

  signal out_internal : ncl_pair;

  signal internal_control : std_logic;
  signal from_next : std_logic;
  signal out_buf : ncl_pair;
begin
  RegBefore: RegisterN
         generic map(N => 3)
         port map(inputs(0) => iA, inputs(1) => iB, inputs(2) => iSel,
                  output(0) =>  A, output(1) =>  B, output(2) =>  Sel,
                  from_next => internal_control, to_prev => to_prev);

  MUX2: MUX
           generic map(NumInputs => 2)
           port map(iOptions(0) => A, iOptions(1) => B, iSel(0) => Sel,
                    output => out_internal);

  RegAfter: RegisterN
         generic map(N => 1)
         port map(inputs(0) => out_internal,
                  output(0) => out_buf,
                  from_next => from_next, to_prev => internal_control);
  output <= out_buf;

  AutoCntl: process (out_buf)
  begin
    if (out_buf.DATA0 = '0' and out_buf.DATA1 = '0') then
      -- Null Case
      from_next <= '1';
    elsif (out_buf.DATA0 = '1' or out_buf.DATA1 = '1') then
      -- Data Case
      from_next <= '0';
    end if;
  end process AutoCntl;

end structural;