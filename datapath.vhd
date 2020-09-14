-- Mayank Gupta

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath is

	generic( width : positive :=8);
	
	port(
	-- 11 inputs
	n: in std_logic_vector(width-1 downto 0);
	i_sel: in std_logic;
	i_ld: in std_logic;
	x_sel:in std_logic;
	x_ld:in std_logic;
	y_sel:in std_logic;
	y_ld:in std_logic;
	n_ld:in std_logic;
	result_ld:in std_logic;
	clk:in std_logic;
	rst:in std_logic;
	-- 2 outputs
	
	i_le_n: out std_logic;
	output: out std_logic_vector(width-1 downto 0));
end datapath;

architecture rtl of datapath is
	-- defining all the outputs that are used in intermediate steps
	
	--MUX outputs
	signal mux_i: std_logic_vector(width-1 downto 0);
	signal mux_x: std_logic_vector(width-1 downto 0);
	signal mux_y: std_logic_vector(width-1 downto 0);
	
	-- i,x,y outout
	
	signal out_i: std_logic_vector(width-1 downto 0);
	signal out_x: std_logic_vector(width-1 downto 0);
	signal out_y: std_logic_vector(width-1 downto 0);
	signal out_n: std_logic_vector(width-1 downto 0);
	
	-- 
	signal incrementor: std_logic_vector(width-1 downto 0);
	signal last: std_logic_vector(width-1 downto 0);
    
    -- COnstants
    constant C_1       : std_logic_vector(width-1 downto 0) := std_logic_vector(to_unsigned(1, width));
    constant C_3       : std_logic_vector(width-1 downto 0) := std_logic_vector(to_unsigned(3, width));
begin 
	-- All MUX inputs defined
	
	U_MUX_I: entity work.mux2x1
		generic map(
		width=>width)
		port map(
		in1=> C_3,
		in2=> incrementor,
		sel=> i_sel,
		output=>mux_i);
		
	U_MUX_X: entity work.mux2x1
		generic map(
		width=>width)
		port map(
		in1=> C_1,
		in2=> out_y,
		sel=> x_sel,
		output=>mux_x);
	
	U_MUX_Y: entity work.mux2x1
		
		port map(
		in1=> C_1,
		in2=> last,
		sel=> y_sel,
		output=>mux_y);
		
	-- All register outputs
	
	U_REG_I: entity work.reg
		generic map(
		width=>width)
		port map(
		clk=>clk,
		rst=>rst,
		load=>i_ld,
		input=>mux_i,
		output=>out_i
		);
	
	U_REG_X: entity work.reg
		generic map(
		width=>width)
		port map(
		clk=>clk,
		rst=>rst,
		load=>x_ld,
		input=>mux_x,
		output=>out_x
		);
	
	U_REG_Y: entity work.reg
		generic map(
		width=>width)
		port map(
		clk=>clk,
		rst=>rst,
		load=>y_ld,
		input=>mux_y,
		output=>out_y
		);
		
	U_REG_N: entity work.reg
		generic map(
		width=>width)
		port map(
		clk=>clk,
		rst=>rst,
		load=>n_ld,
		input=>n,
		output=>out_n);
		
	U_COM: entity work.comparator
		generic map(
		width=>width)
		port map(
		in1=>out_i,
		in2=>out_n,
		equal=>i_le_n);
	--ADDers
	U_INC : entity work.adder
	generic map(
	width=>width)
	port map
	(	in1=>C_1,
		in2=>out_i,
		output=>incrementor);
	
	
	U_FINAL_ADD: entity work.adder
	generic map( width=>width)
	port map
	(
		in1=>out_y,
		in2=>out_x,
		output=>last);
		
	U_OUT_STORE: entity work.reg
	generic map(width=>width)
	port map
	
	( 	clk=>clk,
		rst=>rst,
		load=>result_ld,
		input=>out_y,
		output=>output
		);
	
end rtl;
	
	


	
	
	