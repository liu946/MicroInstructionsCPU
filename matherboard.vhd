
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity motherboard is 
end entity motherboard;

architecture mbbhv of motherboard is
  component CPU is
      PORT (clk,rst: IN STD_LOGIC;
        cpucbus: OUT STD_LOGIC_VECTOR(1 downto 0);
        cpuabus,ACC :OUT STD_LOGIC_VECTOR(7 downto 0);
        cpudbus :INOUT STD_LOGIC_VECTOR(7 downto 0) );
  end component;
  component mem is
      PORT (clk: IN STD_LOGIC;
        memcbus: IN STD_LOGIC_VECTOR(1 downto 0);
        memabus :IN STD_LOGIC_VECTOR(7 downto 0);
        memdbus :INOUT STD_LOGIC_VECTOR(7 downto 0) ); 
  end component; 
  component IO is 
      PORT (clk: IN STD_LOGIC;
        iocbus: IN STD_LOGIC_VECTOR(1 downto 0);
        iodbus :INOUT STD_LOGIC_VECTOR(7 downto 0) );
  end component; 
  signal acc,abus,dbus:STD_LOGIC_VECTOR(7 downto 0):="00000000";
  signal cbus:STD_LOGIC_VECTOR(1 downto 0):="00";
  signal clk,rst:STD_LOGIC:='0';
  begin --begin architecture
    ucpu: CPU port map (clk=>clk,rst=>rst,cpucbus=>cbus,cpuabus=>abus,cpudbus=>dbus,ACC=>acc);
    umem: mem port map (clk=>clk,memcbus=>cbus,memabus=>abus,memdbus=>dbus);
    uio: IO port map (clk=>clk,iocbus=>cbus,iodbus=>dbus);
  process
    begin
    if rst = '0' then
      wait for 20 ns; 
      rst <= '1' ;
    end if;
    if clk = '0' then
      wait for 10 ns;
      clk <= '1'; 
    else 
      wait for 10ns;
      clk <= '0';
    end if;
  end process;
end;