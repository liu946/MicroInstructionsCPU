--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity t_geti is 
end entity t_geti;

architecture bhv of t_geti is
component geti
    PORT (
        t0,clk,rpc:IN STD_LOGIC ; --get instruction time, clock,rewrite signal
        IR:OUT STD_LOGIC_VECTOR(15 downto 0); -- out ir signal
        data16 :INOUT STD_LOGIC_VECTOR(15 downto 0); -- 16 bit data bus
        addr16 :inout STD_LOGIC_VECTOR(15 downto 0)); -- 16 bit addr bus for get instruction OR get new pc
end component;

signal t0,clk,rpc:STD_LOGIC ; 
signal IR:STD_LOGIC_VECTOR(15 downto 0);
signal data16 :STD_LOGIC_VECTOR(15 downto 0);
signal addr16 :STD_LOGIC_VECTOR(15 downto 0);

begin
  ugeti: geti port map (t0,clk,rpc,IR,data16,addr16);
  PROCESS
    begin
    addr16<=(others => 'Z');
    data16<=(others => 'Z');
    clk<='0';t0<='0';rpc<='0';wait for 10ns; --t0
    clk<='1';t0<='1';rpc<='0';data16<="1111100100000001";wait for 10ns; 
    clk<='0';t0<='1';rpc<='0';wait for 10ns; 
    data16<=(others => 'Z');
    clk<='1';t0<='0';rpc<='0';wait for 10ns; --t1
    clk<='0';t0<='0';rpc<='0';wait for 10ns; 
    clk<='1';t0<='0';rpc<='0';wait for 10ns; --t2
    clk<='0';t0<='0';rpc<='0';wait for 10ns;
    clk<='1';t0<='0';rpc<='0';wait for 10ns; --t3
    clk<='0';t0<='0';rpc<='0';wait for 10ns; 
    -- reset PC
    data16<=(others => 'Z');
    clk<='0';t0<='0';rpc<='0';wait for 10ns; --t0
    clk<='1';t0<='1';rpc<='0';data16<="1101000100000011";wait for 10ns; 
    clk<='0';t0<='1';rpc<='0';wait for 10ns; 
    data16<=(others => 'Z');
    addr16<=B"10100010_00000011";
    clk<='1';t0<='0';rpc<='0';wait for 10ns; --t1
    clk<='0';t0<='0';rpc<='0';wait for 10ns; 
    clk<='1';t0<='0';rpc<='0';wait for 10ns; --t2
    clk<='0';t0<='0';rpc<='0';wait for 10ns;
    clk<='1';t0<='0';rpc<='1';wait for 10ns; --t3
    clk<='0';t0<='0';rpc<='0';wait for 10ns; 
    addr16<=(others => 'Z');
    wait;
  end process;
end;



