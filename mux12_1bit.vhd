------------------------------------------------
-- Design: Mux12_1bit
-- Entity: 
-- Author: Andriy, Diogo, George & Matheus
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity mux12_1bit is
port ( i_SEL : in  std_logic_vector (3 downto 0);  -- selector
       i_A   : in  std_logic_vector (11 downto 0); -- input
       o_S   : out std_logic); -- data output
end mux12_1bit;


architecture arch_1 of mux12_1bit is
begin
  process(i_SEL, i_A) 
  begin
    if (i_SEL="0000") then
      o_S <= i_A(0);
    elsif (i_SEL="0001") then
      o_S <= i_A(1);
    elsif (i_SEL="0010") then
      o_S <= i_A(2);
    elsif (i_SEL="0011") then
      o_S <= i_A(3);
    elsif (i_SEL="0100") then
      o_S <= i_A(4);
    elsif (i_SEL="0101") then
      o_S <= i_A(5);
    elsif (i_SEL="0110") then
      o_S <= i_A(6);
    elsif (i_SEL="0111") then
      o_S <= i_A(7);
    elsif (i_SEL="1000") then
      o_S <= i_A(8);
    elsif (i_SEL="1001") then
      o_S <= i_A(9);
    elsif (i_SEL="1010") then
      o_S <= i_A(10);
    else
      o_S <= i_A(11);
    end if;
  end process;
end arch_1;