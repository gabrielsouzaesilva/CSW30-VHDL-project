library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador is
	port ( processadorClk : in std_logic; -- clk geral
		   rstProcessador : in std_logic; -- reseta o banco de registradores
		   -- memToReg : in std_logic; não preicsa ainda 
		   -- ALUsrcA : in std_logic;  não precisa ainda
		   ULAout : out unsigned (15 downto 0);
		   constante: in unsigned(15 downto 0) -- constante qualquer 
		 );
end entity;

architecture a_processador of processador is
	component bancoReg is
		port( 	clk		: in std_logic; -- clock
		  		rst 		: in std_logic; -- reset
		  		write_en	: in std_logic;	-- write enable
		  		write_data: in unsigned(15 downto 0); -- valor a ser escrito em write_reg
		  		reg_sel_write : in unsigned(2 downto 0); -- registrador a ser escrito
		  		reg_sel_A: in unsigned(2 downto 0); -- entrada de dados
		  		reg_sel_B: in unsigned(2 downto 0); -- entrada de dados
		  		data_out_A: out unsigned(15 downto 0); -- saida de dados
		  		data_out_B: out unsigned(15 downto 0) -- saida de dados
			);
	end component;

	component ula is
		port( 	in_a : in unsigned(15 downto 0); -- entrada a 16 bits unsigned
		  		in_b : in unsigned(15 downto 0); -- entrada b 16 bits unsigned
		  		sel_op : in unsigned(2 downto 0); -- seletor para operação 2 bits : 000 soma, 001 subtracao, 010 compara, 011 div, 100 xor, 101 nor
		  		out_a : out unsigned(15	 downto 0) -- saida 16 bits unsigned
		 	);
	end component;

	component pc is
		port (	clk : in std_logic;
				write_en : in unsigned(1 downto 0);
				rst : in std_logic;
				data_in : in unsigned(15 downto 0);
				data_out : out unsigned(15 downto 0)
		);
	end component;

	component rom is
		port( 	clk : in std_logic;
			  	address : in unsigned(15 downto 0);
			  	data : out unsigned(15 downto 0)
			);
	end component;

	component maquinaEstados is
		port (	clk : in std_logic;
				rst : in std_logic;
				estado : out unsigned(1 downto 0)
			);
	end component;

	signal data_regB, data_regA, signal_write_data, ula_in_b, data_in_pc, data_out_pc, data_rom_out, address_rom : unsigned(15 downto 0);
	signal jump_address: unsigned(11 downto 0);
	signal immediate: unsigned(5 downto 0);
	signal opcode: unsigned(3 downto 0);
	signal ALUOp_s, regWrite_s, regA_s, regB_s: unsigned(2 downto 0);
	signal estado_s,AluSrcB_s: unsigned(1 downto 0);
	signal jump_en, writeReg_s: std_logic;

begin

	registers: bancoReg port map (	clk => processadorClk,
								 	rst => rstProcessador,
								    write_en => writeReg_s, 
								    write_data => signal_write_data, 
								    reg_sel_write => regWrite_s,
								    reg_sel_A => regA_s,  
								    reg_sel_B => regB_s,
								    data_out_A => data_regA, -- saida banco reg => in_a ula
								    data_out_B => data_regB -- Vai para mux seleção entrada ULA_B
								    );

	alu: ula port map ( in_a => data_regA , in_b => ula_in_b , sel_op => ALUOp_s, out_a => signal_write_data);

	pc_p: pc port map(clk => processadorClk, write_en => estado_s, rst => rstProcessador, data_in => data_in_pc, data_out => data_out_pc);
	rom_p: rom port map(clk => processadorClk, address => data_out_pc, data => data_rom_out);

	stateMachine: maquinaEstados port map(clk => processadorClk, rst => rstProcessador, estado => estado_s);

	opcode <= data_rom_out(15 downto 12); -- Recebe opcode 

	immediate <= data_rom_out(5 downto 0); -- Prepara constante

	jump_address <= data_rom_out(11 downto 0); -- Prepara endereço de jump

	jump_en <= '1' when opcode = "1111" else -- Verifica função de jump
			   '0';							 

	-- Mux seleciona a entrada B da ULA
	AluSrcB_s <= "00" when opcode = "0001" else
				 "10" when opcode = "1000" else
				 "00" when opcode = "1001" else
				 "00";

	-- Escolhe operação da ULA
	ALUOp_s <= data_rom_out(2 downto 0) when opcode = "0001" else -- Function Formarto R
			   "000" when opcode = "1000" else -- Usar soma quando for addi
			   "000" when opcode = "1001" else -- Usar soma +0 quando for cpy
			   "000";

	-- Verifica qual registrador é lido na entrada A
	regA_s  <= data_rom_out(11 downto 9) when opcode = "0001" else -- formato R
			   data_rom_out(11 downto 9) when opcode = "1000" else -- addi regA<=$rs
			   data_rom_out(11 downto 9) when opcode = "1001" else -- cpy  $rt <= $rs + 0
			   "000";

	-- Verifica qual registrador é lido na entrada B
	regB_s <= data_rom_out(8 downto 6) when opcode = "0001" else  -- Formato R
			  data_rom_out(11 downto 9) when opcode = "1000" else -- addi regB <= $rs
			  "000" when opcode = "1001" else -- cpy regB <= $rs + 0
			  "000"; 

	-- Verifica qual registrador deve ser escrito
	regWrite_s <= data_rom_out(5 downto 3) when opcode = "0001" else -- Formato R regWrite<= $rd
				  data_rom_out(8 downto 6) when opcode = "1000" else -- Addi regWrite <= $rt
				  data_rom_out(8 downto 6) when opcode = "1001" else -- Cpy regWrite <= $rt
				  "000"; 

	-- Fetch em 00
	address_rom <= data_out_pc when estado_s = "00" else
				   address_rom;

	-- Executa jump ou PC+1
	data_in_pc  <= data_out_pc+1 when estado_s = "01" and jump_en = '0' else -- pc+1
				   "0000" & jump_address when estado_s = "01" and jump_en = '1' else -- jump
				    data_out_pc;

	-- Mux entrada B da ULA
	ula_in_b <= data_regB when AluSrcB_s = "00" else
				"0000000000" & immediate when AluSrcB_s = "10" and immediate(5) = '0' else -- Addi immediate positivo
				"1111111111" & immediate when AluSrcB_s = "10" and immediate(5) = '1' else -- Addi immediate negativo
				constante when AluSrcB_s = "01" else -- constante externa =4
				"0000000000000000";

	-- Escreve no registrador (Execute em 10)
	writeReg_s <= '1' when estado_s = "10" else
				  '0';

	ULAout <= signal_write_data;


end architecture;