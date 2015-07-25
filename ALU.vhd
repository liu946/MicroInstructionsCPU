--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;
entity alu is
  PORT (a , b :IN STD_LOGIC_VECTOR(7 downto 0);
        ctrl :in STD_LOGIC_VECTOR(1 downto 0);
        aluout: out STD_LOGIC_VECTOR(7 downto 0) );
end entity alu;
architecture bhv of alu is 
begin
  process(a,b,ctrl)
    begin
      case ctrl is 
      when "00" => aluout<=a+b;
      when "01" => aluout<=a-b;
      when "10" => aluout<=b;
      when others => aluout<=a;
      end case;
  end process;
end;