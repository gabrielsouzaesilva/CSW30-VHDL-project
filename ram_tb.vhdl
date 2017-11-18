library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram_tb is
end entity;

architecture a_ram_tb of ram_tb is
	component ram
	port(	clk		: in std_logic;
			address	: in unsigned(15 downto 0);
			write_en: in std_logic;
			data_in	: in unsigned(15 downto 0);
			data_out: out unsigned(15 downto 0)
		);
	end component;

	signal clk, write_en: std_logic;
	signal address, data_in, data_out: unsigned(15 downto 0);

	begin
		uut: ram port map(clk => clk, address =>address, write_en=>write_en, data_in=>data_in, data_out =>data_out);

	process
	begin 
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process
	begin
		write_en<='1'; 
		address<="0000000000000000";
		data_in<="1111111111111111";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000000001";
		data_in<="1111111111111110";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000000101";
		data_in<="1111111111111101";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000001111";
		data_in<="1111111111111100";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000000000";
		data_in<="1111111111111011";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000000101";
		data_in<="1111111111111010";
		wait for 100 ns;
		write_en<='1';
		address<="0000000000000000";
		data_in<="1111111111111001";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000000000";
		data_in<="1111111111111000";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000000001";
		data_in<="0000000000000000";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000000010";
		data_in<="0000000000000001";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000000011";
		data_in<="0000000000000001";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000000101";
		data_in<="0000000000000001";
		wait for 100 ns;
		write_en<='0';
		address<="0000000000001111";
		data_in<="0000000000000001";
		wait for 100 ns;
		wait;
	end process;
end architecture;