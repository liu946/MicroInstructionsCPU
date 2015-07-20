--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity reg8 is
port(
	clrn, clk : in std_logic;
	d : in std_logic_vector(7 downto 0);
	q : out std_logic_vector(7 downto 0):="00000000"
	);
end reg8 ;

architecture main of reg8 is
begin
	process(clk, clrn)
	begin
		if clrn = '0' then
			q <= "00000000";
		elsif clk = '1' and clk'event then 
			q <= d;
		end if;
	end process;
end main;

