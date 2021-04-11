library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity and2 is
  generic(anddelay : time := 4 ns);
  port(in1  : in std_logic;
       in2  : in std_logic;
       out1 : out std_logic);
end and2;

architecture simple of and2 is

begin
  
  process(in1, in2)
  begin
    if((in1 = '1') and (in2 = '1')) then
      out1 <= '1' after anddelay;
    elsif((in1 = '0') or (in2 = '0')) then
      out1 <= '0' after anddelay;
    --else
      --out1 <= 'X'; -- handle all other input values
    end if;
  end process;
  
end simple;