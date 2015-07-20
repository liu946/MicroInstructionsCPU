--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity ctrl is
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
end ctrl;

architecture main of ctrl is

  signal	clrint1, clrint2, clrint3, rbuff, rint : std_logic:='1';
	signal	startm, odd, endd: std_logic:='0';
	signal perr, oerr, buff: std_logic:='0';
begin 

  -- begin
  process(clrn, clk)
	begin
		if clrn = '0' then
			startm <= '0';
		elsif clk = '1' and clk'event then
			startm <= not serial;
		end if;
	end process;
  -- begin pull data
	process(clrn, startm)
	begin
		if clrn = '0' then
			start <= '0';
		elsif startm = '1' and startm'event then
			start <= '1';
		end if;
	end process;
  -- check
  process(sq7, rq)
	begin
	     odd <= sq7 xor rq(0) xor rq(1)
                   xor rq(2) xor rq(3) xor rq(4)
                   xor rq(5) xor rq(6) xor rq(7);
	end process;
  -- end
	process(sq6, sq7)
	begin
		endd <= sq6 and sq7;
	end process;
	
	-- interrupt
  process(clrint2, d9)
	begin
		if clrint2 = '0' then
			perr <= '0';
		elsif d9 = '1' and d9'event then
			perr <= odd;  
		end if;
	end process;

	process(clrint1, d11)
	begin
		if clrint1 = '0' then
			buff <= '0';
		elsif d11 = '1' and d11'event then
			buff <= endd;
		end if;
	end process;
	
  process(clrint3, startm)
	begin
		if clrint3 = '0' then
			oerr <= '0';
		elsif startm = '1' and startm'event then
			oerr <= buff;
		end if;
	end process;

	process(perr, oerr, buff)
	begin
		intn <= not (perr or oerr or buff);
	end process;
	
  -- control
  process(csn, wrn)
	begin
		if csn = '0' and wrn = '0' then
			case addr is
				when "00" => clrn <= '0';
				when "01" => clrint1 <= '0';
				when "10" => clrint2 <= '0';
				when "11" => clrint3 <= '0';
				when others => null;
			end case;
    else
      clrn <= '1';
		  clrint1 <= '1';
		  clrint2 <= '1';
		  clrint3 <= '1';
		end if;
	end process;
  process(csn, rdn)
	begin
		if csn = '0' and rdn = '0' then
			case addr is
				when "00" => rbuff <= '0';
				when "01" => rint <= '0';
				when others => null;
			end case;
    else
      rbuff <= '1';
	    rint <= '1';     
		end if;
	end process;
	
  -- data channel
  process(rbuff, rint, perr, oerr, buff, rq)
	begin
		if rbuff = '0' and csn='0' then
			data <= rq;
		elsif rint = '0' and csn='0' then
			data(0) <= buff;
			data(1) <= perr;
			data(2) <= oerr;
			data(7 downto 3) <= "00000";
		else
			data <= "ZZZZZZZZ";
		end if;
	end process;
end;