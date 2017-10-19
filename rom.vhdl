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
			 2 	=> "0010001000110000", -- add $r4, $r3
			 3 	=> "0100010111010000", -- mov $r3, $r5
			 4 	=> "0100101011111111", -- add -1, $r5	
			 5 	=> "0100000010010100", -- mov 20, $r1
			 6 	=> "1111110010000000", -- jump 20($r1)
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
			 21 => "0100000010000010", -- mov 2, $r1
			 22 => "1111110010000000", -- jump 2($r1)
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
