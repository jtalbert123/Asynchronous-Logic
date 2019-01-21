library IEEE;
use ieee.std_logic_1164.all;
use work.ncl.all;
use ieee.numeric_std.all;

entity MUX is
  generic(NumInputs : integer := 2);
  port(iOptions : in  ncl_pair_vector(0 to NumInputs-1);
       iSel     : in  ncl_pair_vector(0 to clog2(NumInputs)-1);
       output   : out ncl_pair);
end entity MUX;

architecture structural of MUX is
  constant NumSels : integer := clog2(NumInputs);

  type CaseGateInputs is array (integer range <>) of std_logic_vector(0 to NumSels-1);
  signal sels : CaseGateInputs(0 to NumInputs-1);
  signal condensed_selectors : std_logic_vector(0 to NumInputs-1);

  type GatedNInputs is array (integer range <>) of std_logic_vector(0 to 1);
  signal Gated0Inputs : GatedNInputs(0 to NumInputs-1);
  signal Gated1Inputs : GatedNInputs(0 to NumInputs-1);

  signal o0ins : std_logic_vector(0 to NumInputs-1);
  signal o1ins : std_logic_vector(0 to NumInputs-1); signal i : integer := 0;
begin
  
  Rows: for i in 0 to NumInputs-1 generate
    CntlBits: for selBit in 0 to NumSels-1 generate
      Cntl0Selection: if (to_signed(2**selBit, NumSels+1) and to_signed(i, NumSels+1)) = 0 generate
        sels(i)(selBit) <= iSel(selBit).Data0;
      end generate;
      Cntl1Selection: if (to_signed(2**selBit, NumSels+1) and to_signed(i, NumSels+1)) > 0 generate
        sels(i)(selBit) <= iSel(selBit).Data1;
      end generate; -- Cntl line selection
    end generate; -- CntlBits
    RowCntl: THmn
               generic map(N => NumSels, M => NumSels)
               port map(inputs => sels(i), output => condensed_selectors(i));
    
    Gated0Inputs(i) <= condensed_selectors(i) & iOptions(i).Data0;
    Gated0: THmn
              generic map(N => 2, M=> 2)
              port map(inputs => Gated0Inputs(i),
                       output => o0ins(i));

    Gated1Inputs(i) <= condensed_selectors(i) & iOptions(i).Data1;
    Gated1: THmn
              generic map(N => 2, M=> 2)
              port map(inputs => Gated1Inputs(i),
                       output => o1ins(i));

  end generate; -- Rows

  out0: THmn
          generic map(N => NumInputs, M => 1)
          port map(inputs => o0ins, output => output.Data0);

  out1: THmn
          generic map(N => NumInputs, M => 1)
          port map(inputs => o1ins, output => output.Data1);
  
end structural;

library IEEE;
use ieee.std_logic_1164.all;
use work.ncl.all;
use ieee.numeric_std.all;

entity MUX_RAW is
  generic(NumInputs : integer := 2);
  port(iOptions : in  ncl_pair_vector(0 to NumInputs-1);
       iSel     : in  std_logic_vector(0 to NumInputs-1);
       output   : out ncl_pair);
end entity MUX_RAW;

architecture structural of MUX_RAW is
  constant NumSels : integer := clog2(NumInputs);

  type CaseGateInputs is array (integer range <>) of std_logic_vector(0 to NumSels-1);
  signal sels : CaseGateInputs(0 to NumInputs-1);

  type GatedNInputs is array (integer range <>) of std_logic_vector(0 to 1);
  signal Gated0Inputs : GatedNInputs(0 to NumInputs-1);
  signal Gated1Inputs : GatedNInputs(0 to NumInputs-1);

  signal o0ins : std_logic_vector(0 to NumInputs-1);
  signal o1ins : std_logic_vector(0 to NumInputs-1); signal i : integer := 0;
begin
  
  Rows: for i in 0 to NumInputs-1 generate

    Gated0Inputs(i) <= iSel(i) & iOptions(i).Data0;
    Gated0: THmn
              generic map(N => 2, M=> 2)
              port map(inputs => Gated0Inputs(i),
                       output => o0ins(i));

    Gated1Inputs(i) <= iSel(i) & iOptions(i).Data1;
    Gated1: THmn
              generic map(N => 2, M=> 2)
              port map(inputs => Gated1Inputs(i),
                       output => o1ins(i));

  end generate; -- Rows

  out0: THmn
          generic map(N => NumInputs, M => 1)
          port map(inputs => o0ins, output => output.Data0);

  out1: THmn
          generic map(N => NumInputs, M => 1)
          port map(inputs => o1ins, output => output.Data1);
  
end structural; 