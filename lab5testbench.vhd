library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity lab5testbench is
end lab5testbench;

architecture behavior of lab5testbench is

  -- define the maximum delay for the DUT
  constant MAX_DELAY : time := 20 ns;
  constant BIT_WIDTH : integer := 8;
  constant NO_VECTORS : integer := 6;

  -- declare a constant to hold an array of input values
  type input_value_array is array (0 to 5) of std_logic_vector(7 downto 0);
  type output_value_array is array (0 to 5) of std_logic_vector(7 downto 0);
  constant x_sig_values : input_value_array := ("00000000",
                                                "01101011",
                                                "11101110",
                                                "00101001",
                                                "11111111",
                                                "11111111");
  constant y_sig_values : input_value_array := ("00000000",
                                                "10010100",
                                                "00001000",
                                                "00100101",
                                                "00000001",
                                                "11111111");
  constant c_in_sig_values : std_logic_vector(0 to 5) := ('0','1','0','1','1','1');
  constant s_sig_values : output_value_array := ("00000000",
                                                 "00000000",
                                                 "11110110",
                                                 "01001111",
                                                 "00000001",
                                                 "11111111");
  constant c_out_sig_values : std_logic_vector(0 to 5) := ('0','1','0','0','1', '1');

  -- define signals that connect to DUT
  signal x_sig, y_sig, s_sig  : std_logic_vector(7 downto 0) := (others => '0');
  signal c_in_sig, c_out_sig : std_logic := '0';
  
  begin
 
    -- this is the process that will generate the inputs
    stimulus : process
      begin
       for i in 0 to 5 loop
          x_sig <= x_sig_values(i);
          y_sig <= y_sig_values(i);
          c_in_sig <= c_in_sig_values(i);
          wait for MAX_DELAY;
        end loop;
        wait; -- stop the process to avoid an infinite loop
    end process stimulus;

    -- this is the component instantiation for the
    -- DUT - the device we are testing
    DUT : entity work.lab5(structural)
      generic map(N => BIT_WIDTH)
      port map(x => x_sig, y => y_sig, c_in => c_in_sig,
               c_out => c_out_sig, s => s_sig);

    
    monitor : process      
      begin      
        wait;
    end process monitor;
    
end behavior;

