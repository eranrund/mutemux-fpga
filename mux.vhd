----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:17:42 08/27/2015 
-- Design Name: 
-- Module Name:    mux - Behavioral 
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

entity mux is

 Port (
   clk_i : in std_logic := 'X';
	S : in  STD_LOGIC_VECTOR (3 downto 0);
   I1 : in  STD_LOGIC;
   I2 : in  STD_LOGIC;
   I3 : in  STD_LOGIC;
   I4 : in  STD_LOGIC;
   O  : out STD_LOGIC
);
end mux;

architecture Behavioral of mux is

begin
	mux_process : process( clk_i, S, I1, I2, I3, I4) 
	begin
    if clk_i'event and clk_i = '1' then
		case S is
			when x"0" => O <= 'Z';
			when x"1" => O <= I1;
			when x"2" => O <= I2;
			when x"3" => O <= I3;
			when x"4" => O <= I4;
			when others => O <= 'Z';
		end case;
       --O<= 'Z' when "0000",
         -- I1 when "0001",
       --   I2 when "0010",
       --   I3 when "0011",
        --  I4 when "0100",
  --        I5 when "0101",
  --        I6 when "0110",
  --        I7 when "0111",
  --        I8 when "1000",
  --        I9 when "1001",
  --        I10 when "1010",
  --        I11 when "1011",
  --        I12 when "1100",
  --        I13 when "1101",
  --        I14 when "1110",
  --        I15 when "1111",
         -- 'Z' when others;
		end if;
	end process;

end Behavioral;

