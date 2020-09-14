-- Mayank Gupta
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fibonacci_tb is
end fibonacci_tb;

architecture TB of fibonacci_tb is
    constant WIDTH: positive :=8;
	constant CC: time:=5ns;
	signal clk		: std_logic	:= '0';
	signal rst		: std_logic	:= '0';
	signal go		: std_logic	:= '0';
	signal n 		: std_logic_vector(WIDTH-1 downto 0);
	signal done		: std_logic;
	signal output	: std_logic_vector(WIDTH-1 downto 0);
	

begin

	U_TEST:entity work.fibonacci(FSM_D)
	generic map(width=>WIDTH)
	
	port map(
	
			clk => clk,
			rst	=> rst,
			go  => go,
			n 	=> n,
			output => output,
			done => done
			
			);
	clk<= not clk after CC;
	
	process
	
	begin
	
	rst<='1';
	go<='0';
	n<=(others=>'0');
	
	wait for CC;
	rst<='0';
	
	n <= std_logic_vector(to_unsigned(7,WIDTH));
		go <= '1';
		wait until done = '1';
		go <= '0';
		wait for 10*CC;
		
	rst<='1';
	go<='0';
	n<=(others=>'0');
	rst<='0';
	
	n <= std_logic_vector(to_unsigned(4,WIDTH));
		go <= '1';
		wait until done = '1';
		go <= '0';
	   wait for 10*CC;
	   
	rst<='1';
	go<='0';
	rst<='0';
	n <= std_logic_vector(to_unsigned(9,WIDTH));
		go <= '1';
		wait until done = '1';
	    go <= '0';
	
	wait;
	end process;
end TB;