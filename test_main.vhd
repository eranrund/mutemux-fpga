--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:32:29 08/27/2015
-- Design Name:   
-- Module Name:   /home/eran/midimux/test_main.vhd
-- Project Name:  midimux
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_main IS
END test_main;
 
ARCHITECTURE behavior OF test_main IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         clk : IN  std_logic;
         midi1_in : IN  std_logic;
         midi1_out : OUT  std_logic;
         midi2_in : IN  std_logic;
         midi2_out : OUT  std_logic;
			midi3_in : IN  std_logic;
         midi3_out : OUT  std_logic;
			midi4_in : IN  std_logic;
         midi4_out : OUT  std_logic;
         spi_cs : IN  std_logic;
         spi_clk : IN  std_logic;
         spi_mosi : IN  std_logic;
         spi_miso : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal midi1_in : std_logic := '0';
   signal midi2_in : std_logic := '0';
   signal midi3_in : std_logic := '0';
   signal midi4_in : std_logic := '0';	
   signal spi_cs : std_logic := '1';
   signal spi_clk : std_logic := '0';
   signal spi_mosi : std_logic := '0';

 	--Outputs
   signal midi1_out : std_logic;
   signal midi2_out : std_logic;
   signal midi3_out : std_logic;
   signal midi4_out : std_logic;

   signal spi_miso : std_logic;

   -- Clock period definitions
   constant clk_period : time := 1 ns;
   constant spi_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          clk => clk,
          midi1_in => midi1_in,
          midi1_out => midi1_out,
          midi2_in => midi2_in,
          midi2_out => midi2_out,
			 midi3_in => midi3_in,
			 midi3_out => midi3_out,
			 midi4_in => midi4_in,
			 midi4_out => midi4_out,
          spi_cs => spi_cs,
          spi_clk => spi_clk,
          spi_mosi => spi_mosi,
          spi_miso => spi_miso
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	midi1_generator : process begin
		midi1_in <= '1';
		wait for 15 ns;
		midi1_in <= '0';
		wait for 15 ns;
	end process;
	
	midi2_generator : process begin
		midi2_in <= '1';
		wait for 7 ns;
		midi2_in <= '0';
		wait for 3 ns;
	end process;
	
	midi3_generator : process begin
		midi3_in <= '1';
		wait for 2 ns;
		midi3_in <= '0';
		wait for 20 ns;
	end process;
	
	
	midi4_generator : process begin
		midi4_in <= '1';
		wait for 2 ns;
		midi4_in <= '0';
		wait for 20 ns;
	end process;
 
--   spi_clk_process :process
--   begin
--		spi_clk <= '0';
--		wait for spi_clk_period/2;
--		spi_clk <= '1';
--		wait for spi_clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process

              procedure write_spi(w_data : in std_logic_vector(15 downto 0)) is
              begin
                      spi_cs <= '0';

                      for i in 0 to 15 loop
                              spi_mosi <= w_data(15-i);
                              wait for spi_clk_period/2;

                              spi_clk <= '1';
                              wait for spi_clk_period/2;

                              spi_clk <= '0';
                      end loop;

                      wait for spi_clk_period/2;

                      spi_cs <= '1';

              end write_spi;

   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      write_spi(x"8101"); -- 81 = 1000 0001 = write mux1 sel
		wait for 50 ns;
		
		write_spi(x"8102"); -- write mux1 sel with "2"
		wait for 50ns;
		
		write_spi(x"8202");
		wait for 50ns;
		write_spi(x"8203");
      wait;
   end process;

END;
