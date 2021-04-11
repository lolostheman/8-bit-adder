library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity or2 is
  generic(ordelay : time := 5 ns);
  port(in1  : in std_logic;
       in2  : in std_logic;
       out1 : out std_logic);
end or2;

architecture simple of or2 is

begin
  
  process(in1, in2)
  begin
  
    if((in1 = '0') and (in2 = '0')) then
      out1 <= '0' after ordelay;
    elsif((in1 = '1') or (in2 = '1')) then
      out1 <= '1' after ordelay;
    --else
      --out1 <= 'X'; -- handle all other input values
    end if;
  end process;
  
end simple;