library IEEE;
use IEEE.std_logic_1164.all;

entity shift_rgt is
    port ( A,CLK,RST: in STD_LOGIC;
               B: out STD_LOGIC);
end shift_rgt;

architecture f_shift_rgt of shift_rgt is
  COMPONENT dff
   port ( d,CLK,RST: in STD_LOGIC;
               q: out STD_LOGIC);
  END COMPONENT;
  SIGNAL x: STD_LOGIC_VECTOR(0 to 4);

BEGIN
   x(0)<=A;          -- link x0 : u1.d -- A 
       
   G1:FOR i IN 0 to 3 GENERATE
           U1:dff PORT MAP (x(i), CLK,RST, x(i+1)); -- link u1.q-u2.d u2.q-u3.d u3.q-u4.d u4.q-x4
         END GENERATE;
       
   B<=x(4); -- link x4-B
   
   process(RST) 
     begin
     if RST='1'and RST'event then
       for i in 0 to 4 loop
        x(i)<='0'; -- set 0 when rst
       end loop;
     else
       for i in 0 to 4 loop
        x(i)<='Z'; -- set read state
       end loop;
     end if;
   end process;

END;

