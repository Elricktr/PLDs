library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--integrantes
--Trejo Rios Erick
--Zamora Ramirez Ivan
--Flores Domingez Eduardo


entity CI7LS181 is
    port
    (
        A, B 		: in std_logic_vector(3 downto 0);  -- Operandos de entrada
        OpCode 		: in std_logic_vector(3 downto 0);  -- Código de operación
        M 			: in std_logic;                     -- Selector: Lógico / Aritmético
        Cin  		: in std_logic;
		C4 			: out std_logic;                    -- Acarreo de salida
		G 			: out std_logic ;
		P 			: out std_logic ;
		AB 			: out std_logic ;  
		F 			: out std_logic_vector(3 downto 0)
		  
		--A=B, es una salida de colector abierto e indica cuándo las cuatro salidas está a nivel ALTO. 
		--Si se selecciona la operación aritmética de la resta es salida se activará cuando ambos operandos sean iguales.   
		
		--G, salida de generación de acarreo. En operación aritmética de la suma, 
		--esta salida indica que la salida F es mayor o igual a 16, y en la resta F es menor que cero  
		
		--P, salida de propagación de acarreo. En la operación aritmética de la suma, 
		--esta salida indica que F es mayor o igual a 15 y en la resta que F es menor que cero.. 
    );
end CI7LS181;

architecture ALU of CI7LS181 is
  signal opcodeM 	: std_logic_vector (5 downto 0);
  signal S      	: std_logic_vector (3 downto 0);
  signal G0 		: std_logic;
  signal G1 		: std_logic;
  signal G2 		: std_logic;
  signal G3 		: std_logic;
  signal P0 		: std_logic;
  signal P1 		: std_logic;
  signal P2 		: std_logic;
  signal P3 		: std_logic;
  signal C0 		: std_logic;
  signal C1 		: std_logic;
  signal C2 		: std_logic;
  signal C3 		: std_logic;
  
 
