--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

entity sreg is
port(
	clk, clrn, serial : in std_logic;
	q : out std_logic_vector(7 downto 0):="00000000"
	);
end sreg ;

architecture main of sreg is
	signal t : std_logic_vector(7 downto 0):="00000000";
begin
	process(clk, clrn)
	begin
		if clrn = '0' then
			t <= "00000000";
		elsif clk = '1' and clk'event then 
			t(7) <= serial;
		  t(6 downto 0) <= t(7 downto 1);
		end if;
                    q <= t;
	end process;
end main;

