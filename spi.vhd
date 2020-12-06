library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi is
port ( i_CLR_n   : in  std_logic;   -- selector
       i_CLK  	  : in  std_logic;   -- data input
       i_TVALID  : in  std_logic;    -- data input
       i_TDATA   : in  std_logic_vector (7 downto 0);
       o_TREADY  : out std_logic;   -- data output
       o_MOSI    : out std_logic;   -- data output
		 o_SCK     : out std_logic;   -- data output
       o_SS_n    : out std_logic);  -- data output
end spi;

architecture arch_1 of spi is

component spi_control is
port ( i_CLR_n 	  : in  std_logic;   -- selector
       i_CLK  	  : in  std_logic;   -- data input
       i_TVALID   : in  std_logic;    -- data input
       i_CNTR	  : in  std_logic_vector (3 downto 0);
		 o_SCK     : out std_logic;   -- data output
       o_CNTRCLR  : out std_logic;
       o_CNTRUP   : out std_logic;
       o_HLOAD    : out std_logic;   -- load hamming register
       o_TREADY   : out std_logic;   -- data output
       o_SS_n     : out std_logic);  -- data output
end component;

component hamming is
port ( i_A :        in std_logic_vector (0 to 7);  -- selector
       o_S  :       out std_logic_vector (0 to 11)); -- data output
end component;

component registrador_12bit is
port ( i_load  	: in  std_logic;  -- selector
       i_clk    : in  std_logic; -- data output
       i_I		: in  std_logic_vector (11 downto 0);
       o_Q		: out std_logic_vector (11 downto 0));
end component;

component mux12_1bit is
port ( i_SEL : in  std_logic_vector (3 downto 0);  -- selector
       i_A   : in  std_logic_vector (11 downto 0); -- input
       o_S   : out std_logic); -- data output
end component;

component counter is
port ( i_clr  	  : in  std_logic;  -- selector
       i_clk      : in  std_logic; -- data input
       i_up		  : in  std_logic; -- data input
       o_S		  : out std_logic_vector (3 downto 0));
end component;


signal w_HLOAD, w_CNTRUP, w_CNTRCLR : std_logic;
signal w_o_HAMMING, w_REG_EDC : std_logic_vector (11 downto 0);
signal w_SEL : std_logic_vector (3 downto 0);
begin

		u_Control : spi_control port map( i_CLR_n => i_CLR_n,
                                          i_CLK => i_CLK,  
                                          i_TVALID => i_TVALID,
                                          i_CNTR => w_SEL,
														o_SCK  => o_SCK,
                                          o_CNTRCLR  => w_CNTRCLR,
                                          o_CNTRUP => w_CNTRUP,
                                          o_HLOAD => w_HLOAD, 
                                          o_TREADY => o_TREADY,
                                          o_SS_n => o_SS_n);


		u_Hamming : hamming port map(i_A => i_TDATA,
                                     o_S => w_o_HAMMING);
                                     
		u_Reg : registrador_12bit port map(i_load => w_HLOAD,
                                           i_clk  => i_CLK,
                                           i_I    => w_o_HAMMING,
                                           o_Q    => w_REG_EDC);
                                               
		u_Mux : mux12_1bit port map(i_SEL => w_SEL,
                                    i_A   => w_REG_EDC,
                                    o_S   => o_MOSI);
											  
		u_Counter : counter port map(i_clr => w_CNTRCLR,
                                     i_clk   => i_CLK,
                                     i_up   => w_CNTRUP,
                                     o_S    => w_SEL);

end arch_1;