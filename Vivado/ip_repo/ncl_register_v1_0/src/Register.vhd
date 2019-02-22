library IEEE;
use IEEE.std_logic_1164.all;
use work.ncl.all;

entity DualRailRegister is
  generic(N : integer := 1;
          reset_to_data : boolean := FALSE;
          reset_val : integer := 0);
  port(iData    : in ncl_pair_vector(N-1 downto 0);
       -- Indicates what the next block wants to receive (data or null)
       from_next : in std_logic;
       oData    : out ncl_pair_vector(N-1 downto 0);
       reset : in  std_logic;
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end DualRailRegister;

architecture structural of DualRailRegister is
  
  component TH12 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
  end component;

  component TH22n is
  port(iA : in  std_logic;
       iB : in  std_logic;
       reset : in  std_logic;
       osig : out std_logic := '0');
  end component;
  
  component TH22d is
  port(iA : in  std_logic;
       iB : in  std_logic;
       reset : in  std_logic;
       osig : out std_logic := '0');
  end component;

  -- a NCL AND gate
  component THnn is
    generic(N : integer := 2);
    port(isig : in  std_logic_vector(N-1 downto 0);
         osig : out std_logic := '0');
  end component;
  
  signal outs : ncl_pair_vector(N-1 downto 0);
  signal watchers : std_logic_vector(N-1 downto 0);
  signal watcher_out : std_logic := '0';
begin

  register_gates: for i in N-1 downto 0 generate
    i0_n: if (NOT(reset_to_data) OR reset_val/(2**i) mod 2 = 1) generate
        Reg_i0 : TH22n
                   port map(iA => iData(i).DATA0,
                            iB => from_next,
                            reset => reset,
                            osig => outs(i).DATA0);
    end generate;
    i0_d: if (reset_to_data AND reset_val/(2**i) mod 2 = 0) generate
        Reg_i0 : TH22d
                   port map(iA => iData(i).DATA0,
                            iB => from_next,
                            reset => reset,
                            osig => outs(i).DATA0);
    end generate;
    
    i1_n: if (NOT(reset_to_data) OR reset_val/(2**i) mod 2 = 0) generate
        Reg_i1 : TH22n
                   port map(iA => iData(i).DATA1,
                            iB => from_next,
                            reset => reset,
                            osig => outs(i).DATA1);
    end generate;
    i1_d: if (reset_to_data AND reset_val/(2**i) mod 2 = 1) generate
        Reg_i1 : TH22d
                   port map(iA => iData(i).DATA1,
                            iB => from_next,
                            reset => reset,
                            osig => outs(i).DATA1);
    end generate;
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

  WatcherOutput: to_prev <= NOT (watcher_out);

end structural; 