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
		 	 0 	=>  "0100001010001100", --mov 12, $r5	
			 1 	=>  "0100001100010111", --mov 23, $r6	
			 2 	=>  "0100001110001101", --mov 13, $r7	
			 3 	=>  "0100000100100011", --mov 35, $r2 
			 4 	=>  "0100100010000001", --add 1, $r1 		
			 5 	=>  "0110010010010000", --st.w $r1, $r1 	
			 6 	=>  "0010100100011110", --bgt $r2, $r1, -2
			 7 	=>  "0100000010000010",
			 8  =>  "1111111010000000",  
			 9 	=>  "1111111100000000",  
			 10 =>  "0100100010000001",
			 11 =>  "0010100010101110",  
			 12 =>  "0100010011000000",  
			 13 =>  "0100101000000001", 
			 14 =>  "0100011000110000",  
			 15 =>  "0010010010110000",  
			 16 =>  "0010100110001111",  
			 17 =>  "0011100000110011",  
			 18 =>  "0010101000101000",  
			 19 =>  "1111111110000000",  
			 20 =>  "0110011000000000", 
			 21 =>  "0010100101001000", 
			 22 =>  "1111111110000000",
			 23 =>	"0000000000000000", 
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
