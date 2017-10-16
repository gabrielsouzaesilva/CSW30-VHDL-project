library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is
	component processador
		port (	processadorClk : in std_logic; -- clk geral
		  		rstProcessador : in std_logic; -- reseta o banco de registradores
		   		-- memToReg : in std_logic; não preicsa ainda 
		   		-- ALUsrcA : in std_logic;  não precisa ainda
		   		ULAout : out unsigned (15 downto 0);
		   		constante: in unsigned(15 downto 0) -- constante qualquer 
		 );
	end component;

	signal processadorClk, rstProcessador: std_logic;
	signal ULAout, constante: unsigned(15 downto 0);

begin
	uut: processador port map(processadorClk => processadorClk, rstProcessador => rstProcessador,  ULAout => ULAout, constante=>constante );

	process -- clk 50 ns
	begin
		processadorClk <= '0';
		wait for 50 ns;
		processadorClk <= '1';
		wait for 50 ns;
	end process;

	process -- reset
	begin
		rstProcessador <= '1';
		wait for 10 ns;
		rstProcessador <= '0';
		wait for 10 ns;
		wait;
	end process;

	process
	begin
		constante <= "0000000000000000";
		wait for 100 ns;
		wait;
	end process;

end architecture;
