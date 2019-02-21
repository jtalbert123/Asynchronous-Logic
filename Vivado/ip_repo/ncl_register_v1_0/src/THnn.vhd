library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.math_real.all;
use work.ncl.all;

-- an OR gate
entity THnn is
  generic(N : integer := 2);
  port(isig : in  std_logic_vector(N-1 downto 0);
       osig : out std_logic := '0');
end THnn;

architecture simple of THnn is

  component TH22 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       osig : out std_logic := '0');
  end component;
  
  component TH33 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       osig : out std_logic := '0');
  end component;
  
  component TH44 is
  port(iA : in  std_logic;
       iB : in  std_logic;
       iC : in  std_logic;
       iD : in  std_logic;
       osig : out std_logic := '0');
  end component;
  
  component THnn is
  generic(N : integer := 2);
  port(isig : in  std_logic_vector(N-1 downto 0);
       osig : out std_logic := '0');
  end component;
  
  constant log4 : real := log2(real(N))/log2(real(4));
  constant div4 : integer := N/4;
  constant mod4 : integer := N mod 4;
  constant num_on_iA : integer := div4 - max(0 - max(mod4, 0), -1);
  constant num_on_iB : integer := div4 - max(0 - max(mod4-1, 0), -1);
  constant num_on_iC : integer := div4 - max(0 - max(mod4-2, 0), -1);
  constant num_on_iD : integer := div4;
  signal outs : std_logic_vector(3 downto 0);
  signal recursive_inputs_iA : std_logic_vector(num_on_iA-1 downto 0);
  signal recursive_inputs_iB : std_logic_vector(num_on_iB-1 downto 0);
  signal recursive_inputs_iC : std_logic_vector(num_on_iC-1 downto 0);
  signal recursive_inputs_iD : std_logic_vector(num_on_iD-1 downto 0);
  signal recursive_outputs : std_logic_vector(3 downto 0);
  signal fb : std_logic;
begin

  gen_1: if N = 1 generate
    -- one input, indexing used to get from vector to a single bit
    osig <= isig(0);
  end generate;
  
  gen_2: if N = 2 generate
    gate : TH22
             port map(iA => isig(0),
                      iB => isig(1),
                      osig => osig);
  end generate;
  
  gen_3: if N = 3 generate
    gate : TH33
             port map(iA => isig(0),
                      iB => isig(1),
                      iC => isig(2),
                      osig => osig);
  end generate;
  
  gen_4: if N = 4 generate
    gate : TH44
             port map(iA => isig(0),
                      iB => isig(1),
                      iC => isig(2),
                      iD => isig(3),
                      osig => osig);
  end generate;
  
  gen_N: if N > 4 generate
      
      recursive_inputs_iA <= isig(num_on_iA-1 downto 0);
      recursive_inputs_iB <= isig(num_on_iA+num_on_iB-1 downto num_on_iA);
      recursive_inputs_iC <= isig(num_on_iA+num_on_iB+num_on_iC-1 downto num_on_iA+num_on_iB);
      recursive_inputs_iD <= isig(num_on_iA+num_on_iB+num_on_iC+num_on_iD-1 downto num_on_iA+num_on_iB+num_on_iC);
      
      gate_A : THnn
               generic map(N => num_on_iA)
               port map(isig => recursive_inputs_iA,
                        osig => recursive_outputs(0));
                        
      gate_B : THnn
               generic map(N => num_on_iB)
               port map(isig => recursive_inputs_iB,
                        osig => recursive_outputs(1));
                        
      gate_C : THnn
               generic map(N => num_on_iC)
               port map(isig => recursive_inputs_iC,
                        osig => recursive_outputs(2));
                        
      gate_D : THnn
               generic map(N => num_on_iD)
               port map(isig => recursive_inputs_iD,
                        osig => recursive_outputs(3));
                        
      gate_combine : TH44
               port map(iA => recursive_outputs(0),
                        iB => recursive_outputs(1),
                        iC => recursive_outputs(2),
                        iD => recursive_outputs(3),
                        osig => osig);
  end generate;
  
  --osig <= fb;

  --process(isig, fb) begin
    --if (to_integer(signed(isig)) = -1) then fb <= '1';
    --elsif (to_integer(unsigned(isig)) = 0) then fb <= '0';
    --else fb <= fb;
    --end if;
  --end process;
  
end simple;