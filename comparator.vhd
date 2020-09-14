-- Mayank Gupta


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity comparator is
	generic(width: positive :=8);
	
	port(
	
	in1: in std_logic_vector(width-1 downto 0);
	in2: in std_logic_vector(width-1 downto 0);
	equal: out std_logic);
end comparator;

architecture rtl of comparator is
begin 
    process(in1,in2)
    begin
        if(unsigned(in1)<=unsigned(in2)) then
            equal<='0';
        else 
            equal<='1';
        end if;
    end process;


end rtl;