


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mem is
  PORT (clk: IN STD_LOGIC;
        memcbus: IN STD_LOGIC_VECTOR(1 downto 0);
        memabus :IN STD_LOGIC_VECTOR(7 downto 0);
        memdbus :INOUT STD_LOGIC_VECTOR(7 downto 0) );
end entity mem;

architecture membhv of mem is 
subtype word is Std_logic_vector(7 downto 0); 
type memory is array(0 to 2 ** 6) of word;
signal ram:memory;
signal adr_in :INTEGER;

begin
  adr_in <=conv_integer(memabus(6 downto 0));
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
          -- 00000111 xxxxxxxx  [xx] acc 
          -- 
          when "00000000" => memdbus <= "00000011"; -- acc=io
          when "00000001" => memdbus <= "00000111"; -- write
          when "00000010" => memdbus <= "10000001"; 
          when "00000011" => memdbus <= "00000001"; -- acc++
          when "00000100" => memdbus <= "00000100"; -- read
          when "00000101" => memdbus <= "10000001";
          when "00000110" => memdbus <= "00000100"; 
          when "00000111" => memdbus <= "00000001";
          --data ram read test
          when "10000000" => memdbus <= "01010101"; 
          when others =>
            memdbus <= ram(adr_in);
        end case;
      elsif memcbus = "10" and clk = '0' then         -- 10 write data
        ram(adr_in) <= memdbus;
      else
        memdbus <= "ZZZZZZZZ";
      end if;
    end process;
  end architecture membhv; 
  