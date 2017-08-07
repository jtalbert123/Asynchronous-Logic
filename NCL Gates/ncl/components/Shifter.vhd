library ieee;
use work.ncl.all;
use ieee.std_logic_1164.all;

entity Shifter is
  generic(NumInputs : integer := 2);
  port(inputs       : in ncl_pair_vector(0 to NumInputs - 1);
       shift_amount : in ncl_pair_vector(0 to clog2(NumInputs) - 1);
       direction    : in ncl_pair;
       rotate       : in ncl_pair;
       logical      : in ncl_pair;
       output       : out ncl_pair_vector(0 to NumInputs - 1));
end Shifter;

architecture structural of Shifter is
  constant NumShiftAmountBits : integer := clog2(NumInputs);
  constant NumRows : integer := clog2(NumInputs);
  
  type RowSignals is array (integer range <>) of ncl_pair_vector(0 to NumInputs - 1);
  signal rows : RowSignals(0 to NumRows);
  signal shift_in : RowSignals(0 to NumInputs-1);
  signal zero_in : ncl_pair;
  signal non_rotate_in : ncl_pair;

  signal input_reversed : ncl_pair_vector(0 to NumInputs - 1);
  signal output_reversed : ncl_pair_vector(0 to NumInputs - 1);

begin

  produceDATA0: THmn 
    generic map(M => 1, N => 2)
    port map(inputs(0) => inputs(0).DATA0,
             inputs(1) => inputs(0).DATA1,
             output => zero_in.DATA0);
  
  zero_in.DATA1 <= '0';

  msb_in_mux: MUX
    generic map(NumInputs => 4)
    port map(iOptions(0) => inputs(NumInputs-1),
             iOptions(1) => zero_in,
             iOptions(2) => zero_in,
             iOptions(3) => zero_in,
             iSel(0) => logical,
             iSel(1) => direction,
             output => non_rotate_in);

  in_bit_flipper: for i in 0 to NumInputs-1 generate
    input_reversed(i) <= inputs(NumInputs-1-i);

    directionMux: MUX
      generic map(NumInputs => 2)
      port map(iOptions(0) => inputs(i),
               iOptions(1) => input_reversed(i),
               iSel(0) => direction,
               output => rows(0)(i));
  end generate;

--  rows(0) <= inputs;

  rowsloop: for r in 0 to NumRows-1 generate
    columns: for c in 0 to NumInputs-1 generate
      ifstd: if (c + (2**r)) < NumInputs generate
        multiplexer: MUX
          generic map(NumInputs => 2)
          port map(iOptions(0) => rows(r)(c),
                   iOptions(1) => rows(r)(c + (2**r)),
                   iSel(0) => shift_amount(r),
                   output => rows(r+1)(c));

      end generate;

      ifwrp: if (c + (2**r)) >= NumInputs generate
        multiplexer: MUX
          generic map(NumInputs => 4)
          port map(iOptions(0) => rows(r)(c),
                   iOptions(1) => non_rotate_in,
                   iOptions(2) => rows(r)(c),
                   iOptions(3) => rows(r)((c+(2**r)) mod NumInputs),
                   iSel(0) => shift_amount(r),
                   iSel(1) => rotate,
                   output => rows(r+1)(c));

      end generate;
    end generate;
  end generate;

  out_bit_flipper: for i in 0 to NumInputs-1 generate
    output_reversed(i) <= rows(NumRows)(NumInputs - 1 - i);

    outMux: MUX
      generic map(NumInputs => 2)
      port map(iOptions(0) => rows(NumRows)(i),
               iOptions(1) => output_reversed(i),
               iSel(0) => direction,
               output => output(i));
  end generate;

end structural;
