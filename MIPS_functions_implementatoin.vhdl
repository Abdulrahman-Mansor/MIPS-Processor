library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package body pkg is
    function ALU(rs, rt: std_logic_vector(7 downto 0); s:std_logic_vector(2 downto 0) ) return alu_result is
        variable result: alu_result;
		variable cf : std_logic;
		begin
          case s is	
			when "000" =>
				result.temp_result(8 downto 0) := std_logic_vector(('0' & unsigned(rs)) + ('0' & unsigned(rt)));
				result.CF := result.temp_result(8);
			when "001" =>
				result.temp_result(8 downto 0) := std_logic_vector(('0' & unsigned(rs)) - ('0' & unsigned(rt)));
				result.CF := result.temp_result(8);
			when "010" =>
				result.temp_result := std_logic_vector(unsigned(rs) * unsigned (rt));
			when "011" =>
				result.temp_result(7 downto 0) := std_logic_vector( unsigned( rs) / unsigned(rt));
				result.temp_result(15 downto 8) := x"00";
			when "100" =>
				result.temp_result(7 downto 0) := (rs and rt);
			when "101" =>
				result.temp_result(7 downto 0) :=  (rs or rt);
			when "110" =>
				result.temp_result(7 downto 0) :=   (rs xor rt);
			when "111" =>
				result.temp_result(7 downto 0) :=  (not rs);
			when others =>
				
		end case;
		if result.temp_result = x"0000" then
			result.ZF := '1';
		else
			result.ZF := '0';
		end if;
		return result;
    end function ALU;
    

end package body pkg;
