--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:31:24 08/27/2015
-- Design Name:   
-- Module Name:   /home/eran/midimux/test.vhd
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
 
ENTITY test IS
END test;
 
ARCHITECTURE behavior OF test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         midi1_in : IN  std_logic;
         midi1_out : OUT  std_logic;
         midi2_in : IN  std_logic;
         midi2_out : OUT  std_logic;
         spi_cs : IN  std_logic;
         spi_clk : IN  std_logic;
         spi_mosi : IN  std_logic;
         spi_miso : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal midi1_in : std_logic := '0';
   signal midi2_in : std_logic := '0';
   signal spi_cs : std_logic := '0';
   signal spi_clk : std_logic := '0';
   signal spi_mosi : std_logic := '0';

 	--Outputs
   signal midi1_out : std_logic;
   signal midi2_out : std_logic;
   signal spi_miso : std_logic;

   -- Clock period definitions
   constant spi_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          midi1_in => midi1_in,
          midi1_out => midi1_out,
          midi2_in => midi2_in,
          midi2_out => midi2_out,
          spi_cs => spi_cs,
          spi_clk => spi_clk,
          spi_mosi => spi_mosi,
          spi_miso => spi_miso
        );

   -- Clock process definitions
   spi_clk_process :process
   begin
		spi_clk <= '0';
		wait for spi_clk_period/2;
		spi_clk <= '1';
		wait for spi_clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for spi_clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
