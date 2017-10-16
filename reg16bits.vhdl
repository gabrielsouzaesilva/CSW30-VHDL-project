library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg16bits is
	port( regClk		: in std_logic; -- Clock
		  regRst 		: in std_logic; -- Reset
		  regWrite_en	: in std_logic; -- Permite escrever no registrador
		  regData_in	: in unsigned(15 downto 0); -- Entrada de dados
		  regData_out	: out unsigned(15 downto 0) -- Saida de dados 
		);
end entity;

architecture a_reg16bits of reg16bits is
	signal registro: unsigned(15 downto 0);
begin

	process(regClk, regRst, regWrite_en)
	begin
		if regRst='1' then
			registro <= "0000000000000000";
		elsif (regWrite_en='1') then
			if rising_edge(regClk) then
				registro <= regData_in;
			end if;
		end if;
	end process;

	regData_out <= registro;
end architecture;
			