library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoReg_tb is
end entity;

architecture a_bancoReg_tb of bancoReg_tb is
	component bancoReg
		port(	clk		: in std_logic; -- clock
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

	signal clk, rst, write_en: std_logic;
	signal reg_sel_write, reg_sel_A, reg_sel_B: unsigned(2 downto 0);
	signal write_data, data_out_A, data_out_B: unsigned(15 downto 0);

begin
	uut: bancoReg port map (clk => clk,
							rst => rst,
							write_en => write_en,
							write_data => write_data,
							reg_sel_write => reg_sel_write,
							reg_sel_A => reg_sel_A,
							reg_sel_B => reg_sel_B,
							data_out_A => data_out_A,
							data_out_B => data_out_B
							);
	process
		begin
			clk <= '0';
			wait for 50 ns;
			clk <= '1';
			wait for 50 ns;
		end process;

	process -- sinal de reset
		begin
			rst <= '0';
			wait for 10 ns;
			rst <= '1';
			wait for 10 ns;
			rst <= '0';
			wait for 500 ns;
			rst <= '1';
			wait for 10 ns;
			rst <= '0';
			wait;
		end process;
		
		process -- sinais dos casos de teste
		begin
			-- nada
			write_en <= '0';
			reg_sel_write <= "000";
			reg_sel_A <= "000";
			reg_sel_B <= "000";
			write_data <= "0000000000000000";
			wait for 100 ns;
			-- escreve 0101010101010101 no reg1
			write_en <= '1';
			reg_sel_write <= "001";
			reg_sel_A <= "001";
			reg_sel_B <= "010";
			write_data <= "0000000000000001";
			wait for 100 ns;
			-- escreve 1010101010101010 no reg2
			write_en <= '1';
			reg_sel_write <= "010";
			reg_sel_A <= "001";
			reg_sel_B <= "010";
			write_data <= "1000001000001000";
			wait for 100 ns;
			-- mostra o mesmo registrador (reg1) na saida A e B
			write_en <= '0';
			reg_sel_write <= "000";
			reg_sel_A <= "001";
			reg_sel_B <= "001";
			write_data <= "1000001000001000";
			wait for 100 ns;
			-- tenta escrever 1111111111111111 no reg0 (constante 0)
			write_en <= '1';
			reg_sel_write <= "000";
			reg_sel_A <= "000";
			reg_sel_B <= "000";
			write_data <= "1111111111111111";
			wait for 100 ns;
			-- ocorre rst enquanto lê reg0 e reg1
			write_en <= '0';
			reg_sel_write <= "000";
			reg_sel_A <= "000";
			reg_sel_B <= "001";
			write_data <= "0000000000000000";
			wait for 100 ns;
			-- mostra o mesmo registrador (reg1) na saida A e B (depois do rst deve ser "0000000000000000")
			write_en <= '0';
			reg_sel_write <= "000";
			reg_sel_A <= "001";
			reg_sel_B <= "001";
			write_data <= "0000000000000000";
			wait;
		end process;
end architecture;
