library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit_tb is
end entity;

architecture reg1bit_tb of reg1bit_tb is
	component reg1bit
		port(	regClk		: in std_logic; -- Clock
		 		regRst 		: in std_logic; -- Reset
		 		regWrite_en	: in std_logic; -- Permite escrever no registrador
		  		regData_in	: in std_logic; -- Entrada de dados
			 	regData_out	: out std_logic -- Saida de dados 
			);
	end component;

	signal registro,regData_in,regData_out: std_logic;
	signal regClk,regRst,regWrite_en: std_logic;


begin
		uut: reg1bit port map (regClk => regClk,
							 regRst => regRst,
							 regWrite_en => regWrite_en,
							 regData_in => regData_in,
							 regData_out => regData_out
							 );

	process -- Clock 50ns 
	begin
		regClk <= '0';
		wait for 50 ns;
		regClk <= '1';
		wait for 50 ns;
	end process;

	process -- Sinal Reset
	begin
		regRst <= '1';
		wait for 100 ns;
		regRst <= '0';
		wait;
	end process;

	process -- Sinais casos de teste
	begin
		regWrite_en <= '0';
		regData_in <= '1';
		wait for 100 ns;
		regWrite_en <= '1';
		regData_in <= '1';
		wait for 100 ns;
		wait;
	end process;


end architecture;