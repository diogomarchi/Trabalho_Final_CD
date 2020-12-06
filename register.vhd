------------------------------------------------
-- Design: register
-- Entity: register
-- Author: Diogo & George
-- Rev.  : 1.0
-- Date  : 06/19/2020
------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY register_16bit IS
  PORT (
    i_CLK : IN std_logic;
    i_CLR_N : IN std_logic;
    i_ENA : IN std_logic; -- enable
    i_A : IN std_logic_Vector(15 DOWNTO 0); -- data input       
    o_Q : OUT std_logic_Vector(15 DOWNTO 0)); -- data output
END register_16bit;
ARCHITECTURE arch1 OF register_16bit IS

  SIGNAL r_STATE : std_logic_vector(15 DOWNTO 0);

BEGIN

  PROCESS (i_CLR_N, i_CLK)
  BEGIN
    IF (i_CLR_N = '0') THEN
      r_STATE <= "1111111111111111";
    ELSIF (rising_edge(i_CLK)) THEN
      IF (i_ENA = '1') THEN
        r_STATE <= i_A;
      END IF;
    END IF;
  END PROCESS;

  o_Q <= r_STATE;

END arch1;