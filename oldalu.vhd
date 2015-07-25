LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_UNSIGNED.ALL ;


 entity alu is
  PORT (cin: IN STD_LOGIC;                                    -- input CY 
        cout: OUT STD_LOGIC;                                  -- output CY
        card: IN STD_LOGIC_VECTOR(4 downto 0);                -- input calculate selector
        a,b :IN STD_LOGIC_VECTOR(7 downto 0);                 -- input calculation numbers
        f :OUT STD_LOGIC_VECTOR(7 downto 0):="00000000");     -- output calculation answer
 end entity alu;

architecture alubhv of alu is

 begin
  
  process(a,b,card,cin)
    VARIABLE ans: STD_LOGIC_VECTOR(8 downto 0);               -- used for save temp answer and outCY(on ans(8)) 
     begin
      case card(3 downto 0) is
                                                              -- arithmetic operation follows
      when "0000"=>ans := ("0"&a)+("0"&b);                    -- a+b 
      when "0001"=>ans := ("0"&a)+("0"&b)+("00000000"&cin);   -- a+b+cy
      when "0010"=>ans := ("0"&a)-("0"&b);                    -- a-b
      when "0011"=>ans := ("0"&a)-("0"&b)-("00000000"&cin);   -- a-b-cy
      when "0100"=>ans := ("0"&b)-("0"&a);                    -- b-a
      when "0101"=>ans := ("0"&b)-("0"&a)-("00000000"&cin);   -- b-a-cy
                                                              -- logical operation follows
      when "0110"=>ans := ("0"&a);                            -- a - by bit and keep original cy
      when "0111"=>ans := ("0"&b);                            -- b - by bit and keep original cy
      when "1000"=>ans := "0"&(NOT(a));                       -- not a - by bit and keep original cy
      when "1001"=>ans := "0"&(NOT(b));                       -- not b - by bit and keep original cy
      when "1010"=>ans := "0"&((a)OR(b));                     -- a or b - by bit and keep original cy
      when "1011"=>ans := "0"&((a)AND(b));                    -- a and b - by bit and keep original cy
      when "1100"=>ans := "0"&((a)XNOR(b));                   -- a xnor b - by bit and keep original cy
      when "1101"=>ans := "0"&((a)XOR(b));                    -- a xor b - by bit and keep original cy
      when "1110"=>ans := "0"&(NOT((a)AND(b)));               -- a nand b - by bit and keep original cy
      when "1111"=>ans := "000000000";                        -- 0 - by bit and keep original cy
      when others=>
       end case;
      
      f <= ans(7 downto 0);                                   -- output answers
      if card(4)='0' then                                     -- use card(4) to tell when cout changed
        cout<=ans(8);                                         -- set cy when card(4)==0 else keep cy
      else
      end if;
    end process;

 end;

