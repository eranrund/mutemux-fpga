----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:27:18 08/27/2015 
-- Design Name: 
-- Module Name:    main - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Generic (   
        N : positive := 16;                                         -- 32bit serial word length is default
        CPOL : std_logic := '0';                                    -- SPI mode selection (mode 0 default)
        CPHA : std_logic := '1';                                    -- CPOL = clock polarity, CPHA = clock phase.
        PREFETCH : positive := 2;                                   -- prefetch lookahead cycles
        SPI_2X_CLK_DIV : positive := 5                              -- for a 100MHz sclk_i, yields a 10MHz SCK
        );                                  

    Port ( clk : in  STD_LOGIC;
	        midi1_in : in  STD_LOGIC;
           midi1_out : out  STD_LOGIC;
           midi2_in : in  STD_LOGIC;
           midi2_out : out  STD_LOGIC;
           spi_cs : in  STD_LOGIC;
           spi_clk : in  STD_LOGIC;
           spi_mosi : in  STD_LOGIC;
           spi_miso : out  STD_LOGIC);
end main;

architecture Behavioral of main is

    signal rst : std_logic := 'U';


    -- slave parallel interface
    signal di_s : std_logic_vector (N-1 downto 0) := (others => '0'); --
    signal do_s : std_logic_vector (N-1 downto 0); -- do_s
    signal do_valid_s : std_logic; -- do_valid_s
    signal do_transfer_s : std_logic;
    signal di_req_s : std_logic; --
    signal wren_s : std_logic := '0'; --
    signal wren_o_s : std_logic := 'U';
    signal wren_ack_o_s : std_logic := 'U';
    signal rx_bit_reg_s : std_logic;
    signal state_s : std_logic_vector (5 downto 0);

	 -- muxes
	 signal mux1_cfg : std_logic_vector (3 downto 0);
 	signal mux2_cfg : std_logic_vector (3 downto 0);

begin

--=============================================================================================
    -- Component instantiation for the SPI slave port
    --=============================================================================================
    Inst_spi_slave: entity work.spi_slave(rtl)
        generic map (N => N, CPOL => CPOL, CPHA => CPHA, PREFETCH => PREFETCH)
        port map(
            clk_i => clk,
            spi_ssel_i => spi_cs,
            spi_sck_i => spi_clk,
            spi_mosi_i => spi_mosi,
            spi_miso_o => spi_miso,
            di_req_o => di_req_s,
            di_i => di_s,
            wren_i => wren_s,
            do_valid_o => do_valid_s,
            do_o => do_s--,
            ----- debug -----
--            do_transfer_o => s_do_transfer_o,
--            wren_o => s_wren_o,
--            wren_ack_o => s_wren_ack_o,
--            rx_bit_reg_o => s_rx_bit_reg_o,
--            state_dbg_o => s_state_dbg_o
--            sh_reg_dbg_o => s_sh_reg_dbg_o
        );
		  
		 Inst_mux1: entity work.mux
		 port map(
			clk_i => clk,
			I1 => midi1_in,
			I2 => midi2_in,
			I3 => midi1_in,
			I4 => midi1_in,
			O => midi1_out,
			S => mux1_cfg
		);
		
		Inst_mux2: entity work.mux
		 port map(
			clk_i => clk,
			I1 => midi1_in,
			I2 => midi2_in,
			I3 => midi1_in,
			I4 => midi1_in,
			O => midi2_out,
			S => mux2_cfg
		);
		
		spi_process : process (clk, do_valid_s, do_s)
			variable spi_cmd : std_logic_vector(7 downto 0);
		begin
		  --if clk'event and clk = '1' then
		      if do_valid_s'event and do_valid_s = '1' then
					spi_cmd := do_s(15 downto 8);
					
					case spi_cmd is
						when x"81" =>
							mux1_cfg <= do_s(3 downto 0);
						when x"82" =>
							mux2_cfg <= do_s(3 downto 0);
						when others =>
							
					end case;
				end if;
		 -- end if;
		end process;


end Behavioral;

