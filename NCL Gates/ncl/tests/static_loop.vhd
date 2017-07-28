library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity static_loop is
  generic(NumStages : integer := 6;
          NumLines : integer := 2);
end static_loop;

architecture structural of static_loop is
  type stageLines is array (integer range <>) of ncl_pair_vector(0 to NumLines-1);
  signal stages : stageLines(0 to NumStages - 1) := (others => (others => NCL_NULL));
  signal controls : std_logic_vector(0 to NumStages - 1);
begin
  
  stage: for i in 0 to NumStages - 1 generate
    stageRegister: RegisterN
      generic map(N  => NumLines,
                  RegisterDelay => 30 ns)
      port map(inputs => stages(i),
               output  => stages((i+1) mod NumStages),
               to_prev  => controls(i),
               from_next => controls((i+1) mod NumStages));
  end generate;
  
end structural;