--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
USE IEEE.STD_LOGIC_ARITH.ALL;
entity count4 is
port(
	clk : in std_logic;
	clrn : in std_logic;
	q : out std_logic_vector(3 downto 0)
	);
end count4 ;

architecture main of count4 is
begin
	process( clk, clrn )
	variable num : integer;
	begin
		if clrn = '0' then
			q <= "0000";
			num := 0;
		elsif clk = '0' and clk'event then
			num := num + 1;
			q <= conv_std_logic_vector(num, 4);
		end if;
	end process;
end main;

