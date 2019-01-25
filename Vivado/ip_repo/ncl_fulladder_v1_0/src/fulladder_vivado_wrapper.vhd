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
  component FullAdder is
    port(iA : in ncl_pair;
         iB : in ncl_pair;
         iC : in ncl_pair;
         oS : out ncl_pair;
         oC : out ncl_pair);
  end component;
  
  function add_local(prev : ncl_pair_vector; a : ncl_pair; b : ncl_pair; c : ncl_pair) return ncl_pair_vector is
    variable state : ncl_pair_vector(prev'length - 1 downto 0);
  begin
    -- a1b1
    state(2).DATA0 := TH34_f(prev(2).DATA0, a.DATA1, b.DATA1, c.DATA0, c.DATA1);
    -- a1c1
    state(2).DATA1 := TH34_f(prev(2).DATA1, a.DATA1, c.DATA1, b.DATA0, b.DATA1);
    -- b1c1
    state(3).DATA0 := TH34_f(prev(3).DATA0, b.DATA1, c.DATA1, a.DATA0, a.DATA1);
    state(1).DATA1 := TH13_f(prev(1).DATA1, state(2).DATA0, state(2).DATA1, state(3).DATA0);
    
    -- all 0
    state(3).DATA1 := TH33_f(prev(3).DATA1, a.DATA0, b.DATA0, c.DATA0);
    -- 2 0's
    state(4).DATA0 := TH23_f(prev(4).DATA0, a.DATA0, b.DATA0, c.DATA0);
    -- 1 1
     state(4).DATA1 := TH13_f(prev(4).DATA1, a.DATA1, b.DATA1, c.DATA1);
    -- all 0, or 2 zeros and a 1
    state(1).DATA0 := TH23w2_f(prev(1).DATA0, state(3).DATA1, state(4).DATA0, state(4).DATA1);
    
    -- all 1
    state(5).DATA0 := TH33_f(prev(5).DATA0, a.DATA1, b.DATA1, c.DATA1);
    -- all 1, or 2 zeros and a 1
    state(0).DATA1 := TH23w2_f(prev(0).DATA1, state(5).DATA0, state(4).DATA0, state(4).DATA1);
    
    -- 2 1's
    state(6).DATA0 := TH23_f(prev(6).DATA0, a.DATA1, b.DATA1, c.DATA1);
    -- 1 0
    state(6).DATA1 := TH13_f(prev(6).DATA1, a.DATA0, b.DATA0, c.DATA0);
    -- all 0, or 2 ones and a 0
    state(0).DATA0 := TH23w2_f(prev(0).DATA0, state(3).DATA1, state(6).DATA0, state(6).DATA1); 
    
    return state;
  end function;   
  
  signal A, B, Ci, S, Co: ncl_pair;
  signal adder_state : ncl_pair_vector(6 downto 0);
begin
  
  A <= (DATA0 => iA_0, DATA1 => iA_1);
  B <= (DATA0 => iB_0, DATA1 => iB_1);
  Ci <= (DATA0 => iC_0, DATA1 => iC_1);
  
  adder_state <= add_local(adder_state, A, B, Ci);
  Co <= adder_state(1);
  S <= adder_state(0);

  oS_0 <= S.DATA0;
  oS_1 <= S.DATA1;

  oC_0 <= Co.DATA0;
  oC_1 <= Co.DATA1;

end structural;