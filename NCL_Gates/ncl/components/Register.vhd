library ieee;
use ieee.std_logic_1164.all;
use work.ncl.all;

entity DualRailRegister is
  generic(N : integer := 1);
  port(iData_0    : in std_logic_vector(N-1 downto 0);
       iData_1    : in std_logic_vector(N-1 downto 0);
       -- Indicates what the next block wants to recieve (data or null)
       from_next : in std_logic;
       oData_0    : out std_logic_vector(N-1 downto 0);
       oData_1    : out std_logic_vector(N-1 downto 0);
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end DualRailRegister;

architecture structural of DualRailRegister is
  signal outs0 : std_logic_vector(N-1 downto 0);
  signal outs1 : std_logic_vector(N-1 downto 0);
  signal watchers : std_logic_vector(N-1 downto 0);
  signal watcher_out : std_logic := '0';
begin

  register_gates: for i in N-1 downto 0 generate
    Reg_i0 : TH22
               port map(iA => iData_0(i),
                        iB => from_next,
                        osig => outs0(i));
    Reg_i1 : TH22
               port map(iA => iData_1(i),
                        iB => from_next,
                        osig => outs1(i));

    watcher_i : TH12
               port map(iA => outs0(i),
                        iB => outs1(i),
                        osig => watchers(i));

    oData_0(i) <= outs0(i);
    oData_1(i) <= outs1(i);

  end generate register_gates;
  
  watcher: THnn
             generic map (N => N)
             port map (isig => watchers,
                       osig => watcher_out);

  WatcherOutput: to_prev <= NOT watcher_out;

end structural; 