library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula is
	port( in_a : in unsigned(15 downto 0); -- entrada a 16 bits unsigned
		  in_b : in unsigned(15 downto 0); -- entrada b 16 bits unsigned
		  sel_op : in unsigned(2 downto 0); -- seletor para operação 2 bits : 000 soma, 001 subtracao, 010 compara, 011 div, 100 xor, 101 nor
		  out_a : out unsigned(15 downto 0) -- saida 16 bits unsigned
		 );
end entity;

architecture a_ula of ula is
begin
	out_a <= in_a + in_b when sel_op = "000" else
		     in_b - in_a when sel_op = "001" else
		     "0000000000000001" when sel_op = "010" and in_b(15) = '0' and in_a(15) = '0' and in_a > in_b else
		     "0000000000000000" when sel_op = "010" and in_b(15) = '0' and in_a(15) = '0' and in_b > in_a else
		     "0000000000000001" when sel_op = "010" and in_b(15) = '1' and in_a(15) = '1' and in_a > in_b else
		     "0000000000000000" when sel_op = "010" and in_b(15) = '1' and in_a(15) = '1' and in_b > in_a else
		     "0000000000000001" when sel_op = "010" and in_b(15) = '1' and in_a(15) = '0' else
		     "0000000000000000" when sel_op = "010" and in_b(15) = '0' and in_a(15) = '1' else
		     in_a and in_b when sel_op = "011" else
		     in_a xor in_b when sel_op = "100" else
		     in_a nor in_b when sel_op = "101" else
		     "0000000000000001" when sel_op = "110" and in_a = in_b else
		     "0000000000000000" when sel_op = "110" and in_a /= in_b else
			 "0000000000000000";


end architecture;
