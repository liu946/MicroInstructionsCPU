--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity t_clk4 is 
end entity t_clk4;

architecture bhv of t_clk4 is
component clk4
  PORT (
    rst,clk:IN STD_LOGIC ; --rst:no beat out;clk generate beat4
    t:OUT STD_LOGIC_VECTOR(3 downto 0):=(others=>'0')); -- out beat
end component;

signal rst,clk:STD_LOGIC ; 
signal t:STD_LOGIC_VECTOR(3 downto 0);

begin
  uclk4: clk4 port map (rst,clk,t);
  PROCESS
    begin
    rst<='1';clk<='0';wait for 10ns; 
    rst<='1';clk<='1';wait for 10ns; 
    rst<='1';clk<='0';wait for 10ns; 
    rst<='1';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='0';clk<='0';wait for 10ns; 
    rst<='0';clk<='1';wait for 10ns; 
    rst<='1';clk<='0';wait for 10ns; 
    rst<='1';clk<='1';wait for 10ns; 
    rst<='1';clk<='0';wait for 10ns; 
    rst<='1';clk<='1';wait for 10ns; 
    
    wait;
  end process;
end;





