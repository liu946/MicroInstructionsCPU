--
--  Created by liu on 15/7/15.
--  Copyright (c) 2015? liu. All rights reserved.
--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;

ENTITY testserial IS
PORT(
  intn : OUT  std_logic
);
END testserial;
ARCHITECTURE behavior OF testserial IS 
    COMPONENT serial
    PORT(
         serialdata : IN  std_logic;
         clk : IN  std_logic;
         csn : IN  std_logic;
         wrn : IN  std_logic;
         rdn : IN  std_logic;
         addr : IN  std_logic_vector(1 downto 0);
         data : INOUT  std_logic_vector(7 downto 0);
         intn : OUT  std_logic
        );
    END COMPONENT;
   --Inputs
   signal serialdata : std_logic := '0';
   signal clk : std_logic := '0';
   signal csn : std_logic := '0';
   signal wrn : std_logic := '0';
   signal rdn : std_logic := '0';
   signal addr : std_logic_vector(1 downto 0) := (others => '0');
	--BiDirs
   signal data : std_logic_vector(7 downto 0);
 	--Outputs
   -- signal intn : std_logic;
   -- Clock period definitions
   constant clk_period : time := 10 ns;
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: serial PORT MAP (
          serialdata => serialdata,
          clk => clk,
          csn => csn,
          wrn => wrn,
          rdn => rdn,
          addr => addr,
          data => data,
          intn => intn
        );
   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
   -- Stimulus process
   stim_proc: process
   begin		
    -- hold reset state for 100 ns.
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 20 ns;
-- test 1 normal input
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- begin
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 8
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- check
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 2

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for CPU answer int
serialdata<='1';csn <='0';wrn <='1';rdn <='0';addr<="01";wait for 10 ns;-- read int stats
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="01";wait for 10 ns;-- close read stats
serialdata<='1';csn <='0';wrn <='1';rdn <='0';addr<="00";wait for 10 ns;-- read data
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="01";wait for 10 ns;-- clear buff int
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- close clear
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="00";wait for 10 ns;-- clear all

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for next transfer
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;

-- test 2 check failed
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- begin
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 8
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- check (failed)
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 2

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for CPU answer int
serialdata<='1';csn <='0';wrn <='1';rdn <='0';addr<="01";wait for 10 ns;-- read int stats
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="01";wait for 10 ns;-- close read stats
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="10";wait for 10 ns;-- clear perr int
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- close clear
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="00";wait for 10 ns;-- clear all

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for next transfer
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;

-- test 3 overflow
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- begin
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 8
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- check
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- end 2

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for CPU answer int

serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- begin next transfer
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- data 1
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='0';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;

serialdata<='1';csn <='0';wrn <='1';rdn <='0';addr<="01";wait for 10 ns;-- read int stats
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="01";wait for 10 ns;-- close read stats
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="01";wait for 10 ns;-- clear overflow int
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- close clear
serialdata<='1';csn <='0';wrn <='0';rdn <='1';addr<="00";wait for 10 ns;-- clear all

serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;-- wait for next transfer
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;
serialdata<='1';csn <='1';wrn <='1';rdn <='1';addr<="00";wait for 10 ns;


      wait;

   end process;



END;
