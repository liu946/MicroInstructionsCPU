--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity geti is
    PORT (
        t0,clk,rpc:IN STD_LOGIC ; --get instruction time, clock,rewrite signal
        IR:OUT STD_LOGIC_VECTOR(15 downto 0):=(others=>'0'); -- out ir signal
        data16 :INOUT STD_LOGIC_VECTOR(15 downto 0); -- 16 bit data bus
        addr16 :inout STD_LOGIC_VECTOR(15 downto 0):=(others=>'Z')); -- 16 bit addr bus for get instruction OR get new pc
end entity geti;

architecture bhv of geti is
  signal PC,NEWPC:STD_LOGIC_VECTOR(15 downto 0):=(others=>'0');
  begin
  data16<=(others=>'Z');
  -- out intruction address
  process(t0)
  begin
    if t0='1' and t0'event then
      addr16<=PC;
    elsif t0'event then
      addr16<=(others=>'Z');
    end if;
  end process;  
  -- clk falling edge: in ir ; pc++
  process(clk,rpc)
    begin
      if clk'event and clk='0' and t0='1' then
        IR<=data16;
        PC<=PC+1;
      end if;
      -- new pc
      if rpc'event and rpc='1' then
        PC<=PC+addr16;
      end if;
  end process;

end;