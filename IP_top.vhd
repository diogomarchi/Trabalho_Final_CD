library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IP_top is
port ( i_CLR_n  : in  std_logic;  -- clear/reset
       i_CLK    : in  std_logic;  -- clock
		 i_VALID  : in  std_logic;  -- enable 
       i_BUFFER : in  std_logic_vector(7 downto 0);  -- data input 
       o_MOSI   : out std_logic;   -- data output
		 o_SCK    : out std_logic;   -- data output
       o_SS_n   : out std_logic);  -- data output
end IP_top;


architecture arch_1 of IP_top is

  component AXI4 is
  port ( i_CLR_n  : in  std_logic;  -- clear/reset
         i_CLK    : in  std_logic;  -- clock
		   i_VALID  : in  std_logic;  -- enable
         i_READY  : in  std_logic;  -- enable    
         i_BUFFER : in  std_logic_vector(7 downto 0);  -- data input 
		   o_TVALID : out std_logic;  -- enable        
		   o_TDATA  : out std_logic_vector(7 downto 0)); -- data output
  end component;

  component SPI is
  port ( i_CLR_n 	 : in  std_logic;   -- selector
         i_CLK  	 : in  std_logic;   -- data input
         i_TVALID  : in  std_logic;    -- data input
         i_TDATA   : in  std_logic_vector (7 downto 0);
         o_TREADY  : out std_logic;   -- data output
			o_SCK     : out std_logic;   -- data output
         o_MOSI    : out std_logic;   -- data output
         o_SS_n    : out std_logic);  -- data output
  end component;


signal w_READY, w_TVALID: std_logic;
signal w_BUFFER: std_logic_vector(7 downto 0);

begin

  u_SPI : SPI port map( 
    i_CLR_n  => i_CLR_n,
    i_CLK  	 => i_CLK,
    i_TVALID => w_TVALID,
    i_TDATA  => w_BUFFER,
    o_TREADY => w_READY,
	 o_SCK    => o_SCK,
    o_MOSI   => o_MOSI,
    o_SS_n   => o_SS_n
	);


  u_AXI4 : AXI4 port map(
    i_CLR_n  => i_CLR_n,
	 i_CLK    => i_CLK,
	 i_VALID  => i_VALID,
	 i_READY  => w_READY,
	 i_BUFFER => i_BUFFER,
	 o_TVALID => w_TVALID,
	 o_TDATA  => w_BUFFER
  );

end arch_1;