--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity rewrite is
  PORT (
    t3,clk:IN STD_LOGIC ; --rst:no beat out;clk generate beat4
    data8:inout STD_LOGIC_VECTOR(7 downto 0); -- jump judge condition
    rwir: IN STD_LOGIC_VECTOR(2 downto 0); -- jump instruction bit,(IR13 - IR11)
    rpc,rreg:OUT STD_LOGIC:='0'); -- out rewrite signal
end entity;
architecture bhv of rewrite is
begin
  data8<=(others=>'Z');
  -- rewrite reg signal
  process(t3,clk)
    
    begin
    if t3'event and t3='1' and (rwir(0) XOR rwir(1))='0' then
        rreg<='1';
    elsif clk'event and clk='0' then
        rreg<='0';
    end if;
  end process;
  -- rewrite reg signal
  process(t3,clk)
    begin
    if t3'event and t3='1' and (rwir(1 downto 0)="10") then
      if (rwir(2)='0' or data8="00000000") then
        rpc<='1';
      end if;
    elsif clk'event and clk='0' then
        rpc<='0';
    end if;
  end process;
end;