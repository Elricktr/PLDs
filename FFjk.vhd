library ieee;
use ieee.std_logic_1164.all;


entity EXA2 is
    port
    (    
	J, K, clk : in std_logic;
    Q, Qn : buffer std_logic
    );
end EXA2;

architecture FF of EXA2 is
begin
    process(clk, K, J)
    begin
        if rising_edge(clk) then
            if J = '0' and K = '0' then  
                Q <= Q;
                Qn <= Qn;
            elsif J = '0' and K = '1' then
                Q <= '0';
                Qn <= '1';
            elsif  J = '1' and K = '0' then
                Q <= '1';
                Qn <= '0';
            elsif J = '1' and K = '1' then
                Q <= Qn;
                Qn <= Q;
            end if;
        end if;
    end process;
end FF;
