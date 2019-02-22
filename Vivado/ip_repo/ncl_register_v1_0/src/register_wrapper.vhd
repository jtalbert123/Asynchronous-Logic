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
  generic(N1 : integer := 1;
          N2 : integer := 0;
          N3 : integer := 0;
          N4 : integer := 0;
          N5 : integer := 0;
          N6 : integer := 0;
          N7 : integer := 0;
          N8 : integer := 0;
          N9 : integer := 0;
          N10 : integer := 0;
          reset_to_data : boolean := FALSE;
          PORT1_RESET_VAL : integer := 0;
          PORT2_RESET_VAL : integer := 0;
          PORT3_RESET_VAL : integer := 0;
          PORT4_RESET_VAL : integer := 0;
          PORT5_RESET_VAL : integer := 0;
          PORT6_RESET_VAL : integer := 0;
          PORT7_RESET_VAL : integer := 0;
          PORT8_RESET_VAL : integer := 0;
          PORT9_RESET_VAL : integer := 0;
          PORT10_RESET_VAL : integer := 0);
  Port (iData1_0  : in std_logic_vector(max(1, N1)-1 downto 0);
        iData1_1  : in std_logic_vector(max(1, N1)-1 downto 0);
        iData2_0  : in std_logic_vector(max(1, N2)-1 downto 0);
        iData2_1  : in std_logic_vector(max(1, N2)-1 downto 0);
        iData3_0  : in std_logic_vector(max(1, N3)-1 downto 0);
        iData3_1  : in std_logic_vector(max(1, N3)-1 downto 0);
        iData4_0  : in std_logic_vector(max(1, N4)-1 downto 0);
        iData4_1  : in std_logic_vector(max(1, N4)-1 downto 0);
        iData5_0  : in std_logic_vector(max(1, N5)-1 downto 0);
        iData5_1  : in std_logic_vector(max(1, N5)-1 downto 0);
        iData6_0  : in std_logic_vector(max(1, N6)-1 downto 0);
        iData6_1  : in std_logic_vector(max(1, N6)-1 downto 0);
        iData7_0  : in std_logic_vector(max(1, N7)-1 downto 0);
        iData7_1  : in std_logic_vector(max(1, N7)-1 downto 0);
        iData8_0  : in std_logic_vector(max(1, N8)-1 downto 0);
        iData8_1  : in std_logic_vector(max(1, N8)-1 downto 0);
        iData9_0  : in std_logic_vector(max(1, N9)-1 downto 0);
        iData9_1  : in std_logic_vector(max(1, N9)-1 downto 0);
        iData10_0 : in std_logic_vector(max(1, N10)-1 downto 0);
        iData10_1 : in std_logic_vector(max(1, N10)-1 downto 0);
        -- Indicates what the next block wants to receive (data or null)
        from_next : in std_logic;
        oData1_0  : out std_logic_vector(max(1, N1)-1 downto 0);
        oData1_1  : out std_logic_vector(max(1, N1)-1 downto 0);
        oData2_0  : out std_logic_vector(max(1, N2)-1 downto 0);
        oData2_1  : out std_logic_vector(max(1, N2)-1 downto 0);
        oData3_0  : out std_logic_vector(max(1, N3)-1 downto 0);
        oData3_1  : out std_logic_vector(max(1, N3)-1 downto 0);
        oData4_0  : out std_logic_vector(max(1, N4)-1 downto 0);
        oData4_1  : out std_logic_vector(max(1, N4)-1 downto 0);
        oData5_0  : out std_logic_vector(max(1, N5)-1 downto 0);
        oData5_1  : out std_logic_vector(max(1, N5)-1 downto 0);
        oData6_0  : out std_logic_vector(max(1, N6)-1 downto 0);
        oData6_1  : out std_logic_vector(max(1, N6)-1 downto 0);
        oData7_0  : out std_logic_vector(max(1, N7)-1 downto 0);
        oData7_1  : out std_logic_vector(max(1, N7)-1 downto 0);
        oData8_0  : out std_logic_vector(max(1, N8)-1 downto 0);
        oData8_1  : out std_logic_vector(max(1, N8)-1 downto 0);
        oData9_0  : out std_logic_vector(max(1, N9)-1 downto 0);
        oData9_1  : out std_logic_vector(max(1, N9)-1 downto 0);
        oData10_0 : out std_logic_vector(max(1, N10)-1 downto 0);
        oData10_1 : out std_logic_vector(max(1, N10)-1 downto 0);
        reset : in  std_logic;
       -- What this block wants to recieve (data or null)
       to_prev   : out std_logic);
end register_wrapper;

