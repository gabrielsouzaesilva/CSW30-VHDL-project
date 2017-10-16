library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoReg is
	port( clk		: in std_logic; -- clock
		  rst 		: in std_logic; -- reset
		  write_en	: in std_logic;	-- write enable
		  write_data: in unsigned(15 downto 0); -- valor a ser escrito em write_reg
		  reg_sel_write : in unsigned(2 downto 0); -- registrador a ser escrito
		  reg_sel_A: in unsigned(2 downto 0); -- entrada de dados
		  reg_sel_B: in unsigned(2 downto 0); -- entrada de dados
		  data_out_A: out unsigned(15 downto 0); -- saida de dados
		  data_out_B: out unsigned(15 downto 0) -- saida de dados
		);
end entity;

architecture a_bancoReg of bancoReg is
	component reg16bits is
		port( 	regClk:			in std_logic;
				regRst: 		in std_logic;
				regWrite_en:	in std_logic;
				regData_in: 	in unsigned(15 downto 0);
				regData_out: 	out unsigned(15 downto 0)
			);
	end component;
	signal data_out_0, data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7: unsigned(15 downto 0);
	signal write_en_0, write_en_1, write_en_2, write_en_3, write_en_4, write_en_5, write_en_6, write_en_7: std_logic;
begin


	reg0: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_0, regData_in => write_data, regData_out => data_out_0);
	reg1: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_1, regData_in => write_data, regData_out => data_out_1);
	reg2: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_2, regData_in => write_data, regData_out => data_out_2);
	reg3: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_3, regData_in => write_data, regData_out => data_out_3);
	reg4: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_4, regData_in => write_data, regData_out => data_out_4);
	reg5: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_5, regData_in => write_data, regData_out => data_out_5);
	reg6: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_6, regData_in => write_data, regData_out => data_out_6);
	reg7: reg16bits port map(regClk => clk, regRst => rst, regWrite_en => write_en_7, regData_in => write_data, regData_out => data_out_7);

	write_en_0 <= '0';  -- Registrador 0 não pode escrever
	write_en_1 <= write_en when reg_sel_write = "001" else
			  '0';	              
	write_en_2 <= write_en when reg_sel_write = "010" else
			  '0';	              
	write_en_3 <= write_en when reg_sel_write = "011" else
			  '0';	              
	write_en_4 <= write_en when reg_sel_write = "100" else
			  '0';	              
	write_en_5 <= write_en when reg_sel_write = "101" else
			  '0';	              
	write_en_6 <= write_en when reg_sel_write = "110" else
			  '0';	              
	write_en_7 <= write_en when reg_sel_write = "111" else
			  '0';

	data_out_A <= "0000000000000000" when reg_sel_A = "000" else
				 data_out_1 when reg_sel_A = "001" else
				 data_out_2 when reg_sel_A = "010" else
				 data_out_3 when reg_sel_A = "011" else
				 data_out_4 when reg_sel_A = "100" else
				 data_out_5 when reg_sel_A = "101" else
				 data_out_6 when reg_sel_A = "110" else
				 data_out_7 when reg_sel_A = "111" else
				 "0000000000000000";

	data_out_B <= "0000000000000000" when reg_sel_B = "000" else
				 data_out_1 when reg_sel_B = "001" else
				 data_out_2 when reg_sel_B = "010" else
				 data_out_3 when reg_sel_B = "011" else
				 data_out_4 when reg_sel_B = "100" else
				 data_out_5 when reg_sel_B = "101" else
				 data_out_6 when reg_sel_B = "110" else
				 data_out_7 when reg_sel_B = "111" else
				 "0000000000000000";	


end architecture;