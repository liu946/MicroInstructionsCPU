library IEEE;
use IEEE.std_logic_1164.all;

entity dff is
    port ( d,CLK,RST: in STD_LOGIC;
               q: out STD_LOGIC:='0');
end dff;

architecture f_dff of dff is
BEGIN
   
   process(CLK,RST)
     begin
     if RST='1' then    -- reset when rst = 1
       q<='0';          -- reset q<=0
     elsif CLK='1'and CLK'event then
       q<=d;            -- sync the q port when clk event
     end if;
   end process;

END;


