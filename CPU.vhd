

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
entity cpu is
  PORT (clk,rst: IN STD_LOGIC;
        cpucbus: OUT STD_LOGIC_VECTOR(1 downto 0);
        cpuabus,ACC :OUT STD_LOGIC_VECTOR(7 downto 0):="00000000";
        cpudbus :INOUT STD_LOGIC_VECTOR(7 downto 0):="00000000");
end entity cpu;
architecture cpubhv of cpu is
  component cmem
      PORT (clk: IN STD_LOGIC;
        cmemabus :IN STD_LOGIC_VECTOR(7 downto 0);
        cmemdbus :OUT STD_LOGIC_VECTOR(7 downto 0) );
  end component;
  signal mar,nacc,PC,IR,uPC,uIR:STD_LOGIC_VECTOR(7 downto 0):="00000000";
  begin  --begin architecture
  ucmem: cmem port map (clk=>clk,cmemabus=>uPC,cmemdbus=>uIR);  
  process (clk,rst)
    begin
      IF rst ='0' then
        uPC <= "00000000";
        ACC <= "00000000";
      elsif clk'EVENT AND clk = '1' then 
        case uIR(7 downto 4) is
        when "0000" => -- pc->abus & (mem->cpu)->cbus
          cpuabus<=PC;
          cpudbus<="ZZZZZZZZ";
        when "0001" => -- dbus->IR 
          IR<=cpudbus;
        when "0010" => -- null
          null;
        when "0011" => -- acc++
          nacc<=nacc+1;
        when "0100" => -- IR->acc
          nacc<=IR;
        when "0101" => -- RAM->abus
          cpuabus<=mar;
        when "0110" => -- dbus->mar
          mar<=cpudbus;
        when "0111" => -- IR->PC
          PC<=IR;
        when "1111" => -- pc++
          PC<=PC+1;
        when others=>
        end case;
        
        case uIR(1 downto 0) is
        when "00"=>
          uPC<=uPC+1;
        when "11"=>
          uPC<="00000000";
        when "10"=>
          uPC<=IR(5 downto 0) & "00" ;
        when others=>
          uPC<=uPC;
        end case;  
     end if;
    end process;
    
    process(uIR(3 downto 2),clk) -- set ctrl word
      begin
        cpucbus<=uIR(3 downto 2) ;
      end process;
    process(nacc,clk)
      begin
        ACC<=nacc;
      end process;
  end;