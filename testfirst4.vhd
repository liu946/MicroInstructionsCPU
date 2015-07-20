--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity testfirst4 is
end testfirst4;

architecture behav of testfirst4 is
  component reg8 is
  port(
  	clrn, clk : in std_logic; -- clk is not system clock ,is for save 8 data bits (when q8)
  	d : in std_logic_vector(7 downto 0); -- int 8bit
  	q : out std_logic_vector(7 downto 0) -- out 8bit
  	);
  end component ;
  component sreg is
  port(
	clk, clrn, serial : in std_logic;
	q : out std_logic_vector(7 downto 0) -- out 8bit
	);
  end component;
  component count4 is
  port(
	clk : in std_logic; -- clock
	clrn : in std_logic; -- clear
	q : out std_logic_vector(3 downto 0) -- counter output
	);
	end component;
	component decode4 is
  port(
	d : in std_logic_vector(3 downto 0); -- counter output
	enable : in std_logic; 
	q8, q9, q11 : out std_logic -- when count to 8 9 11
	);
  end component;
 signal c : std_logic_vector(3 downto 0); -- counter out 0-15
 signal clk, t8, t9, t11, clrn,serialdata : std_logic:='0'; -- t8 t9 t11 counter event when 8 9 11
 signal reg8in,reg8out, sregout : std_logic_vector(7 downto 0):="00000000";-- tdata latch->ctrl ; treg shiftreg out
begin
  ureg8:reg8 port map(clrn=>clrn,clk=>clk,d=>reg8in,q=>reg8out);
  usreg:sreg port map(clk=>clk,clrn=>clrn,serial=>serialdata,q=>sregout);
  ucount4:count4 port map(clk=>clk,clrn=>clrn,q=>c);
  udecode4:decode4 port map(d=>c,enable=>clrn,q8=>t8,q9=>t9,q11=>t11);
  clk_process :process
   begin
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
   end process;
  process
    begin
    clrn<='0';wait for 20 ns;
    clrn<='1';wait for 20 ns;
    reg8in<="01101010";wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    serialdata<='0';wait for 20 ns;
    serialdata<='1';wait for 20 ns;
    clrn<='0';
    wait;
  end process;
end;



