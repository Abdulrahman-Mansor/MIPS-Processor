library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.pkg.all;

entity mips_microprocessor is
	port(
		clk,reset : in std_logic;
		program_counter : out std_logic_vector(7 downto 0);
		destnation_register : out std_logic_vector( 7 downto 0) := x"00"
	);
end entity;
architecture mips_behav of mips_microprocessor is
	type Registers is array (0 to 7) of std_logic_vector(7 downto 0);
	type Instructions_rom is array (0 to 15) of std_logic_vector(15 downto 0);
	signal R : Registers := (others => (others => '0'));
	
	constant MyRom : Instructions_rom :=(
		x"7003",--0
		x"720A",--1
		x"7400",
		x"7E00",
		x"1290",
		x"3001",
		x"B1C4",
		x"145B",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000",
		x"0000"
	);
	signal rd: std_logic_vector(7 downto 0) := x"00";
	signal alu_func: std_logic_vector (2 downto 0) := "000";
	signal instruction_register : std_logic_vector(15 downto 0) := x"0000";
	signal memory_rw, CF, ZF : std_logic := '0';
	
	
	begin
		process(clk)
		variable alu_res : alu_result;
		variable temp_result : std_logic_vector(15 downto 0);
		variable opcode : std_logic_vector(3 downto 0);
		variable instruction_register_v : std_logic_vector(15 downto 0);
		variable  alu_func_v,rs_num, rt_num, rd_num : std_logic_vector (2 downto 0) := "000";
		variable addr12 : std_logic_vector(11  downto 0);
		variable rs,rt,pc_current,pc_next: std_logic_vector(7 downto 0) := x"00";
		variable immediate6,addr6 : std_logic_vector(5 downto 0);
		variable immediate9,addr9 : std_logic_vector(8 downto 0);
		begin
			if reset = '1' then
				pc_current := x"00";
				pc_next := x"00";
			elsif (rising_edge(clk)) then
					--fetch
					pc_current := pc_next;
					instruction_register_v := MyRom(to_integer(unsigned(pc_current(3 downto 0))));
					
					--decode
					rs_num := instruction_register_v(11 downto 9);
					rt_num := instruction_register_v(8 downto 6);
					rd_num := instruction_register_v(5 downto 3);
					alu_func_v := instruction_register_v( 2 downto 0);
					immediate6 := instruction_register_v(5 downto 0);
					immediate9 := instruction_register_v(8 downto 0);
					addr9 := instruction_register_v(8 downto 0);
					addr6:= instruction_register_v(5 downto 0);
					addr12 := instruction_register_v(11 downto 0);
					opcode := instruction_register_v(15 downto 12);
					
					rs := R(to_integer(unsigned(rs_num)));
					rt := R(to_integer(unsigned(rt_num)));

					alu_func <= alu_func_v;
					instruction_register <= instruction_register_v;
				pc_next := std_logic_vector(unsigned(pc_next) + 1 );
				alu_res.CF := '0';
				alu_res.ZF := '0';
				case opcode is
					when x"1" =>	
						alu_res := ALU(rs, rt, alu_func_v);
						temp_result := alu_res.temp_result;
						ZF <= alu_res.ZF;
						CF <= alu_res.CF;
						destnation_register <= temp_result(7 downto 0);
						R(to_integer(unsigned(rd_num))) <= temp_result(7 downto 0);
						-- pc_current <= std_logic_vector(unsigned(pc_current) + 1);
					when x"2" =>
						temp_result (7 downto 0) := std_logic_vector(signed(rs) + signed(immediate6));
						rt := temp_result (7 downto 0);
						destnation_register <= temp_result (7 downto 0);
						R(to_integer(unsigned(rt_num))) <= temp_result (7 downto 0);
						
					when x"3" =>
						temp_result (7 downto 0) := std_logic_vector(signed(rs) - signed(immediate6));
						rt := temp_result (7 downto 0);
						destnation_register <= temp_result (7 downto 0);
						R(to_integer(unsigned(rt_num))) <= temp_result (7 downto 0);
						-- ZF <= '1' when (temp_result(7 downto 0) = x"00") else
							-- '0';
					when x"4" =>
						temp_result(7 downto 0) := rs and ("00" & immediate6);
						destnation_register <= temp_result(7 downto 0);
						R(to_integer(unsigned(rt_num))) <= temp_result(7 downto 0);
					when x"5" =>
						temp_result(7 downto 0) := rs or ("00" & immediate6);
						destnation_register <= temp_result(7 downto 0);
						R(to_integer(unsigned(rt_num))) <= temp_result(7 downto 0);
						-- ZF <= '1' when (temp_result(7 downto 0) = x"00") else
							-- '0';
					when x"6" =>
						temp_result(7 downto 0) := rs xor ("00" & immediate6);
						destnation_register <= temp_result(7 downto 0);
						R(to_integer(unsigned(rt_num))) <= temp_result(7 downto 0);
						-- ZF <= '1' when (temp_result(7 downto 0) = x"00") else
							-- '0';
					when x"7" =>
						temp_result(7 downto 0) := immediate9(7 downto 0);
						destnation_register <= temp_result(7 downto 0);
						R(to_integer(unsigned(rs_num))) <= temp_result(7 downto 0);
						-- ZF <= '1' when (temp_result(7 downto 0) = x"00") else
							-- '0';
					when x"8" =>
						memory_rw <= '0';
					when x"9" =>
						memory_rw <= '1';
					when x"A" =>
						if rs = rt then
							pc_current(5 downto 0) := addr6;
						end if;
					when x"B" =>
						if rs > rt then
							pc_current(5 downto 0) := addr6;
						end if;
					when x"C" =>
						if rs < rt then
							pc_current(5 downto 0) := addr6;
						end if;
					when x"D" =>
						if CF = '1' then
							pc_current := addr12(7 downto 0);
						end if;
					when x"E" =>
						if ZF = '1' then
							pc_current := addr12(7 downto 0);
						end if;
					when x"F" =>
						pc_current := addr12(7 downto 0);
					when others =>
						destnation_register <= x"00";
						zf <= '1';
				end case;
				if temp_result(7 downto 0) = x"00" then 
							ZF <= '1';
						end if;
			end if;

			program_counter <= pc_current;
		end process;
		
end architecture;

-- fetch
-- +1 
-- dispaly
--pc + 1

-- fetch 
-- dispaly
-- +1
-- pc