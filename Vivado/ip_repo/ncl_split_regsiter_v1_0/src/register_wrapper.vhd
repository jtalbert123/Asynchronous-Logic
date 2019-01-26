----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2019 08:03:59 PM
-- Design Name: 
-- Module Name: register_wrapper - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ncl.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_wrapper is
  generic(N : integer := 1);
  Port (iData_0  : in std_logic_vector(N-1 downto 0);
        iData_1  : in std_logic_vector(N-1 downto 0);
       -- Indicates what the next block wants to receive (data or null)
       from_next1 : in std_logic;
       from_next2 : in std_logic;
       oData1_0   : out std_logic_vector(N-1 downto 0);
       oData1_1   : out std_logic_vector(N-1 downto 0);
       oData2_0   : out std_logic_vector(N-1 downto 0);
       oData2_1   : out std_logic_vector(N-1 downto 0);
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end register_wrapper;

architecture Behavioral of register_wrapper is

  component DualRailRegister is
    generic(N : integer := 1);
    port(iData    : in ncl_pair_vector(N-1 downto 0);
         -- Indicates what the next block wants to receive (data or null)
         from_next : in std_logic;
         oData    : out ncl_pair_vector(N-1 downto 0);
         -- What this block wants to recieve (data or null)
         to_prev   : out std_logic);
  end component;
  
  signal iData, oData : ncl_pair_vector(N-1 downto 0);
  signal from_next_combined : std_logic;
begin
  iData <= to_ncl_pair_vector(iData_0, iData_1);
  oData1_0 <= to_data0_vector(oData);
  oData1_1 <= to_data1_vector(oData);
  oData2_0 <= to_data0_vector(oData);
  oData2_1 <= to_data1_vector(oData);
  
  link : TH22
           port map(iA => from_next1,
                    iB => from_next2,
                    osig => from_next_combined);
  
  U0 : DualRailRegister
         port map(iData => iData,
                  oData => oData,
                  from_next => from_next_combined,
                  to_prev => to_prev);

end Behavioral;
