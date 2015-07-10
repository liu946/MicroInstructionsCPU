
library IEEE;
use IEEE.std_logic_1164.all;

entity testwrc is
    port ( WE,OE: out STD_LOGIC);
end testwrc;

architecture test of testwrc is
  COMPONENT wrc
    PORT (clk,rst,read_write: IN STD_LOGIC;
        we,oe: OUT STD_LOGIC);
  END COMPONENT;
  SIGNAL x,clk,rst: STD_LOGIC;

BEGIN
    u: wrc port map (read_write=>x,clk=>clk,rst=>rst,we=>we,oe=>oe);  
   PROCESS
     begin
     x<='0';
     rst <= '1';wait for 30ns;
     rst <= '0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='1';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     x<='1';wait for 10ns;
     x<='1';wait for 10ns;
     x<='0';wait for 10ns;
     x<='0';wait for 10ns;
     rst<='1';
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



