------------------------------------------------
-- Design: AXI4
-- Entity: 
-- Author: Andriy, Diogo, George & Matheus
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;
entity AXI4 is
  port (
    i_CLR_n  : in std_logic; -- clear/reset
    i_CLK    : in std_logic; -- clock
    i_VALID  : in std_logic; -- enable
    i_READY  : in std_logic; -- enable 
    i_BUFFER : in std_logic_vector(7 downto 0); -- data input
    o_TVALID : out std_logic; -- enable
    o_TDATA  : out std_logic_vector(7 downto 0)); -- data output
end AXI4;

architecture arch_1 of AXI4 is
  type t_STATE is (s_0, s_1, s_2, s_3);
  signal r_STATE                        : t_STATE; -- state register
  signal w_NEXT                         : t_STATE; -- next state
  signal r_BUFFER, r_BUFFER1 : std_logic_vector(7 downto 0); -- sincronismo

 
begin
  p_STATE : process (i_CLR_n, i_CLK)
  begin
    if (i_CLR_n = '0') then
      r_STATE   <= s_0; --initial state
      r_BUFFER  <= "00000000";
      r_BUFFER1 <= "00000000";
    elsif (rising_edge(i_CLK)) then 
      r_STATE   <= w_NEXT; --next state
      r_BUFFER  <= i_BUFFER;
      r_BUFFER1 <= r_BUFFER;      
    end if;
  end process;

  p_NEXT : process (r_STATE, i_VALID, i_READY)
  begin
    case (r_STATE) is
      when s_0 => if (i_VALID = '1') then
				    w_NEXT <= s_1;
				  else
					w_NEXT <= s_0;
				  end if;
 
      when s_1 => if (i_READY = '1') then
				    w_NEXT <= s_2;
				  else
					w_NEXT <= s_1;
				  end if;
				  
      when s_2 => if (i_VALID = '0') then
				    w_NEXT <= s_3;
				  else
                    w_NEXT <= s_1;
                  end if;
 
	  when s_3 => w_NEXT <= s_0;
 
      when others => w_NEXT <= s_0;
    end case;
  end process;
  
  o_TVALID <= '0' when (r_STATE = s_0) else '1';
  o_TDATA  <= r_BUFFER1 when(r_STATE = s_2 or r_STATE = s_3) else "00000000";
end arch_1;