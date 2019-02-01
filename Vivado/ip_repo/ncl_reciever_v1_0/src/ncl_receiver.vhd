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

entity ncl_reciever is
  generic(N1 : integer := 1;
          N2 : integer := 0;
          N3 : integer := 0;
          N4 : integer := 0;
          N5 : integer := 0;
          N6 : integer := 0;
          N7 : integer := 0;
          N8 : integer := 0;
          N9 : integer := 0;
          N10 : integer := 0);
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
        -- What this block wants to recieve (data or null)
        to_prev   : out std_logic;
        completion: out std_logic;
        any_active: out std_logic);
end ncl_reciever;

architecture Behavioral of ncl_reciever is
  constant total : integer := N1+N2+N3+N4+N5+N6+N7+N8+N9+N10;
  signal iData : ncl_pair_vector(total-1 downto 0);
  signal per_signal_completion : std_logic_vector(total-1 downto 0);
  signal completion_sig : std_logic;
  signal any_zeros, any_ones : std_logic;
begin

  data1: if (N1 > 0) generate
      iData(N1-1 downto 0) <= to_ncl_pair_vector(iData1_0, iData1_1);
      oData1_0 <= iData1_0;
      oData1_1 <= iData1_1;
  end generate;
  
  data2: if (N2 > 0) generate
      iData(N1+N2-1 downto N1) <= to_ncl_pair_vector(iData2_0, iData2_1);
      oData2_0 <= iData2_0;
      oData2_1 <= iData2_1;
  end generate;
  
  data3: if (N3 > 0) generate
      iData(N1+N2+N3-1 downto N1+N2) <= to_ncl_pair_vector(iData3_0, iData3_1);
      oData3_0 <= iData3_0;
      oData3_1 <= iData3_1;
  end generate;
  
  data4: if (N4 > 0) generate
      iData(N1+N2+N3+N4-1 downto N1+N2+N3) <= to_ncl_pair_vector(iData4_0, iData4_1);
      oData4_0 <= iData4_0;
      oData4_1 <= iData4_1;
  end generate;
  
  data5: if (N5 > 0) generate
      iData(N1+N2+N3+N4+N5-1 downto N1+N2+N3+N4) <= to_ncl_pair_vector(iData5_0, iData5_1);
      oData5_0 <= iData5_0;
      oData5_1 <= iData5_1;
  end generate;
  
  data6: if (N6 > 0) generate
      iData(N1+N2+N3+N4+N5+N6-1 downto N1+N2+N3+N4+N5) <= to_ncl_pair_vector(iData6_0, iData6_1);
      oData6_0 <= iData6_0;
      oData6_1 <= iData6_1;
  end generate;
  
  data7: if (N7 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7-1 downto N1+N2+N3+N4+N5+N6) <= to_ncl_pair_vector(iData7_0, iData7_1);
      oData7_0 <= iData7_0;
      oData7_1 <= iData7_1;
  end generate;
  
  data8: if (N8 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8-1 downto N1+N2+N3+N4+N5+N6+N7) <= to_ncl_pair_vector(iData8_0, iData8_1);
      oData8_0 <= iData8_0;
      oData8_1 <= iData8_1;
  end generate;
  
  data9: if (N9 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8+N9-1 downto N1+N2+N3+N4+N5+N6+N7+N8) <= to_ncl_pair_vector(iData9_0, iData9_1);
      oData9_0 <= iData9_0;
      oData9_1 <= iData9_1;
  end generate;
  
  data10: if (N10 > 0) generate
      iData(N1+N2+N3+N4+N5+N6+N7+N8+N9+N10-1 downto N1+N2+N3+N4+N5+N6+N7+N8+N9) <= to_ncl_pair_vector(iData10_0, iData10_1);
      oData10_0 <= iData10_0;
      oData10_1 <= iData10_1;
  end generate;
  
 bits: for i in total-1 downto 0 generate
   bit_completion: TH12
                       port map(iA => iData(i).DATA0,
                                iB => iData(i).DATA1,
                                osig => per_signal_completion(i));
 end generate;

  all_completion: THnn
                    generic map(N => total)
                    port map(isig => per_signal_completion,
                             osig => completion_sig);
                             
  any_completion_0: TH1n
                    generic map(N => total)
                    port map(isig => to_data0_vector(iData),
                             osig => any_zeros);
                             
  any_completion_1: TH1n
                    generic map(N => total)
                    port map(isig => to_data0_vector(iData),
                             osig => any_ones);
  
  to_prev <= NOT(completion_sig);
  completion <= completion_sig;
  any_active <= any_zeros OR any_ones;
  
end Behavioral;
