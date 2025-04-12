entity EXA2 is
    port
    (  
	Pin : in std_logic_vector(3 downto 0);
	BTN : in std_logic;
	RST,CLK :in std_logic;
	A,B,C : out std_logic
    );
end EXA2;

architecture cont of EXA2 is
	signal CA,CB,CC, MC: std_logic_vector(1 downto 0);
	signal SET : BTN;
	type A1 is array (0 to 3) of integer;
	type B1 is array (0 to 3) of integer;
	type C1 is array (0 to 3) of integer;
    signal M1 : A1;
	signal M2 : B1;
	signal M3 : C1;	
begin
	M1 <= (12, 12, 11, 8);
	M2 <= (1, 12, 12, 8);
	M3 <= (1, 1, 2, 8);
	
	
	
    process(clk, Pin,SET, CA)
	begin
		comp: for i in 0 to 3 generate
		
			if Pin(i) = M1(i) AND SET = '1' then
			CA <= CA + '1';
			MC <= MC + '1';
				if rising_edge(clk) then
					if RST = '1' then
						CA <= "00";
						CB <= "00";
						CC <= "00";
						MC <= "00";
					end if ;
				end if ;
			elsif Pin(i) = M2(i) AND SET = '1' then
			CB <= CB + '1';
			MC <= MC + '1';
				if rising_edge(clk) then
					if RST = '1' then
						CA <= "00";
						CB <= "00";
						CC <= "00";
						MC <= "00";
					end if ;
				end if ;
			elsif Pin(i) = M3(i) AND SET = '1' then
			CC <= CC + '1';
			MC <= MC + '1';
				if rising_edge(clk) then
					if RST = '1' then
						CA <= "00";
						CB <= "00";
						CC <= "00";
						MC <= "00";
					end if ;
				end if ;
			else
			MC <= MC + '1';
				if rising_edge(clk) then
					if RST = '1' then
						CA <= "00";
						CB <= "00";
						CC <= "00";
						MC <= "00";
					end if ;
				end if ;
			end if ;
		end generate comp;

		if MC = "11" AND CA = "11" then
			A <= '1';
		elsif MC = "11" AND CB = "11" then
			B <= '1';
		elsif MC = "11" AND CC = "11" then
			C <= '1';
		else
		A <= '1';
		B <= '1';	
		C <= '1';
		end if;
    end process;
