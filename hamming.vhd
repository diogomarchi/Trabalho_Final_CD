------------------------------------------------
-- Design: Hamming
-- Entity: 
-- Author: Andriy, Diogo, George & Matheus
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity hamming is
port ( i_A 	: in std_logic_vector (0 to 7);  -- selector
       o_S  : out std_logic_vector (0 to 11)); -- data output
end hamming;


architecture arch_1 of hamming is
begin
  process(i_A) 
  begin
    o_S(0)  <= i_A(0) XOR i_A(1) XOR i_A(3) XOR i_A(4) XOR i_A(6);
    o_S(1)  <= i_A(0) XOR i_A(2) XOR i_A(3) XOR i_A(5) XOR i_A(6);
    o_S(2)  <= i_A(0);
    o_S(3)  <= i_A(1) XOR i_A(2) XOR i_A(3) XOR i_A(7);
    o_S(4)  <= i_A(1);
    o_S(5)  <= i_A(2);
    o_S(6)  <= i_A(3);
    o_S(7)  <= i_A(4) XOR i_A(5) XOR i_A(6) XOR i_A(7);
    o_S(8)  <= i_A(4);
    o_S(9)  <= i_A(5);
    o_S(10) <= i_A(6);
    o_S(11) <= i_A(7);
  end process;
end arch_1;