architecture Behavioral of register_wrapper is

  component DualRailRegister is
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
  end component;
  
  signal iData, oData : ncl_pair_vector(N1+N2+N3+N4+N5+N6+N7+N8+N9+N10-1 downto 0);
  
  function get_reset_val(a : integer) return integer is
      variable val : integer := 0;
  begin
      if (N1 > 0) then
          val := val + PORT1_RESET_VAL;
      end if;
      if (N2 > 0) then
          val := val + PORT2_RESET_VAL * (2**(N1));
      end if;
      if (N3 > 0) then
          val := val + PORT3_RESET_VAL * (2**(N1+N2));
      end if;
      if (N4 > 0) then
          val := val + PORT4_RESET_VAL * (2**(N1+N2+N3));
      end if;
      if (N5 > 0) then
          val := val + PORT5_RESET_VAL * (2**(N1+N2+N3+N4));
      end if;
      if (N6 > 0) then
          val := val + PORT6_RESET_VAL * (2**(N1+N2+N3+N4+N5));
      end if;
      if (N7 > 0) then
          val := val + PORT7_RESET_VAL * (2**(N1+N2+N3+N4+N5+N6));
      end if;
      if (N8 > 0) then
          val := val + PORT8_RESET_VAL * (2**(N1+N2+N3+N4+N5+N6+N7));
      end if;
      if (N9 > 0) then
          val := val + PORT9_RESET_VAL * (2**(N1+N2+N3+N4+N5+N6+N7+N8));
      end if;
      if (N10 > 0) then
          val := val + PORT10_RESET_VAL * (2**(N1+N2+N3+N4+N5+N6+N7+N8+N9));
      end if;
      return val;
  end function;
  constant reset_val : integer := get_reset_val(0);
begin
  data1: if (N1 > 0) generate
      iData(N1-1 downto 0) <= to_ncl_pair_vector(iData1_0, iData1_1);
      oData1_0 <= to_data0_vector(oData(N1-1 downto 0));
      oData1_1 <= to_data1_vector(oData(N1-1 downto 0));
  end generate;
  
  data2: if (N2 > 0) generate
      iData(N1+N2-1 downto N1) <= to_ncl_pair_vector(iData2_0, iData2_1);
      oData2_0 <= to_data0_vector(oData(N1+N2-1 downto N1));
      oData2_1 <= to_data1_vector(oData(N1+N2-1 downto N1));
  end generate;
  
  data3: if (N3 > 0) generate
      iData(N1+N2+N3-1 downto N1+N2) <= to_ncl_pair_vector(iData3_0, iData3_1);
      oData3_0 <= to_data0_vector(oData(N1+N2+N3-1 downto N1+N2));
      oData3_1 <= to_data1_vector(oData(N1+N2+N3-1 downto N1+N2));
  end generate;
  
  data4: if (N4 > 0) generate
      iData(N1+N2+N3+N4-1 downto N1+N2+N3) <= to_ncl_pair_vector(iData4_0, iData4_1);
      oData4_0 <= to_data0_vector(oData(N1+N2+N3+N4-1 downto N1+N2+N3));
      oData4_1 <= to_data1_vector(oData(N1+N2+N3+N4-1 downto N1+N2+N3));
  end generate;
  
  data5: if (N5 > 0) generate
      iData(N1+N2+N3+N4+N5-1 downto N1+N2+N3+N4) <= to_ncl_pair_vector(iData5_0, iData5_1);
      oData5_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5-1 downto N1+N2+N3+N4));
      oData5_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5-1 downto N1+N2+N3+N4));
  end generate;
  
  data6: if (N6 > 0) generate
      iData(N1+N2+N3+N4+N5+N6-1 downto N1+N2+N3+N4+N5) <= to_ncl_pair_vector(iData6_0, iData6_1);
      oData6_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5+N6-1 downto N1+N2+N3+N4+N5));
      oData6_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5+N6-1 downto N1+N2+N3+N4+N5));
  end generate;
  
  data7: if (N7 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7-1 downto N1+N2+N3+N4+N5+N6) <= to_ncl_pair_vector(iData7_0, iData7_1);
      oData7_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5+N6+N7-1 downto N1+N2+N3+N4+N5+N6));
      oData7_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5+N6+N7-1 downto N1+N2+N3+N4+N5+N6));
  end generate;
  
  data8: if (N8 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8-1 downto N1+N2+N3+N4+N5+N6+N7) <= to_ncl_pair_vector(iData8_0, iData8_1);
      oData8_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8-1 downto N1+N2+N3+N4+N5+N6+N7));
      oData8_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8-1 downto N1+N2+N3+N4+N5+N6+N7));
  end generate;
  
  data9: if (N9 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8+N9-1 downto N1+N2+N3+N4+N5+N6+N7+N8) <= to_ncl_pair_vector(iData9_0, iData9_1);
      oData9_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8+N9-1 downto N1+N2+N3+N4+N5+N6+N7+N8));
      oData9_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8+N9-1 downto N1+N2+N3+N4+N5+N6+N7+N8));
  end generate;
  
  data10: if (N10 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8+N9+N10-1 downto N1+N2+N3+N4+N5+N6+N7+N8+N9) <= to_ncl_pair_vector(iData10_0, iData10_1);
      oData10_0 <= to_data0_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8+N9+N10-1 downto N1+N2+N3+N4+N5+N6+N7+N8+N9));
      oData10_1 <= to_data1_vector(oData(N1+N2+N3+N4+N5+N6+N7+N8+N9+N10-1 downto N1+N2+N3+N4+N5+N6+N7+N8+N9));
  end generate;
  
 U0 : DualRailRegister
        generic map(N => N1+N2+N3+N4+N5+N6+N7+N8+N9+N10,
                    reset_to_data => reset_to_data,
                    reset_val => reset_val)
        port map(iData => iData,
                 oData => oData,
                 reset => reset,
                 from_next => from_next,
                 to_prev => to_prev);

end Behavioral;