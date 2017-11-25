library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture a_rom_tb of rom_tb is
	component rom
	port( clk : in std_logic;
		  address : in unsigned(15 downto 0);
		  data : out unsigned(15 downto 0)
		);
	end component;

	signal clk: std_logic;
	signal address: unsigned(15 downto 0);
	signal data: unsigned(15 downto 0);

	begin
		uut: rom port map ( clk => clk, address => address, data => data);

	process -- Clock 50ns 
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process -- testa os 10 endereços com dados e o 11º para teste do resto zerado
	begin
		address <= "0000000000000000";
		wait for 100 ns;
		address <= "0000000000000001";
		wait for 100 ns;
		address <= "0000000000000010";
		wait for 100 ns;
		address <= "0000000000000011";
		wait for 100 ns;
		address <= "0000000000000100";
		wait for 100 ns;
		address <= "0000000000000101";
		wait for 100 ns;
		address <= "0000000000000110";
		wait for 100 ns;
		address <= "0000000000000111";
		wait for 100 ns;
		address <= "0000000000001000";
		wait for 100 ns;
		address <= "0000000000001001";
		wait for 100 ns;
		address <= "0000000000001010";
		wait for 100 ns;
		address <= "0000000000001011"; -- end 11
		wait for 100 ns;
		wait;
	end process;
end architecture;