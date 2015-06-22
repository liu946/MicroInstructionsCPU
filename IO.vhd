
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity io is
  PORT (clk: IN STD_LOGIC;
        iocbus: IN STD_LOGIC_VECTOR(1 downto 0);
        iodbus :INOUT STD_LOGIC_VECTOR(7 downto 0) );
end entity io;

architecture iobhv of io is 
begin
  process(clk)
    begin
      if iocbus = "01" then 
        iodbus <= "00111100";
      else
        iodbus <= "ZZZZZZZZ";
      end if;
      
    end process;
  end architecture iobhv; 
  
  

