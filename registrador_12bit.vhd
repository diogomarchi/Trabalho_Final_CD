library ieee;
use ieee.std_logic_1164.all;

entity registrador_12bit is
port ( i_load      : in  std_logic;  -- selector
       i_clk    : in  std_logic; -- data output
       i_I        : in  std_logic_vector (11 downto 0);
       o_Q        : out std_logic_vector (11 downto 0));
end registrador_12bit;


architecture arch_1 of registrador_12bit is
<<<<<<< HEAD

signal r_Q: std_logic_vector (11 downto 0);

=======
signal r_DATA : std_logic_vector (11 downto 0);
>>>>>>> d11c62b78a881de9fb655a0c25c6e90cbd89ff89
begin
  process(i_load, i_clk, i_I)
  begin
    if (rising_edge(i_CLK)) then
      if (i_load='1') then
<<<<<<< HEAD
          r_Q <= i_I;
      else
          r_Q <= r_Q;
      end if;
    end if;
  end process;

  o_Q <= r_Q;
=======
      	r_DATA <= i_I;
      end if;
    end if;
  end process;
  o_Q <= r_DATA;
>>>>>>> d11c62b78a881de9fb655a0c25c6e90cbd89ff89
end arch_1;