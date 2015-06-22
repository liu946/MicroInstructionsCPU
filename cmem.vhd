

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity cmem is
  PORT (clk: IN STD_LOGIC;
        cmemabus :IN STD_LOGIC_VECTOR(9 downto 0);
        cmemdbus :OUT STD_LOGIC_VECTOR(7 downto 0) );
end entity cmem;

architecture cmembhv of cmem is 
begin
  process(clk)
    begin
      case cmemabus is                             -- code(7-4)   | bus status (3-2)| uPC(1-0) 
                                                   -- code default
        when "0000000000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "0000000001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "0000000010" => cmemdbus <= "11110010"; -- PC++        |(mem->cpu)->cbus | IR<<2 ->uPC 
        when "0000000011" => cmemdbus <= "00000000"; 
                                                   -- code(0000 0001) acc++          
        when "0000000100" => cmemdbus <= "00110011"; -- ACC++       |(mem->cpu)->cbus |0
        when "0000000101" => cmemdbus <= "00000000";
        when "0000000110" => cmemdbus <= "00000000";
        when "0000000111" => cmemdbus <= "00000000";
                                                   -- code(0000 0010) acc = [xx]
        when "0000001000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "0000001001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "0000001010" => cmemdbus <= "01000000"; -- IR->ACC     |(mem->cpu)->cbus |++
        when "0000001011" => cmemdbus <= "11110011"; -- PC++        |(mem->cpu)->cbus |0
                                                   -- code(0000 0011) acc = io
        when "0000001100" => cmemdbus <= "00100100"; -- null        |(io->cpu)->cbus  |++
        when "0000001101" => cmemdbus <= "00010100"; -- dbus->IR    |(io->cpu)->cbus  |++
        when "0000001110" => cmemdbus <= "01000111"; -- IR->ACC     |(io->cpu)->cbus  |0
        when "0000001111" => cmemdbus <= "00000000";
                                                    -- code(0000 0100) acc = mem[xx]
        when "0000010000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "0000010001" => cmemdbus <= "01100000"; -- dbus->mar   |(mem->cpu)->cbus |++
        when "0000010010" => cmemdbus <= "01010000"; -- mar->abus   |(mem->cpu)->cbus |++
        when "0000010011" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "0000010100" => cmemdbus <= "01000000"; -- IR->ACC     |(mem->cpu)->cbus |++
        when "0000010101" => cmemdbus <= "11110011"; -- PC++        |(mem->cpu)->cbus |0
        when "0000010110" => cmemdbus <= "00000000"; 
        when "0000010111" => cmemdbus <= "00000000";
                                                   -- code(0000 0110) jmp [xx]
        when "0000011000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "0000011001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++
        when "0000011010" => cmemdbus <= "01110011"; -- IR->PC      |(mem->cpu)->cbus |0
        when "0000011011" => cmemdbus <= "00000000"; 
                                                   -- code(0000 0111) [xx] = acc
        when "0000011100" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++
        when "0000011101" => cmemdbus <= "01100000"; -- dbus->mar   |(mem->cpu)->cbus |++
        when "0000011110" => cmemdbus <= "01010000"; -- mar->abus   |(mem->cpu)->cbus |++
        when "0000011111" => cmemdbus <= "10001000"; -- acc->dbus   |(cpu->mem)->cbus |++ 
        when "0000100000" => cmemdbus <= "11110011"; -- PC++        |(mem->cpu)->cbus |0
        when "0000100001" => cmemdbus <= "01100000"; 
        when "0000100010" => cmemdbus <= "01011000";
        when "0000100011" => cmemdbus <= "10000000"; 
                                                   -- code(0000 1001) reg0 = acc
        when "0000100100" => cmemdbus <= "10010011"; -- acc->reg    |reg0             |0
        when "0000100101" => cmemdbus <= "00000000";
        when "0000100110" => cmemdbus <= "00000000";
        when "0000100111" => cmemdbus <= "10000000"; 
                                                   -- code(0000 1010) reg1 = acc
        when "0000101000" => cmemdbus <= "10010111"; -- acc->reg    |reg1             |0
        when "0000101001" => cmemdbus <= "00000000";
        when "0000101010" => cmemdbus <= "00000000";
        when "0000101011" => cmemdbus <= "10000000"; 
                                                   -- code(0000 1011) reg1 ++
        when "0000101100" => cmemdbus <= "10100100"; -- reg->acc    |reg1             |++
        when "0000101101" => cmemdbus <= "00110000"; -- ACC++       |(mem->cpu)->cbus |++
        when "0000101110" => cmemdbus <= "10010111"; -- acc->reg    |reg1             |0
        when "0000101111" => cmemdbus <= "10000000"; 
                                                   -- code(0000 1100) acc = reg0%reg1 
        when "0000110000" => cmemdbus <= "10110011"; -- acc = reg0%reg1|              |0
        when "0000110001" => cmemdbus <= "00110000"; 
        when "0000110010" => cmemdbus <= "10010111"; 
        when "0000110011" => cmemdbus <= "10000000"; 
                                                   -- code(0000 1101) jmpif(acc==0) 
        when "0000110100" => cmemdbus <= "00100001"; -- null           |              |condition jmp
        when "0000110101" => cmemdbus <= "11110011"; -- PC++           |              |0
        when "0000110110" => cmemdbus <= "00000000"; 
        when "0000110111" => cmemdbus <= "00000000"; 
        when "0000111000" => cmemdbus <= "00000000"; -- pc->abus    |(mem->cpu)->cbus |++| condition acc==0
        when "0000111001" => cmemdbus <= "00010000"; -- dbus->IR    |(mem->cpu)->cbus |++ 
        when "0000111010" => cmemdbus <= "01110011"; -- IR->PC      |(mem->cpu)->cbus |0 
        when "0000111011" => cmemdbus <= "00000000";
                                                  -- code(0000 1111) acc=reg0-reg1
        when "0000111100" => cmemdbus <= "10110011"; -- acc = reg0-reg1 |(mem->cpu)->cbus |0
        when "0000111101" => cmemdbus <= "00000000"; 
        when "0000111110" => cmemdbus <= "00000000"; 
        when "0000111111" => cmemdbus <= "00000000";
                                                  -- code(0001 0000) acc=reg2
        when "0001000000" => cmemdbus <= "10101011"; -- acc = reg2   |(mem->cpu)->cbus |0
        when "0001000001" => cmemdbus <= "00000000"; 
        when "0001000010" => cmemdbus <= "00000000"; 
        when "0001000011" => cmemdbus <= "00000000";
                                                  -- code(0001 0001) reg2+=reg1
        when "0001000100" => cmemdbus <= "10100100"; -- acc = reg1   |(mem->cpu)->cbus |0
        when "0001000101" => cmemdbus <= "11001011"; -- reg2+=acc   |(mem->cpu)->cbus |0 
        when "0001000110" => cmemdbus <= "00000000"; 
        when "0001000111" => cmemdbus <= "00000000";
                                                  -- code(0001 0010) reg2=acc
        when "0001001000" => cmemdbus <= "10011011"; -- acc->reg    |reg2             |0
        when "0001001001" => cmemdbus <= "00000000"; 
        when "0001001010" => cmemdbus <= "00000000"; 
        when "0001001011" => cmemdbus <= "00000000";
        when others =>
      end case;
    end process;
  end architecture cmembhv; 
  
  
