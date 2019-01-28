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

entity ncl_adder_wrapper is
    Generic ( N : integer := 1);
    Port ( iA_0 : in STD_LOGIC_VECTOR(N-1 downto 0);
           iA_1 : in STD_LOGIC_VECTOR(N-1 downto 0);
           iB_0 : in STD_LOGIC_VECTOR(N-1 downto 0);
           iB_1 : in STD_LOGIC_VECTOR(N-1 downto 0);
           iC_0 : in STD_LOGIC;
           iC_1 : in STD_LOGIC;
           oS_0 : out STD_LOGIC_VECTOR(N-1 downto 0);
           oS_1 : out STD_LOGIC_VECTOR(N-1 downto 0);
           oC_0 : out STD_LOGIC;
           oC_1 : out STD_LOGIC);
end ncl_adder_wrapper;

architecture structural of ncl_adder_wrapper is
  signal A, B, S: ncl_pair_vector(N-1 downto 0);
  signal Ci, Co: ncl_pair;
  signal adder_state : ncl_pair_vector(7*N-1 downto 0);
begin
  
  A <= to_ncl_pair_vector(iA_0, iA_1);
  B <= to_ncl_pair_vector(iB_0, iB_1);
  Ci <= (DATA0 => iC_0, DATA1 => iC_1);
  
  adder_state <= add(adder_state, A, B, Ci);
  Co <= add_extractsum(adder_state)(N);
  S <= add_extractsum(adder_state)(N-1 downto 0);

  oS_0 <= to_data0_vector(S);
  oS_1 <= to_data1_vector(S);

  oC_0 <= Co.DATA0;
  oC_1 <= Co.DATA1;

end structural;
