library ieee;
use ieee.std_logic_1164.all;

package pkg is
	type alu_result is record
		temp_result : std_logic_vector(15 downto 0);
		CF,ZF : std_logic;
	end record;
    function ALU(rs, rt: std_logic_vector(7 downto 0); s:std_logic_vector(2 downto 0) ) return alu_result;

end package pkg;