begin
	
	opcodeM <= OpCode & M & Cin;
	--OUTpin : process(A,B)
	--begin
	G0 <= A(0) AND B(0); --generación 0
	P0 <= A(0)XOR B(0); --propagación 0
	C0 <= G0 OR (B(0) AND Cin); --look ahead carry 0
	 
	G1 <= A(1) AND B(1); --generación 1 
	P1 <= A(1)XOR B(1); --propagación 1
	C1 <= G1 OR (B(1) AND C0); --look ahead carry 1
	
	G2 <= A(2) AND B(2); --generación 2 
	P2 <= A(2)XOR B(2); --propagación 2
	C2 <= G2 OR (B(2) AND C1); --look ahead carry 2
	
	G3 <= A(3) AND B(3); --generación 3
	P3 <= A(3)XOR B(3); --propagación 3
	C4 <= G3 OR (B(3) AND C2); --look ahead carry 
	
	G <= G3 OR (G2 AND P3) OR (G1 AND P3 AND P2) OR (G0 AND P3 AND P2 AND P1 AND P0); --generación
	P <= P3 AND P2 AND P1 AND P0; --propagación
	
	
	
	
	
	
	OUTpin : process(A,B)
	begin
			if A=B then
				AB <= '1';
			else
				AB <= '0';
			end if;
			
	end process;		
		 ALU : process (A,B,S,OpCodeM)
			begin 
				case OpCodeM is 
							when "000000" =>							 
								S <= A;
							when "000100" =>
								S<= std_logic_vector  (unsigned(A) OR unsigned(B)); 	
							when "001000" =>
								S <= std_logic_vector ( unsigned(A) OR NOT unsigned(B)) ;
							when "001100" =>
								S <= "1111";
							when "010000" =>
								S <= std_logic_vector ( (unsigned(A) + (unsigned(A) AND NOT unsigned(B)))) ;
							when "010100" =>
								S <= std_logic_vector ( ((unsigned(A) OR unsigned(B)) + (unsigned(A) AND NOT unsigned(B))));	
							when "011000" =>
								S <= std_logic_vector ( unsigned(A) - unsigned(B) -1);
							when "100000" =>
								S <= std_logic_vector ( unsigned(A) + (unsigned(A) AND unsigned(B)));	
							when "100100" =>
								S <= std_logic_vector ( unsigned(A) + unsigned(B));		
							when "101000" =>
								S <= std_logic_vector ( (unsigned(A) OR NOT unsigned(B)) + (unsigned(A) AND unsigned(B)));								
							when "101100" =>
								S <= std_logic_vector ( (unsigned(A) AND unsigned(B)) - 1);	
							when "110000" =>
								S <= std_logic_vector ( unsigned(A) + unsigned(A));	
							when "110100" =>
								S <= std_logic_vector ( (unsigned(A) OR unsigned(B)) + unsigned(A));	
							when "111000" =>
								S <= std_logic_vector ( (unsigned(A) OR NOT unsigned(B)) + unsigned(A));	
							when "111100" =>
								S <= std_logic_vector ( unsigned(A) - 1);
							
							
							
							
							when "000001" =>
								S <= std_logic_vector ( (unsigned(A)+1));
							when "000101" =>
								S <= std_logic_vector ( ((unsigned(A) OR unsigned(B))+1));	
							when "001001" =>
								S <= std_logic_vector ( (unsigned(A) OR NOT unsigned(B))+1);
							when "001101" =>
								S <= "0000";
							when "010001" =>
								S <= std_logic_vector ( unsigned(A)+(unsigned(A) OR NOT unsigned(B)) + 1);	
							when "010101" =>
								S <= std_logic_vector ( (unsigned(A) OR unsigned(B)) + (unsigned(A) OR NOT unsigned(B)) + 1);	
							when "011001" =>
								S <= std_logic_vector ( unsigned(A) - unsigned(B));
							when "011101" =>
								S <= std_logic_vector ( unsigned(A) OR NOT unsigned(B));
							when "100001" =>
								S <= std_logic_vector ( unsigned(A) + (unsigned(A) AND unsigned(B))+1);
							when "100101" =>
								S <= std_logic_vector ( unsigned(A) + unsigned(B) + 1);
							when "101001" =>
								S <= std_logic_vector ( (unsigned(A) OR NOT unsigned(B)) + (unsigned(A) AND unsigned(B)) + 1);
							when "101101" =>
								S <= std_logic_vector ( unsigned(A) OR unsigned(B));
							when "110001" =>
								S <= std_logic_vector ( unsigned(A) + unsigned(A) +1);	
							when "110101" =>
								S <= std_logic_vector ( (unsigned(A) AND unsigned(B)) + unsigned(A) + 1);	
							when "111001" =>
								S <= std_logic_vector ( (unsigned(A) AND NOT unsigned(B)) + unsigned(A) + 1);	
							when "111101" =>
								S <= A;
								
								
							
							when "000010" =>
								S <= std_logic_vector ( NOT unsigned(A));							
							when "000110" =>
								S <= std_logic_vector ( NOT (unsigned(A) OR unsigned(B)));																			
							when "001010" =>
								S <= std_logic_vector ( (NOT unsigned(A)) AND unsigned(B));																					
							when "001110" =>
								S <= "0000";																						
							when "010010" =>
								S <= std_logic_vector ( NOT(unsigned(A) AND unsigned(B)));														
							when "010110" =>
								S <= std_logic_vector ( NOT unsigned(B));																						
							when "011010" =>
								S <= std_logic_vector ( unsigned(A) XOR unsigned(B));															
							when "011110" =>
								S <= std_logic_vector ( unsigned(A) AND NOT unsigned(B));														
							when "100010" =>
								S <= std_logic_vector ( NOT unsigned(A) OR unsigned(B));																							
							when "100110" =>
								S <= std_logic_vector ( NOT(unsigned(A) XOR unsigned(B)));														
							when "101010" =>
								S <= B;																					
							when "101110" =>
								S <= std_logic_vector ( unsigned(A) AND unsigned(B));														
							when "110010" =>
								S <=  "0001";																			
							when "110110" =>
								S <= std_logic_vector ( unsigned(A) OR NOT unsigned(B));																								
							when "111010" =>
								S <= std_logic_vector ( unsigned(A) OR unsigned(B));														
							when "111110" =>
								S <= std_logic_vector ( unsigned(A));
							when others =>
									S <= "0000";								
			end case;
			F <= S;
		end process;
		
end ALU;							
											
--O[3..0] M Cin | Q
--~~~~~~~~~~~~~~~~~                  
-- 0000   0  0  | -                  
-- 0000   0  1  | -                  
-- 0000   1  0  | -
-- 0001   0  0  | -
-- 0001   0  1  | -
-- 0001   1  0  | -
-- 0010   0  0  | -
-- 0010   0  1  | -
-- 0010   1  0  | -
-- 0011   0  0  | -
-- 0011   0  1  | -
-- 0011   1  0  | -
-- 0100   0  0  | -
-- 0100   0  1  | -
-- 0100   1  0  | -
-- 0101   0  0  | -
-- 0101   0  1  | -
-- 0101   1  0  | -
-- 0110   0  0  | -
-- 0110   0  1  | -
-- 0110   1  0  | -
-- 0111   0  0  | -
-- 0111   0  1  | -
-- 0111   1  0  | -
-- 1000   0  0  | -
-- 1000   0  1  | -
-- 1000   1  0  | -
-- 1001   0  0  | -
-- 1001   0  1  | -
-- 1001   1  0  | -
-- 1010   0  0  | -
-- 1010   0  1  | -
-- 1010   1  0  | -
-- 1011   0  0  | -
-- 1011   0  1  | -
-- 1011   1  0  | -
-- 1100   0  0  | -
-- 1100   0  1  | -
-- 1100   1  0  | -
-- 1101   0  0  | -
-- 1101   0  1  | -
-- 1101   1  0  | -
-- 1110   0  0  | -
-- 1110   0  1  | -
-- 1110   1  0  | -
-- 1111   0  0  | -
-- 1111   0  1  | -
-- 1111   1  0  | 
