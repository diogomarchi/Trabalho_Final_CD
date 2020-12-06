library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
port ( i_clr  	  : in  std_logic;  -- selector
       i_clk      : in  std_logic; -- data input
       i_up		  : in  std_logic; -- data input
       o_CNTRLAST : out std_logic;
       o_S		  : out std_logic_vector (3 downto 0));
end counter;


architecture arch_1 of counter is

signal value : std_logic_vector (3 downto 0);
begin
  process(i_clr, i_clk, i_up)
  begin
  	if (i_clr='1') then
    	value <= (others =>'0');
    elsif (rising_edge(i_clk)) then
      if (i_up='1') then
      	value <= std_logic_vector(unsigned(value) + 1);
      end if;
      if (value ="1011") then
      	o_CNTRLAST <= '1';
      else
      	o_CNTRLAST <= '0';
      end if;
    end if;
  end process;
  o_S <= value;
end arch_1;