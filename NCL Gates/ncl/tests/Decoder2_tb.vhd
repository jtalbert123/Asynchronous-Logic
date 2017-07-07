library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity Decoder2_tb is
 port(iA        : in ncl_pair;
      iB        : in ncl_pair;
      iSel        : in ncl_pair;
      to_prev   : out std_logic;
--      from_next : in std_logic;
      output    : out ncl_pair_vector(0 to 3));
end entity Decoder2_tb;

architecture structural of Decoder2_tb is
  signal A   : ncl_pair;
  signal B   : ncl_pair;

  signal out_internal : ncl_pair_vector(0 to 3);

  signal internal_control : std_logic;
  signal from_next : std_logic;
  signal out_buf : ncl_pair_vector(0 to 3);
begin
  RegBefore: RegisterN
         generic map(N => 2)
         port map(inputs(0) => iA, inputs(1) => iB,
                  output(0) =>  A, output(1) =>  B,
                  from_next => internal_control, to_prev => to_prev);

  Decoder2: Decoder
           generic map(NumInputs => 2)
           port map(inputs(0) => A, inputs(1) => B,
                    outputs => out_internal);

  RegAfter: RegisterN
         generic map(N => 4)
         port map(inputs => out_internal,
                  output => out_buf,
                  from_next => from_next, to_prev => internal_control);
  output <= out_buf;

  AutoCntl: process (out_buf)
  begin
    if ((out_buf(0).DATA0 = '0' and out_buf(0).DATA1 = '0') and 
        (out_buf(1).DATA0 = '0' and out_buf(1).DATA1 = '0') and 
        (out_buf(2).DATA0 = '0' and out_buf(2).DATA1 = '0') and 
        (out_buf(3).DATA0 = '0' and out_buf(3).DATA1 = '0')) then
      -- Null Case
      from_next <= '1';
    elsif ((out_buf(0).DATA0 = '1' or out_buf(0).DATA1 = '1') and
           (out_buf(1).DATA0 = '1' or out_buf(1).DATA1 = '1') and
           (out_buf(2).DATA0 = '1' or out_buf(2).DATA1 = '1') and
           (out_buf(3).DATA0 = '1' or out_buf(3).DATA1 = '1')) then
      -- Data Case
      from_next <= '0';
    end if;
  end process AutoCntl;
end structural;