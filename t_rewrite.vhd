--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity t_rewrite is 
end entity t_rewrite;

architecture bhv of t_rewrite is
component rewrite
  PORT (
    t3,clk:IN STD_LOGIC ; --rst:no beat out;clk generate beat4
    data8:inout STD_LOGIC_VECTOR(7 downto 0); -- jump judge condition
    rwir: IN STD_LOGIC_VECTOR(2 downto 0); -- jump instruction bit,(IR13 - IR11)
    rpc,rreg:OUT STD_LOGIC); -- out rewrite signal
end component;

signal t3,clk:STD_LOGIC ; --rst:no beat out;clk generate beat4
signal data8:STD_LOGIC_VECTOR(7 downto 0); -- jump judge condition
signal rwir: STD_LOGIC_VECTOR(2 downto 0); -- jump instruction bit,(IR13 - IR11)
signal rpc,rreg:STD_LOGIC; -- out rewrite signal

begin
  urewrite: rewrite port map (t3,clk,data8,rwir,rpc,rreg);
  PROCESS
    begin
    t3<='0';clk<='0';data8<="00000000";rwir<="000";wait for 10ns; 
    t3<='1';clk<='1';data8<="00000000";rwir<="000";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="000";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="000";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="100";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000000";rwir<="100";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="100";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="100";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="011";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000000";rwir<="011";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="011";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="011";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="101";wait for 10ns;  
    
    t3<='1';clk<='1';data8<="00000000";rwir<="101";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="101";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="101";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="010";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000000";rwir<="010";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="010";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="010";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="110";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000000";rwir<="110";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="110";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="110";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000011";rwir<="110";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000011";rwir<="110";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000011";rwir<="110";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="110";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="111";wait for 10ns;
    
    t3<='1';clk<='1';data8<="00000000";rwir<="111";wait for 10ns; --begin
    t3<='1';clk<='0';data8<="00000000";rwir<="111";wait for 10ns; 
    t3<='0';clk<='1';data8<="00000000";rwir<="111";wait for 10ns; -- out of t3
    t3<='0';clk<='0';data8<="00000000";rwir<="111";wait for 10ns;
    

    wait;
  end process;
end;







