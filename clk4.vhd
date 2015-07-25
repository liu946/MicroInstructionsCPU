--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity clk4 is
  PORT (
    rst,clk:IN STD_LOGIC ; --rst:no beat out;clk generate beat4
    t:OUT STD_LOGIC_VECTOR(3 downto 0):=(others=>'0')); -- out beat
end entity;
architecture bhv of clk4 is
signal ttemp:STD_LOGIC_VECTOR(3 downto 0):=(others=>'0');
begin
  process(clk,rst)
    begin
    if rst='1' then
      ttemp<=(others=>'0');
    elsif clk'event and clk='1' then
      if ttemp="0000" then
        ttemp<="1000";
      else
        ttemp(2 downto 0)<=ttemp(3 downto 1);
        ttemp(3)<=ttemp(0);
      end if;
    end if;
  end process;
  process(ttemp)
    begin
      t<=ttemp;
  end process;
end;