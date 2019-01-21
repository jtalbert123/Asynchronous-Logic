library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;
use ieee.numeric_std.all;

entity Decoder is
  generic(NumInputs : integer := 2);
  port(inputs  : in  ncl_pair_vector(0 to NumInputs-1);
       outputs : out ncl_pair_vector(0 to (2**NumInputs)-1));
end entity Decoder;

architecture structural of Decoder is
  constant NumOutputs : integer := 2 ** NumInputs;

  type GateInputs is array (integer range <>) of std_logic_vector(0 to NumInputs - 1);
  signal Gate0Inputs : GateInputs(0 to NumOutputs-1);
  signal Gate1Inputs : GateInputs(0 to NumOutputs-1);
begin
  Rows: for i in 0 to NumOutputs - 1 generate
    cntlBits: for iBit in 0 to NumInputs - 1 generate
      Cntl0Selection: if (to_signed(2**iBit, NumInputs+1) and to_signed(i, NumInputs+1)) = 0 generate
        Gate0Inputs(i)(iBit) <= inputs(iBit).DATA1;
        Gate1Inputs(i)(iBit) <= inputs(iBit).DATA0;
      end generate;
      Cntl1Selection: if (to_signed(2**iBit, NumInputs+1) and to_signed(i, NumInputs+1)) > 0 generate
        Gate0Inputs(i)(iBit) <= inputs(iBit).DATA0;
        Gate1Inputs(i)(iBit) <= inputs(iBit).DATA1;
      end generate;
    end generate;
    Gate0: THmn
             generic map(N => NumInputs, M => 1)
             port map(inputs => Gate0Inputs(i),
                      output => outputs(i).DATA0);
    Gate1: THmn
             generic map(N => NumInputs, M => NumInputs)
             port map(inputs => Gate1Inputs(i),
                      output => outputs(i).DATA1);
  end generate;
end structural;

library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;
use ieee.numeric_std.all;

entity DMUX1 is
  generic(NumInputs : integer := 2);
  port(inputs  : in  ncl_pair_vector(0 to NumInputs-1);
       outputs : out std_logic_vector(0 to (2**NumInputs)-1));
end entity DMUX1;

architecture structural of DMUX1 is
  constant NumOutputs : integer := 2 ** NumInputs;

  type GateInputs is array (integer range <>) of std_logic_vector(0 to NumInputs - 1);
  signal Gate1Inputs : GateInputs(0 to NumOutputs-1);
begin
  Rows: for i in 0 to NumOutputs - 1 generate
    cntlBits: for iBit in 0 to NumInputs - 1 generate
      Cntl0Selection: if (to_signed(2**iBit, NumInputs+1) and to_signed(i, NumInputs+1)) = 0 generate
        Gate1Inputs(i)(iBit) <= inputs(iBit).DATA0;
      end generate;
      Cntl1Selection: if (to_signed(2**iBit, NumInputs+1) and to_signed(i, NumInputs+1)) > 0 generate
        Gate1Inputs(i)(iBit) <= inputs(iBit).DATA1;
      end generate;
    end generate;
    Gate1: THmn
             generic map(N => NumInputs, M => NumInputs)
             port map(inputs => Gate1Inputs(i),
                      output => outputs(i));
  end generate;
end structural;