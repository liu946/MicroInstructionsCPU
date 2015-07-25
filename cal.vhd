--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity cal is
    PORT (
        t0,t1,clk,rreg:IN STD_LOGIC ; --???0,???1,????,????
        IR:IN STD_LOGIC_VECTOR(15 downto 0); -- ??
        data8 :INOUT STD_LOGIC_VECTOR(7 downto 0); -- ?????
        addr16 :inout STD_LOGIC_VECTOR(15 downto 0));
end entity cal;

architecture bhv of cal is
component alu
  PORT (aluout: out STD_LOGIC_VECTOR(7 downto 0);
        a,b :IN STD_LOGIC_VECTOR(7 downto 0);
        ctrl :in STD_LOGIC_VECTOR(1 downto 0) );
end component;

subtype word is Std_logic_vector(7 downto 0); 
type regarr is array(0 to 7) of word;
signal reg:regarr:=(others=>(others=>'0'));
signal i,j :INTEGER;
signal a,b,aluout:STD_LOGIC_VECTOR(7 downto 0);

begin
  ualu: alu port map (aluout,a,b,IR(14 downto 13));
  --  generate addr bus : out data high-Z when t0='1'
  process(t0)
    begin
    case t0 is
    when '1'=> addr16 <=(others=>'Z');
    when others => addr16 <= reg(7) & IR(7 downto 0);
    end case;
  end process;
  
  -- async , combnational generate reg index
  i<=conv_integer(IR(10 downto 8));
  j<=conv_integer(IR(2 downto 0));
  -- out data high-Z judge by (12-11 = "11") or out -aluout-
  process(IR(14 downto 13),t0,t1,clk)
    begin
      if (IR(12 downto 11) = "11" or (t0='1')) then
        data8<=(others =>'Z');
      elsif clk='0' and clk'event then -- clk falling edge read form alu
        data8<=aluout;
      end if;
  end process;
  -- select and put data to alu 
  process(t1)
    begin
      if t1='1' and t1'event then
        a<=reg(i);
        if IR(15)&IR(12 downto 11)="000" then
          b<=reg(j);
        else
          b<=IR(7 downto 0);
        end if;    
      end if;
  end process;
  -- rewrite register
  process(rreg)
    begin
      if rreg='1' and rreg'event then
        reg(i)<=data8;
      end if;
  end process;
end;