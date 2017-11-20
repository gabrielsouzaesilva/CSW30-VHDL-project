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
		 	 0 	=> "0100000010000000", 
			 1 	=> "0100000100000000", 
			 2 	=> "0110010010100000", 
			 3 	=> "0100100010000001", 
			 4 	=> "0100100100000001", 
			 5 	=> "0110010010100000", 
			 6 	=> "0100100010000001", 
			 7 	=> "0100100100000001",
			 8  => "0110010010100000",  
			 9 	=> "0100100010000001",  
			 10 => "0100100100000001",
			 11 => "0110010010100000",  
			 12 => "0110000010110000",  
			 13 => "0100100011111111", 
			 14 => "0110000010110000",  
			 15 => "0100100011111111",  
			 16 => "0110000010110000",  
			 17 => "0100100011111111",  
			 18 => "0110000010110000",  
			 19 => "0000000000000000",  
			 20 => "0000000000000000", 
			 21 => "0000000000000000", 
			 22 => "0000000000000000", 
 
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
