-- Mayank

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity reg is
	generic(width : positive :=8);
	
	port(
	clk : in std_logic;
	rst : in std_logic;
	load: in std_logic;
	input : in std_logic_vector(width-1 downto 0);
	output :out std_logic_vector(width-1 downto 0)
	);
end reg;

architecture rtl of reg is
begin
	process(clk,rst)
	begin
		if(rst='1') then
			output<= (others=>'0');
			
		elsif(rising_edge(clk)) then
			if(load='1') then
				output<=input;
			end if;
		end if;
	end process;
end rtl;
	