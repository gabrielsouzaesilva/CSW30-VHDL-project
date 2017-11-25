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
		   		bacnoRegOut_B: out unsigned(15 downto 0); -- Pino saida regB
		   		ramOut:	out unsigned(15 downto 0) -- Pina saida RAM
		 );
	end component;

	signal processadorClk, rstProcessador: std_logic;
	signal estado_p: unsigned(1 downto 0);
	signal ULAout, constante,pcOut,romOut,bacnoRegOut_A,bacnoRegOut_B, ramOut: unsigned(15 downto 0);

begin
	uut: processador port map(processadorClk => processadorClk, rstProcessador => rstProcessador,  ULAout => ULAout, constante=>constante, estado_p=>estado_p,
								pcOut => pcOut, romOut=>romOut , bacnoRegOut_A=>bacnoRegOut_A, bacnoRegOut_B=>bacnoRegOut_B, ramOut=>ramOut);

	process -- clk 100 ns
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
