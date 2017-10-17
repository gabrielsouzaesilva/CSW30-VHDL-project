library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture a_processador_tb of processador_tb is
	component processador
		port (	processadorClk : in std_logic; -- clk geral
		 	  	rstProcessador : in std_logic; -- Reset 
		   		constante: in unsigned(15 downto 0); -- constante qualquer 
		   		ULAout : out unsigned (15 downto 0); -- Saida ULA
		   		estado_p: out unsigned(1 downto 0); -- Pino saida estado da maquina de estados
		   		pcOut: out unsigned(15 downto 0); -- Pino saida PC
		   		romOut: out unsigned(15 downto 0); -- Pino saida data ROM
		   		bacnoRegOut_A: out unsigned(15 downto 0); -- Pino saida regA
		   		bacnoRegOut_B: out unsigned(15 downto 0)	 -- Pino saida regB
		 );
	end component;

	signal processadorClk, rstProcessador: std_logic;
	signal ULAout, constante: unsigned(15 downto 0);

begin
	uut: processador port map(processadorClk => processadorClk, rstProcessador => rstProcessador,  ULAout => ULAout, constante=>constante );

	process -- clk 25 ns
	begin
		processadorClk <= '0';
		wait for 25 ns;
		processadorClk <= '1';
		wait for 25 ns;
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
