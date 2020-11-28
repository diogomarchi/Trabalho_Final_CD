------------------------------------------------
-- Design: IP
-- Entity: 
-- Author: Diogo & George
-- Rev.  : 1.0
-- Date  : 11/23/2020
------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.STD_LOGIC_UNSIGNED.all;


entity anxi4 is
port ( i_CLR_n  : in  std_logic;  -- clear/reset
       i_CLK    : in  std_logic;  -- clock
		 i_VALID  : in  std_logic;  -- enable
       i_READY  : in  std_logic;  -- enable    
       i_BUFFER : in  std_logic_vector(7 downto 0);  -- data input
		 o_CLK    : out std_logic;  -- clock 
		 o_TVALID : out std_logic;  -- enable
       o_TLAST  : out std_logic;  -- de last bit
		 o_TDATA  : out std_logic_vector(7 downto 0)); -- data output
end anxi4;


architecture arch_1 of anxi4 is

  type t_STATE is (s_0, s_1, s_2, s_3);
  signal r_STATE: t_STATE;		 -- state register
  signal w_NEXT : t_STATE; 		 -- next state

  
begin

  p_STATE: process( i_CLR_n, i_CLK)
  begin
    if (i_CLR_n ='0') then
      r_STATE <= s_0;			 --initial state
	  elsif (rising_edge(i_CLK)) then
       r_STATE <= w_NEXT;		 --next state
    end if;
  end process;
 
  p_NEXT: process(r_STATE, i_VALID, i_READY)
  begin
    case (r_STATE) is
      when s_0 => o_TLAST  <= '0';
		            o_TVALID <= '0';
		            if(i_VALID = '1') then
						  o_TVALID <= '1';
    			        w_NEXT <= s_1;
                  else
                    w_NEXT <= s_0;
                  end if; 
      when s_1 => if(i_READY = '1') then
    			        w_NEXT   <= s_2;
                  else
                    w_NEXT   <= s_1;
                  end if;
						
      when s_2 => o_TDATA  <= i_BUFFER;
		            if(i_VALID = '0') then
    			        w_NEXT <= s_3;
                  else
						  o_TVALID <= '1';
                    w_NEXT <= s_1;
                  end if;
      when s_3 => o_TDATA  <= i_BUFFER;
		            o_TLAST  <= '1';
						o_TVALID <= '1';
                  w_NEXT   <= s_0;
     
    when others => w_NEXT <= s_0;
  end case;
end process;

end arch_1;