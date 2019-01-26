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

entity ncl_splitter is
  generic(NBITS : integer := 1;
          PORTS : integer := 1);
  Port (iData_0  : in std_logic_vector(NBITS-1 downto 0);
        iData_1  : in std_logic_vector(NBITS-1 downto 0);
        
        from_next1 : in std_logic;
        from_next2 : in std_logic;
        from_next3 : in std_logic;
        from_next4 : in std_logic;
        
        oData1_0  : out std_logic_vector(NBITS-1 downto 0);
        oData1_1  : out std_logic_vector(NBITS-1 downto 0);
        oData2_0  : out std_logic_vector(NBITS-1 downto 0);
        oData2_1  : out std_logic_vector(NBITS-1 downto 0);
        oData3_0  : out std_logic_vector(NBITS-1 downto 0);
        oData3_1  : out std_logic_vector(NBITS-1 downto 0);
        oData4_0  : out std_logic_vector(NBITS-1 downto 0);
        oData4_1  : out std_logic_vector(NBITS-1 downto 0);
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end ncl_splitter;

architecture Behavioral of ncl_splitter is
  signal from_nexts : std_logic_vector(3 downto 0);
begin

  from_nexts <= (from_next4&from_next3&from_next2&from_next1);
  completion: THnn
                generic map(N => PORTS)
                port map(isig => from_nexts(PORTS-1 downto 0),
                         osig => to_prev);
  
  oData1_0 <= iData_0;
  oData1_1 <= iData_1;
  
  oData2_0 <= iData_0;
  oData2_1 <= iData_1;
  
  oData3_0 <= iData_0;
  oData3_1 <= iData_1;
  
  oData4_0 <= iData_0;
  oData4_1 <= iData_1;
  

end Behavioral;
