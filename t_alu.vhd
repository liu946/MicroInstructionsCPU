--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity t_alu is 
end entity t_alu;

architecture bhv of t_alu is
component alu
  PORT (aluout: out STD_LOGIC_VECTOR(7 downto 0);
        a,b :IN STD_LOGIC_VECTOR(7 downto 0);
        ctrl :in STD_LOGIC_VECTOR(1 downto 0) );
end component;

signal a,b,aluout:STD_LOGIC_VECTOR(7 downto 0);
signal ctrl:STD_LOGIC_VECTOR(1 downto 0);
begin
  ualu: alu port map (aluout,a,b,ctrl);
  PROCESS
     begin
     a<="10101110";
     b<="01010011";
     ctrl <= "00";wait for 10ns;
     ctrl <= "01";wait for 10ns;
     ctrl <= "10";wait for 10ns;
     ctrl <= "11";wait for 10ns;
     a<="10101000";
     b<="01000011";
     ctrl <= "00";wait for 10ns;
     ctrl <= "01";wait for 10ns;
     ctrl <= "10";wait for 10ns;
     ctrl <= "11";wait for 10ns;
     a<="10001010";
     b<="00010011";
     ctrl <= "00";wait for 10ns;
     ctrl <= "01";wait for 10ns;
     ctrl <= "10";wait for 10ns;
     ctrl <= "11";wait for 10ns;
  end process;
end;
