


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity mem is
  PORT (clk: IN STD_LOGIC;
        memcbus: IN STD_LOGIC_VECTOR(1 downto 0);
        memabus :IN STD_LOGIC_VECTOR(7 downto 0);
        memdbus :INOUT STD_LOGIC_VECTOR(7 downto 0) );
end entity mem;

architecture membhv of mem is 
begin
  process(clk)
    begin
      if memcbus = "00" then
        case memabus is
          -- code
          -- 00000001           acc++
          -- 00000010 xxxxxxxx  acc = xx
          -- 00000011           acc = io
          -- 00000100 xxxxxxxx  acc = mem[xx]
          -- 00000110 xxxxxxxx  jmp[xx]
          -- 
          when "00000000" => memdbus <= "00000011"; -- acc=io
          when "00000001" => memdbus <= "00000001"; -- acc++
          when "00000010" => memdbus <= "00000110";
          when "00000011" => memdbus <= "00000001"; 
          when "00000100" => memdbus <= "00000011"; 
          when "00000101" => memdbus <= "00000001";
          when "00000110" => memdbus <= "00000100"; 
          when "00000111" => memdbus <= "00000001";
          --data
          when "10000000" => memdbus <= "01010101"; 
          when others =>
        end case;
      else
        memdbus <= "ZZZZZZZZ";
      end if;
    end process;
  end architecture membhv; 
  