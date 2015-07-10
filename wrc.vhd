LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL ;
entity wrc is
  PORT (clk,rst,read_write: IN STD_LOGIC;
        we,oe: OUT STD_LOGIC);
end entity wrc;
architecture wrcbhv of wrc is
  type state is(off,work,write,read);
  signal pr_state,nx_state:state;
begin
  process(clk,rst)
    begin
      if clk='1' and clk'event then
        pr_state<=nx_state;
      end if;
    end process;
    
  process(read_write,rst,pr_state)

    begin
    case pr_state is
    when off=> 
      oe<='0';we<='0';
      if rst = '0' then
        nx_state<=work;
      end if;
    when work =>
      if rst ='1' then 
        nx_state<=off; 
      elsif read_write = '1' then 
        nx_state<=write;
      else
        nx_state<=read;
      end if;
    when read=>
      if rst ='1' then 
        nx_state<=off; 
      else
        oe<='1';we<='0';
        nx_state<=work;
      end if;
    when write=>
      if rst ='1' then 
        nx_state<=off; 
      else
        oe<='0';we<='1';
        nx_state<=work;
      end if;
    when others=>
      null;
    end case;
  end process;
end;


