

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
entity cpu is
  PORT (clk,rst: IN STD_LOGIC;
        cpucbus: OUT STD_LOGIC_VECTOR(1 downto 0);
        cpuabus :OUT STD_LOGIC_VECTOR(7 downto 0):="00000000";
        cpudbus :INOUT STD_LOGIC_VECTOR(7 downto 0):="00000000");
end entity cpu;
architecture cpubhv of cpu is
  component cmem
      PORT (clk: IN STD_LOGIC;
        cmemabus :IN STD_LOGIC_VECTOR(9 downto 0);
        cmemdbus :OUT STD_LOGIC_VECTOR(7 downto 0) );
  end component;
  type REGRAM is array(0 to 4) of STD_LOGIC_VECTOR(7 downto 0);
  signal reg:REGRAM;
  signal regpoint :INTEGER;
  signal mar,nacc,PC,IR,uIR:STD_LOGIC_VECTOR(7 downto 0):="00000000";
  signal uPC:STD_LOGIC_VECTOR(9 downto 0):="0000000000";
  signal zy:STD_LOGIC;                                        --zero flag
  begin  --begin architecture
  ucmem: cmem port map (clk=>clk,cmemabus=>uPC,cmemdbus=>uIR);  
  regpoint <=conv_integer(uIR(3 downto 2));
  process (nacc)
    begin
      if nacc = "00000000" then
        zy<='1';
      else
        zy<='0';
      end if;
  end process;
  process (clk,rst)
    
    begin
      IF rst ='0' then
        uPC <= "0000000000";
        nacc <= "00000000";
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
        when "1000" => -- acc->dbus
          cpudbus<=nacc;
        when "1001" => -- acc->reg
          reg(regpoint)<=nacc;
        when "1010" => -- reg->acc
          nacc<=reg(regpoint);
        when "1011" => -- reg0-reg1->acc
          nacc<=reg(0)-reg(1);
        when "1100" => -- reg+acc->reg
          reg(regpoint)<=reg(regpoint)+nacc;
        when "1111" => -- pc++
          PC<=PC+1;
        when others=>
        end case;
        
        case uIR(1 downto 0) is
        when "00"=>
          uPC<=uPC+1;
        when "11"=>
          uPC<="0000000000";
        when "10"=>
          uPC<=IR & "00" ;
        when "01"=> -- condition jump
          if zy ='1' then
            uPC<=uPC+4;
          else
            uPC<=uPC+1;
          end if;
        when others=>
        end case;  
     end if;
    end process;
    
    process(uIR(3 downto 2),clk) -- set ctrl word
      begin
        cpucbus<=uIR(3 downto 2) ;
      end process;
  end;