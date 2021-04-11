library ieee;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;
use IEEE.math_real.all;

entity lab5 is  
	generic(N : integer := 8);  
	port(x,y   : IN std_logic_vector(N-1 downto 0);       
		 c_in  : IN std_logic;       
		 c_out : OUT std_logic;       
		 s     : OUT std_logic_vector(N-1 downto 0));
end lab5;
architecture structural of lab5 is  
	-- component declarations
	COMPONENT and2 IS
		GENERIC(anddelay : time := 4 ns);
		PORT(in1   : IN std_logic;
			 in2   : IN std_logic;
			 out1  : OUT std_logic);
	END COMPONENT;
	
	COMPONENT or2 IS
		GENERIC(ordelay : time := 5 ns);
		PORT(in1   : IN std_logic;
			 in2   : IN std_logic;
			 out1  : OUT std_logic);
	END COMPONENT;
	
	COMPONENT xor2 IS
		GENERIC(xordelay : time := 7 ns);
		PORT(in1   : IN std_logic;
			 in2   : IN std_logic;
			 out1  : OUT std_logic);
	END COMPONENT;
	
	FOR all : and2 USE ENTITY work.and2(simple);	 
	FOR all : or2  USE ENTITY work.or2(simple);  	
	FOR all : xor2  USE ENTITY work.xor2(simple);
	
	

	signal c : std_logic_vector(N-1 downto 0) := (others => '0');
	signal sig_1, sig_2, sig_3, sig_4, sig_5 : std_logic := '0';	
	begin
		GEN_ADDER: for i in 0 to N-1 generate
				
			begin
			FIRST_BIT: if i=0 generate				
				begin
				XOR_1 : xor2 PORT MAP(in1 => x(i), in2 => y(i), out1 => sig_1);
				XOR_2 : xor2 PORT MAP(in1 => sig_1, in2 => c_in, out1 => s(i));
				AND_1 : and2 PORT MAP(in1 => x(i), in2 => c_in, out1 => sig_2);
				AND_2 : and2 PORT MAP(in1 => y(i), in2 => c_in, out1 => sig_3);
				AND_3 : and2 PORT MAP(in1 => x(i), in2 => y(i), out1 => sig_4);
				OR_1  : or2  PORT MAP(in1 => sig_2, in2 => sig_3, out1 => sig_5);
				OR_2  : or2  PORT MAP(in1 => sig_4, in2 => sig_5, out1 => c(i));
			end generate FIRST_BIT;
			REST_BITS: if i>0 generate
				begin
				XOR_3 : xor2 PORT MAP(in1 => x(i), in2 => y(i), out1 => sig_1);
				XOR_4 : xor2 PORT MAP(in1 => sig_1, in2 => c(i-1), out1 => s(i));
				AND_4 : and2 PORT MAP(in1 => x(i), in2 => c(i-1), out1 => sig_2);
				AND_5 : and2 PORT MAP(in1 => y(i), in2 => c(i-1), out1 => sig_3);
				AND_6 : and2 PORT MAP(in1 => x(i), in2 => y(i), out1 => sig_4);
				OR_3  : or2  PORT MAP(in1 => sig_2, in2 => sig_3, out1 => sig_5);
				OR_4  : or2  PORT MAP(in1 => sig_4, in2 => sig_5, out1 => c(i));
			end generate REST_BITS;
		end generate GEN_ADDER;
	c_out <= c(N-1);

 end structural;
 
 
 
 
 