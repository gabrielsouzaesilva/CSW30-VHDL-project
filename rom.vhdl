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
		 	 0 	=> "0100000110000101", -- mov 5, $r3
			 1 	=> "0100001000001000", -- mov 8, $r4
			 2 	=> "0010000111000000", -- add $r3, $r4
			 3 	=> "0100011001010000", -- mov $r4, $r5
			 4 	=> "0100101011111111", -- add -1, $r5	
			 5 	=> "1111110000010100", -- jump 20
			 6 	=> "0000000000000000",  
			 7 	=> "0000000000000000",  
			 8  => "0000000000000000",  
			 9 	=> "0000000000000000",  
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
			 20 => "0100011010110000", -- mov $r5, $r3
			 21 => "1111110000000010", -- jump 2 (address 2) : LOOP
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
