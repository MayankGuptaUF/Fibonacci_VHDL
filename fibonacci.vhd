-- Mayank Gupta
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fibonacci is

	generic
	( width: positive:=8);
	
	port 
	(
		rst,clk: in std_logic;
		n	: in std_logic_vector(width-1 downto 0);
		go 	: in std_logic;
		done	:out std_logic;
		output	: out std_logic_vector(width-1 downto 0)
		);
end fibonacci;

architecture FSM_D of fibonacci is

	signal i_sel	 :std_logic;
	signal i_ld		 :std_logic;
	signal x_sel	 :std_logic;
	signal x_ld		 :std_logic;
	signal y_sel	 :std_logic;
	signal y_ld		 :std_logic;
	signal n_ld		 :std_logic;
	signal result_ld :std_logic;
	signal i_le_n	 :std_logic;

begin
	U_CONTROLLER : entity work.controller
        port map 
		(
			clk       => clk,
			rst       => rst,
			go        => go,
			done      => done,
			i_sel	  => i_sel,
			i_ld	  => i_ld,
			x_sel     => x_sel,
			x_ld      => x_ld,
			y_sel     => y_sel,
			y_ld      => y_ld,
			n_ld	  => n_ld,
			result_ld => result_ld,
			i_le_n    => i_le_n
		);

    U_DATAPATH : entity work.datapath
        generic map (width => width)
        port map 
		(
			clk       => clk,
            rst       => rst,
            i_sel	  => i_sel,
            i_ld	  => i_ld,
			x_sel     => x_sel,
			x_ld      => x_ld,
			y_sel     => y_sel,
			y_ld      => y_ld,
			n_ld	  => n_ld,
			result_ld => result_ld,
			i_le_n    => i_le_n,
            n         => n,
            output    => output
		);
end FSM_D;