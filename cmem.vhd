

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity cmem is
  PORT (clk: IN STD_LOGIC;
        cmemabus :IN STD_LOGIC_VECTOR(7 downto 0);
        cmemdbus :OUT STD_LOGIC_VECTOR(7 downto 0) );
end entity cmem;

architecture cmembhv of cmem is 
begin
  process(clk)
    begin
      case cmemabus is                             -- code(7-4)   | bus status (3-2)| uPC(1-0) 
                                                   -- code default
        when "00000000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "00000001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "00000010" => cmemdbus <= "11110010"; -- PC++        |(mem->cpu)->cbus | IR<<2 ->uPC 
        when "00000011" => cmemdbus <= "00000000"; 
                                                   -- code(0000 0001) acc++          
        when "00000100" => cmemdbus <= "00110011"; -- ACC++       |(mem->cpu)->cbus |0
        when "00000101" => cmemdbus <= "00000000";
        when "00000110" => cmemdbus <= "00000000";
        when "00000111" => cmemdbus <= "00000000";
                                                   -- code(0000 0010) acc = [xx]
        when "00001000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "00001001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "00001010" => cmemdbus <= "01000000"; -- IR->ACC     |(mem->cpu)->cbus |++
        when "00001011" => cmemdbus <= "11110011"; -- PC++        |(mem->cpu)->cbus |0
                                                   -- code(0000 0011) acc = io
        when "00001100" => cmemdbus <= "00100100"; -- null        |(io->cpu)->cbus  |++
        when "00001101" => cmemdbus <= "00010100"; -- dbus->IR    |(io->cpu)->cbus  |++
        when "00001110" => cmemdbus <= "01000111"; -- IR->ACC     |(io->cpu)->cbus  |0
        when "00001111" => cmemdbus <= "00000000";
                                                    -- code(0000 0100) acc = mem[xx]
        when "00010000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "00010001" => cmemdbus <= "01100000"; -- dbus->mar   |(mem->cpu)->cbus |++
        when "00010010" => cmemdbus <= "01010000"; -- mar->abus   |(mem->cpu)->cbus |++
        when "00010011" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "00010100" => cmemdbus <= "01000000"; -- IR->ACC     |(mem->cpu)->cbus |++
        when "00010101" => cmemdbus <= "11110011"; -- PC++        |(mem->cpu)->cbus |0
        when "00010110" => cmemdbus <= "00000000"; 
        when "00010111" => cmemdbus <= "00000000";
                                                   -- code(0000 0110) jmp [xx]
        when "00011000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "00011001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "00011010" => cmemdbus <= "01110011"; -- IR->PC      |(mem->cpu)->cbus |0
        when "00011011" => cmemdbus <= "00000000"; 
        
        when others =>
      end case;
    end process;
  end architecture cmembhv; 
  
  
