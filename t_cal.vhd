--
--  Created by liu on 15/7/24.
--  Copyright (c) 2015 liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity t_cal is 
end entity t_cal;

architecture bhv of t_cal is
component cal
    PORT (
        t0,t1,clk,rreg:IN STD_LOGIC ; 
        IR:IN STD_LOGIC_VECTOR(15 downto 0); 
        data8 :INOUT STD_LOGIC_VECTOR(7 downto 0); 
        addr16 :inout STD_LOGIC_VECTOR(15 downto 0));
end component;

signal t0,t1,clk,rreg:STD_LOGIC ; 
signal IR:STD_LOGIC_VECTOR(15 downto 0);
signal data8 :STD_LOGIC_VECTOR(7 downto 0);
signal addr16 :STD_LOGIC_VECTOR(15 downto 0);

begin
  ucal: cal port map (t0,t1,clk,rreg,IR,data8,addr16);
  PROCESS
    begin
    data8<="ZZZZZZZZ";
    -- excute MVI  
    IR<=B"11000_111_00000_001";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns; -- mvi r7 1
    IR<=B"11000_111_00000_001";clk<='1';t0<='1';t1<='0';rreg<='0';wait for 10ns; -- t0
    IR<=B"11000_111_00000_001";clk<='0';t0<='1';t1<='0';rreg<='0';wait for 10ns;
    IR<=B"11000_111_00000_001";clk<='1';t0<='0';t1<='1';rreg<='0';wait for 10ns; -- t1
    IR<=B"11000_111_00000_001";clk<='0';t0<='0';t1<='1';rreg<='0';wait for 10ns;
    IR<=B"11000_111_00000_001";clk<='1';t0<='0';t1<='0';rreg<='0';wait for 10ns; -- t2
    IR<=B"11000_111_00000_001";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;    
    IR<=B"11000_111_00000_001";clk<='1';t0<='0';t1<='0';rreg<='1';wait for 10ns; -- t3
    IR<=B"11000_111_00000_001";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;   
    -- excute LDA IN
    -- lda|in r1 3
    IR<=B"11000_111_00000_001";clk<='1';t0<='1';t1<='0';rreg<='0';wait for 10ns; -- t0
    IR<=B"11011_001_00000_011";clk<='0';t0<='1';t1<='0';rreg<='0';wait for 10ns; -- get new instruction
    IR<=B"11011_001_00000_011";clk<='1';t0<='0';t1<='1';rreg<='0';wait for 10ns; -- t1
    IR<=B"11011_001_00000_011";clk<='0';t0<='0';t1<='1';rreg<='0';wait for 10ns;
    IR<=B"11011_001_00000_011";clk<='1';t0<='0';t1<='0';rreg<='0';data8<="10010101";wait for 10ns; -- t2 
    IR<=B"11011_001_00000_011";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;    
    IR<=B"11011_001_00000_011";clk<='1';t0<='0';t1<='0';rreg<='1';data8<="10010101";wait for 10ns; -- t3
    IR<=B"11011_001_00000_011";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;   
    data8<="ZZZZZZZZ";
    -- add
    -- add r0 r1
    IR<=B"11011_001_00000_011";clk<='1';t0<='1';t1<='0';rreg<='0';wait for 10ns; -- t0
    IR<=B"00000_111_00000_001";clk<='0';t0<='1';t1<='0';rreg<='0';wait for 10ns; -- get new instruction
    IR<=B"00000_111_00000_001";clk<='1';t0<='0';t1<='1';rreg<='0';wait for 10ns; -- t1
    IR<=B"00000_111_00000_001";clk<='0';t0<='0';t1<='1';rreg<='0';wait for 10ns;
    IR<=B"00000_111_00000_001";clk<='1';t0<='0';t1<='0';rreg<='0';wait for 10ns; -- t2 
    IR<=B"00000_111_00000_001";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;    
    IR<=B"00000_111_00000_001";clk<='1';t0<='0';t1<='0';rreg<='1';wait for 10ns; -- t3
    IR<=B"00000_111_00000_001";clk<='0';t0<='0';t1<='0';rreg<='0';wait for 10ns;   
    data8<="ZZZZZZZZ";
    wait;
  end process;
end;

