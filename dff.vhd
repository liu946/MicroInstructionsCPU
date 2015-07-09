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
     if RST='1' then
       q<='0';
     elsif CLK='1'and CLK'event then
       q<=d;
     end if;
   end process;

END;


