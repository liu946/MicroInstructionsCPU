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
        pr_state<=nx_state;   -- to next state when clk rising edge
      end if;
    end process;
    
  process(read_write,rst,pr_state)

    begin
    case pr_state is  -- explain state
    when off=> 
      oe<='0';we<='0';  -- off => out = "00"
      if rst = '0' then
        nx_state<=work;
      end if;
    when work =>        -- work  => out = keep
      if rst ='1' then 
        nx_state<=off; -- set next state = off when rst = 1
      elsif read_write = '1' then -- select nextstate by signal read_write
        nx_state<=write; -- nextstate = write when 1
      else
        nx_state<=read;  -- nextstate = write when 0
      end if;
    when read=>
      if rst ='1' then 
        nx_state<=off; -- set next state = off when rst = 1
      else
        oe<='1';we<='0'; -- read  => out = "10"
        nx_state<=work; -- auto recover to work
      end if;
    when write=>
      if rst ='1' then 
        nx_state<=off; -- set next state = off when rst = 1
      else
        oe<='0';we<='1';  -- write => out = "01"
        nx_state<=work; -- auto recover to work 
      end if;
    when others=>
      null;
    end case;
  end process;
end;


