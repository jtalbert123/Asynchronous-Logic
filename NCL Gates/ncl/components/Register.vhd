library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity RegisterN is
  generic(N : integer := 1;
          RegisterDelay : time := 20 ns);
  port(inputs    : in ncl_pair_vector(0 to N-1);
       from_next : in std_logic;
       output    : out ncl_pair_vector(0 to N-1);
       to_prev   : out std_logic);
end RegisterN;

architecture structural of RegisterN is
  signal outs : std_logic_vector(0 to (2*N)-1);
  signal watcher_out : std_logic := '0';
begin

  register_gates: for i in 0 to N-1 generate
    T22_i0 : THmn
               generic map(N => 2, M => 2, Delay => RegisterDelay)
               port map(inputs(0) => inputs(i).DATA0,
                        inputs(1) => from_next,
                        output => outs(2*i));
    output(i).DATA0 <= outs(2*i);

    T22_i1 : THmn
               generic map(N => 2, M => 2, Delay => RegisterDelay)
               port map(inputs(0) => inputs(i).DATA1,
                        inputs(1) => from_next,
                        output => outs(2*i+1));
    output(i).DATA1 <= outs(2*i+1);

  end generate register_gates;
  
  watcher: THmn
             generic map (N => N*2, M => N, Delay => 10 ns)
             port map (inputs => outs,
                       output => watcher_out);
  WatcherOutput: to_prev <= NOT watcher_out;
end structural; 