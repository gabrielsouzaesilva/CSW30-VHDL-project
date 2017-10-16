library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is 
	port( clk : in std_logic;
		  address : in unsigned(15 downto 0);
		  data : out unsigned(15 downto 0)
		);
end entity;

architecture a_rom of rom is
	type mem is array (0 to 65536) of unsigned(15 downto 0);
	constant content_rom : mem := (
		 0 => "1000000011000101", -- addi $r3, $zero, 5
		 1 => "1000000100001000", -- addi $r4, $zero, 8
		 2 => "0001011100101000", -- add $r5, $r3, $r4, 000 
		 3 => "1000101101111111", -- addi $r5, $r5, -1
		 4 => "1111000000010100", -- jump 000000010100 (address 20)
		 5 => "0000000000000000", 
		 6 => "0000000000000000",  
		 7 => "0000000000000000",  
		 8 => "0000000000000000",  
		 9 => "0000000000000000",  
		 10 => "0000000000000000",
		 11 => "0000000000000000",  
		 12 => "0000000000000000",  
		 13 => "0000000000000000",  
		 14 => "0000000000000000",  
		 15 => "0000000000000000",  
		 16 => "0000000000000000",  
		 17 => "0000000000000000",  
		 18 => "0000000000000000",  
		 19 => "0000000000000000",  
		 20 => "1001100011000000", -- cpy $r3, $r4, 000000
		 21 => "1111000000000011", -- jump 000000000011 (address 3) : LOOP
		 -- abaixo: casos omissos => (zero em todos os bits)
		 others => (others=>'0')
	);
begin
	process(clk)
	begin
		if (rising_edge(clk)) then
			data <= content_rom(to_integer(address));
		end if;
	end process;
end architecture;
