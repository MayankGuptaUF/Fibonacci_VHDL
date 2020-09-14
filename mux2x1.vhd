--Mayank Gupta

library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
    generic(width : positive :=8);
port(

    in1 :   in std_logic_vector(width-1 downto 0);
    in2 :   in std_logic_vector(width-1 downto 0);
    sel :   in std_logic;
    output  :   out std_logic_vector(width-1 downto 0)
    );
end mux2x1;

architecture rtl of mux2x1 is
begin
  process(in1,in2,sel)
  begin
    if(sel='0') then
        output<= in1;
    else
        output<= in2;
    end if;
   end process;
end rtl;
  

