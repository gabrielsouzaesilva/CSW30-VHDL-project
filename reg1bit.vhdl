library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit is
	port( regClk		: in std_logic; -- Clock
		  regRst 		: in std_logic; -- Reset
		  regWrite_en	: in std_logic; -- Permite escrever no registrador
		  regData_in	: in std_logic; -- Entrada de dados
		  regData_out	: out std_logic -- Saida de dados 
		);
end entity;

architecture a_reg1bit of reg1bit is
	signal registro: std_logic;
begin

	process(regClk, regRst, regWrite_en)
	begin
		if regRst='1' then
			registro <= '0';
		elsif (regWrite_en='1') then
			if rising_edge(regClk) then
				registro <= regData_in;
			end if;
		end if;
	end process;

	regData_out <= registro;
end architecture;
			