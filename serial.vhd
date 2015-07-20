--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity serial is
port(
	serialdata : in std_logic;
	clk : in std_logic;
	csn, wrn, rdn : in std_logic;
	addr : in std_logic_vector(1 downto 0);
	data : inout std_logic_vector(7 downto 0);
	intn : out std_logic
	);
end serial;

architecture behav of serial is
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
  component ctrl is
  port(
	d9, d11 : in std_logic; -- d9 decoder check ; d11 finish receive data
	sq6, sq7 : in std_logic:='0'; -- from sreg, for generate end event
	rq : in std_logic_vector(7 downto 0); -- data from reg8
	
	clrn : inout std_logic; -- reset & clear all event
  start : out std_logic; -- counter sreg decode4 start
	serial, clk : in std_logic; -- serial input ; clock

	csn, wrn, rdn : in std_logic; -- chip selection ; write int ctrl bit; read ctrl bit
	addr : in std_logic_vector(1 downto 0); -- select write int port
	data : inout std_logic_vector(7 downto 0); -- data or int stats out
	intn : out std_logic:='1' -- int request
	);
  end component;
  
 signal c : std_logic_vector(3 downto 0); -- counter out 0-15
 signal start, t8, t9, t11, clrn : std_logic; -- t8 t9 t11 counter event when 8 9 11
 signal tdata, treg : std_logic_vector(7 downto 0):="00000000";-- tdata latch->ctrl ; treg shiftreg out
 
begin
  ureg8:reg8 port map(clrn=>clrn,clk=>t8,d=>treg,q=>tdata);
  usreg:sreg port map(clk=>clk,clrn=>start,serial=>serialdata,q=>treg);
  ucount4:count4 port map(clk=>clk,clrn=>start,q=>c);
  udecode4:decode4 port map(d=>c,enable=>start,q8=>t8,q9=>t9,q11=>t11);
  uctrl:ctrl port map(d9=>t9,d11=>t11,sq6=>treg(6),sq7=>treg(7),rq=>tdata,clrn=>clrn,
                      start=>start,serial=>serialdata,clk=>clk,csn=>csn,wrn=>wrn,rdn=>rdn,
					             addr=>addr,data=>data,intn=>intn);

end behav;

