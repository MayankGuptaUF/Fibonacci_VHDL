-- Mayank Gupta

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity  controller is
    generic ( width : positive := 8);
port 

( -- inputs

    clk : in std_logic;
    rst : in std_logic;
    go : in std_logic;
    i_le_n :in std_logic;

    --outputs
    i_sel: out std_logic;
    i_ld: out std_logic;
    x_sel:out std_logic;
    x_ld:out std_logic;
    y_sel:out std_logic;
    y_ld:out std_logic;
    n_ld:out std_logic;
    result_ld:out std_logic;
    
    
    done : out std_logic
    
    
    );
end controller; 

architecture rtl of controller is

type STATE_TYPE is (S_0,S_1,S_2,S_3,S_4,S_5);
signal state, next_state : STATE_TYPE;
-- S_0 when all 0
begin
    process(clk, rst)
    begin
    if (rst = '1') then
    state <= S_0;
    elsif (rising_edge(clk)) then
    state <= next_state;
    end if;
    end process;
    
    process(go, i_le_n, state)
    begin
    i_sel<='0';
    i_ld<='0';
    x_sel<='0';
    x_ld<='0';
    y_sel<='0';
    y_ld<='0';
    n_ld<='0';
    result_ld<='0';
    done<='0';
    
    next_state<=state;
    
    case state is
    
        when S_0=>
            case go is 
                when '1'=>
            next_state<=S_1;
            when others=>
              i_sel<='0';
              i_ld<='0';
              x_sel<='0';
              x_ld<='0';
              y_sel<='0';
              y_ld<='0';
              n_ld<='0';
              result_ld<='0';
              done<='0';
     end case;
    -- S_1 intialize the 1 and 1 
        when S_1=>
        i_sel<='0';
        x_sel<='0';
        y_sel<='0';
        i_ld<='1';
        x_ld<='1';
        y_ld<='1';
        n_ld<='1';
        next_state<=S_2;
        -- S_2 check if equal to brekas			
        when S_2=>
        case i_le_n is
        when '1' =>
        next_state<=S_3;
        when others=>
        next_state<=S_4;
        end case;
        -- Load output if it does		
        when S_3=>
        result_ld<='1';
        done<='1';
        if(go='0') then
        next_state<=S_5;
        end if;
        -- Else loop with 2 until it is equal			
        when S_4=>
        i_sel<='1';
        x_sel<='1';
        y_sel<='1';
        i_ld	<= '1';
        x_ld	<= '1';
        y_ld	<= '1';
        next_state<=S_2;
        
        
        -- Used to reset the output and set the done to 1
        
        when S_5=>
        done<='1';
        
        if(go='1') then
        done<='0';
        next_state<=S_1;
        end if;
        
    
    
        when others => null;

end case;
end process;
end rtl;
    
    
    
    
