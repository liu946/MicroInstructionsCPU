
library IEEE;
use IEEE.std_logic_1164.all;

entity testshiftrgt is
    port ( B: out STD_LOGIC);
end testshiftrgt;

architecture test of testshiftrgt is
  COMPONENT shift_rgt
    port ( A,CLK,RST: in STD_LOGIC;
               B: out STD_LOGIC);
  END COMPONENT;
  SIGNAL x,clk,rst: STD_LOGIC;

BEGIN
    u: shift_rgt port map (CLK=>clk,A=>x,B=>B,RST=>rst);  
   PROCESS
     begin
     x<='0';
     rst <= '1';wait for 30ns;
     rst <= '0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     wait for 1000ns;
   END PROCESS;
   process
    begin
    if clk = '0' then
      clk <= '1'; wait for 5ns;
    else 
      clk <= '0';wait for 5ns;
    end if;
  end process;
END;

