----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/24/2019 03:54:09 PM
-- Design Name: 
-- Module Name: ncl_fulladder_wrapper - structural
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

entity ncl_fulladder_wrapper is
    Port ( iA_0 : in STD_LOGIC;
           iA_1 : in STD_LOGIC;
           iB_0 : in STD_LOGIC;
           iB_1 : in STD_LOGIC;
           iC_0 : in STD_LOGIC;
           iC_1 : in STD_LOGIC;
           oS_0 : out STD_LOGIC;
           oS_1 : out STD_LOGIC;
           oC_0 : out STD_LOGIC;
           oC_1 : out STD_LOGIC);
end ncl_fulladder_wrapper;

architecture structural of ncl_fulladder_wrapper is
  signal A, B, Ci, S, Co: ncl_pair;
  signal adder_state : ncl_pair_vector(6 downto 0);
begin
  
  A <= (DATA0 => iA_0, DATA1 => iA_1);
  B <= (DATA0 => iB_0, DATA1 => iB_1);
  Ci <= (DATA0 => iC_0, DATA1 => iC_1);
  
  adder_state <= add(adder_state, A, B, Ci);
  Co <= adder_state(1);
  S <= adder_state(0);

  oS_0 <= S.DATA0;
  oS_1 <= S.DATA1;

  oC_0 <= Co.DATA0;
  oC_1 <= Co.DATA1;

end structural;
