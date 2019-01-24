library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.ncl.all;

entity Counter_4bit is
  port(output : out ncl_pair_vector(0 to 4));
end Counter_4bit;

architecture sequential of Counter_4bit is

  type stage_signals is array (integer range <>) of ncl_pair_vector(0 to 3);
  signal stage_inputs : stage_signals(0 to 2);
  
  signal links : std_logic_vector(0 to 2);

  signal adder_input : ncl_pair_vector(0 to 3);
  signal adder_B : ncl_pair_vector(0 to 3);

  signal adder_iC : ncl_pair;

begin

  process (adder_input)
  begin
    if ((adder_input(0).DATA0 = '0' and adder_input(0).DATA1 = '0') or
        (adder_input(1).DATA0 = '0' and adder_input(1).DATA1 = '0') or
        (adder_input(2).DATA0 = '0' and adder_input(2).DATA1 = '0') or
        (adder_input(3).DATA0 = '0' and adder_input(3).DATA1 = '0')) then
      adder_B(0).DATA0 <= '0';
      adder_B(0).DATA1 <= '0';

      adder_B(1).DATA0 <= '0';
      adder_B(1).DATA1 <= '0';

      adder_B(2).DATA0 <= '0';
      adder_B(2).DATA1 <= '0';

      adder_B(3).DATA0 <= '0';
      adder_B(3).DATA1 <= '0';
      
      adder_iC.DATA0 <= '0';
      adder_iC.DATA1 <= '0';
    end if;
    if ((adder_input(0).DATA0 = '1' or adder_input(0).DATA1 = '1') and
        (adder_input(1).DATA0 = '1' or adder_input(1).DATA1 = '1') and
        (adder_input(2).DATA0 = '1' or adder_input(2).DATA1 = '1') and
        (adder_input(3).DATA0 = '1' or adder_input(3).DATA1 = '1')) then
      adder_B(0).DATA0 <= '0';
      adder_B(0).DATA1 <= '1';

      adder_B(1).DATA0 <= '1';
      adder_B(1).DATA1 <= '0';

      adder_B(2).DATA0 <= '1';
      adder_B(2).DATA1 <= '0';

      adder_B(3).DATA0 <= '1';
      adder_B(3).DATA1 <= '0';
      
      adder_iC.DATA0 <= '1';
      adder_iC.DATA1 <= '0';
    end if;
  end process;

  stage0: RegisterN
    generic map(N => 4)
    port map(inputs => stage_inputs(0),
             output => adder_input,
             to_prev => links(0),
             from_next => links(1));

  counter: Adder
    port map(iC => adder_iC,
             iA => adder_input,
             iB => adder_B,
             oS => stage_inputs(1),
             oC => output(4));

--  stage_inputs(1) <= adder_input;

  stage1: RegisterN
    generic map(N => 4)
    port map(inputs => stage_inputs(1),
             output => stage_inputs(2),
             to_prev => links(1),
             from_next => links(2));

  output(0 to 3) <= stage_inputs(1);

  stage2: RegisterN
    generic map(N => 4)
    port map(inputs => stage_inputs(2),
             output => stage_inputs(0),
             to_prev => links(2),
             from_next => links(0));

end sequential;
