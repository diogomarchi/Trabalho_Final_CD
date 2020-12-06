library ieee;
use ieee.std_logic_1164.all;

entity spi_control is
port ( i_CLR_n 	  : in  std_logic;   -- selector
       i_CLK  	  : in  std_logic;   -- data input
       i_TVALID   : in  std_logic;    -- data input
       i_CNTR	  : in  std_logic_vector (3 downto 0);
       o_CNTRCLR  : out std_logic;
       o_CNTRUP   : out std_logic;
       o_HLOAD    : out std_logic;   -- load hamming register
       o_TREADY   : out std_logic;   -- data output
       o_SS_n     : out std_logic);  -- data output
end spi_control;


architecture arch_1 of spi_control is
	type   t_STATE is (s_0, s_1, s_2);
    signal r_STATE : t_STATE;
    signal w_NEXT  : t_STATE;
    
begin
	p_STATE: process(i_CLR_n, i_CLK)
    begin
      if (i_CLR_n = '0') then
      	r_STATE <= s_0;				-- initial state
      elsif (rising_edge(i_CLK)) then
      	r_STATE <= w_NEXT;			-- next state
      end if;
	end process;
    
    p_NEXT: process(r_STATE, i_TVALID, i_CNTR)
    begin
      case (r_STATE) is
      	when s_0 => if (i_TVALID = '1') then
        				w_NEXT <= s_1;
      				else
                        w_NEXT <= s_0;
                    end if;
                    
      	when s_1 => w_NEXT <= s_2;

      	when s_2 => if (i_CNTR="1011") then
        				w_NEXT <= s_0;
      				else
                    	w_NEXT <= s_2;
      				end if;

      	when others => w_NEXT <= s_0;
      end case;
	end process;
    
    -- output
    o_CNTRCLR <= '1' when (r_state = s_1) else '0';
    o_CNTRUP <= '1' when (r_STATE = s_2) else '0';
    o_HLOAD <= '1' when (r_STATE = s_1) else '0';
    o_TREADY <= '1' when (r_STATE = s_0) else '0';
    o_SS_n <= '1' when (r_STATE = s_0) or (r_STATE = s_1) else '0';
    
end arch_1;