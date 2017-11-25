library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_tb is
end entity;

architecture a_pc_tb of pc_tb is
	component pc
	port (	clk : in std_logic;
			write_en : in std_logic;
			rst : in std_logic;
			data_in : in unsigned(15 downto 0);
			data_out : out unsigned(15 downto 0)
		);
	end component;

	signal clk, write_en, rst: std_logic;
	signal data_in, data_out: unsigned(15 downto 0);

	begin
		uut: pc port map( clk => clk, write_en => write_en, rst => rst, data_in => data_in, data_out => data_out);

	process -- Clock 50ns 
	begin
		clk <= '0';
		wait for 50 ns;
		clk <= '1';
		wait for 50 ns;
	end process;

	process -- Sinal Reset
	begin
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait for 500 ns;
		rst <= '1';
		wait for 10 ns;
		rst <= '0';
		wait;
	end process;

	process -- escreve valores no PC e no final reseta pc
	begin
		write_en <= '1';
		data_in <= "0000000000000010";
		wait for 100 ns;
		write_en <= '1';
		data_in <= "1000000000000000";
		wait for 100 ns;
		write_en <= '1';
		data_in <= "1000000000000001";
		wait for 100 ns;
		write_en <= '1';
		data_in <= "1000000000000010";
		wait for 100 ns;
		write_en <= '0';
		data_in <= "1010101010101010";
		wait for 100 ns;
		wait;
	end process;
end architecture;