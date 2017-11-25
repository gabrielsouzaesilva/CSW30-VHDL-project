library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end;


architecture a_ula_tb of ula_tb is
	component ula
		port( in_a : in unsigned(15 downto 0);
			  in_b : in unsigned(15 downto 0);
			  sel_op : in unsigned(2 downto 0);
			  out_a : out unsigned(15 downto 0)
			  );
	end component;
	signal in_a,in_b,out_a : unsigned(15 downto 0);
	signal sel_op : unsigned(2 downto 0);
begin
	uut: ula port map( in_a => in_a,
					   in_b => in_b,
					   sel_op => sel_op,
					   out_a => out_a);
	process
	begin
		in_a <= "0111111111111111"; 
		in_b <= "0111111111111111"; 
		sel_op <= "000";			
		wait for 50 ns;
		in_a <= "1000000000000001"; 
		in_b <= "1000000000000001"; 
		sel_op <= "000";			
		wait for 50 ns;
		in_a <= "1000000000000000";  
		in_b <= "1000000000000000";
		sel_op <= "000";			
		wait for 50 ns;
		in_a <= "0111111111111111";   
		in_b <= "0111111111111111";
		sel_op <= "001";
		wait for 50 ns;
		in_a <= "1111111111111111";
		in_b <= "1111111111111111";
		sel_op <= "001";
		wait for 50 ns;
		in_a <= "1000000000000000";
		in_b <= "1000000000000001";
		sel_op <= "001";			
		wait for 50 ns;
		in_a <= "1000000000000000";  
		in_b <= "0111111111111111";
		sel_op <= "010";
		wait for 50 ns;
		in_a <= "0000000000000000";  
		in_b <= "1000000000000000";
		sel_op <= "010";			
		wait for 50 ns;
		in_a <= "0000000000000000";  
		in_b <= "0000000000000001";
		sel_op <= "011";
		wait for 50 ns;
		in_a <= "1000000000000010";  
		in_b <= "0000000000000010";
		sel_op <= "011";
		wait for 50 ns;
		in_a <= "0000000000000010";  
		in_b <= "1000000000000010";
		sel_op <= "011";			
		wait for 50 ns;
		in_a <= "1010101010101010";  
		in_b <= "0101010101010101";
		sel_op <= "100";
		wait for 50 ns;
		in_a <= "1111111100000000";  
		in_b <= "0000000011111110";
		sel_op <= "100";			
		wait for 50 ns;
		in_a <= "0101010101010101";  
		in_b <= "0101010101010101";
		sel_op <= "101";
		wait for 50 ns;
		in_a <= "1111111111111111";  
		in_b <= "0101010101010101";
		sel_op <= "101";			
		wait for 50 ns;
		wait;
	end process;
end architecture;

