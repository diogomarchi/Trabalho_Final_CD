------------------------------------------------
-- Design: Register
-- Entity: 
-- Author: Andriy, Diogo, George & Matheus
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity register_16bit is
  port (
    i_CLR_N : in std_logic;
    i_CLK 	: in std_logic;
    i_ENA 	: in std_logic; -- enable
    i_A 	: in std_logic_Vector(15 downto 0); -- data input       
    o_Q 	: out std_logic_Vector(15 downto 0)); -- data output
end register_16bit;
architecture arch1 of register_16bit is

  signal r_STATE : std_logic_vector(15 downto 0);

begin
  process (i_CLR_N, i_CLK)
  begin
    if (i_CLR_N = '0') then
      r_STATE <= "1111111111111111";
    elsif (rising_edge(i_CLK)) then
      if (i_ENA = '1') then
        r_STATE <= i_A;
      end if;
    end if;
  end process;

  o_Q <= r_STATE;
end arch1;