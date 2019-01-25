library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity DualRailRegister is
  generic(N : integer := 1);
  port(iData    : in ncl_pair_vector(N-1 downto 0);
       -- Indicates what the next block wants to receive (data or null)
       from_next : in std_logic;
       oData    : out ncl_pair_vector(N-1 downto 0);
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end DualRailRegister;

architecture structural of DualRailRegister is
  signal outs : ncl_pair_vector(N-1 downto 0);
  signal watchers : std_logic_vector(N-1 downto 0);
  signal watcher_out : std_logic := '0';
begin

  register_gates: for i in N-1 downto 0 generate
    Reg_i0 : TH22
               port map(iA => iData(i).DATA0,
                        iB => from_next,
                        osig => outs(i).DATA0);
    Reg_i1 : TH22
               port map(iA => iData(i).DATA1,
                        iB => from_next,
                        osig => outs(i).DATA1);

    watcher_i : TH12
               port map(iA => outs(i).DATA0,
                        iB => outs(i).DATA1,
                        osig => watchers(i));

    oData(i) <= outs(i);

  end generate register_gates;
  
  watcher: THnn
             generic map (N => N)
             port map (isig => watchers,
                       osig => watcher_out);

  WatcherOutput: to_prev <= NOT watcher_out;

end structural; 