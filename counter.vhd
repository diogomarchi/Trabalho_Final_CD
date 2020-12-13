------------------------------------------------
-- Design: Counter
-- Entity: 
-- Author: Andriy, Diogo, George & Matheus
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port ( i_CLR	: in  std_logic; -- selector
       i_CLK    : in  std_logic; -- data input
       i_UP		: in  std_logic; -- data input
       o_S		: out std_logic_vector (3 downto 0));
end counter;


architecture arch_1 of counter is

signal r_DATA : std_logic_vector (3 downto 0);
begin
  process(i_CLR, i_CLK, i_UP)
  begin
  	if (i_CLR='1') then
	  r_DATA <= (others =>'0');
    elsif (rising_edge(i_CLK)) then
      if (i_UP='1') then
        r_DATA <= std_logic_vector(unsigned(r_DATA) + 1);
      end if;
    end if;
  end process;
  o_S <= r_DATA;
end arch_1;