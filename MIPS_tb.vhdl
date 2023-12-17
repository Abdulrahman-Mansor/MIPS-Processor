library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MIPS_tb is
end MIPS_tb;

architecture behave of MIPS_tb is
component mips_microprocessor is
	port(
		clk,reset : in std_logic;
		destnation_register : out std_logic_vector( 7 downto 0)
	);
end component;

signal clk,reset : std_logic;
signal destnation_register : std_logic_vector(7 downto 0);
constant clk_period : time := 10 ns;
begin 
	processor : mips_microprocessor port map(clk, reset, destnation_register);
	clk1_porc : process
	begin
		
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
	
	
	-- clk_porc : process
		-- clk <= '0';
		-- wait for 5 ns;
		-- while true loop
			-- clk <= not clk;
			-- wait for 5 ns;
		-- end loop;
	-- end process;
	
end architecture;
		