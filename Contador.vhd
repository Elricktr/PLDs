library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity EXA1 is
    port
    (    
	RST,CLK :in std_logic;
	S : out signed(3 downto 0)
    );
end EXA1;

architecture cont of EXA2 is
    signal contador : signed(3 downto 0) := to_signed(-5, 4);	
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                contador <= to_signed(-5, 4);
            else
                if contador = to_signed(4, 4) then
                    contador <= to_signed(-5, 4);
                else
                   contador <= contador + 1;
              end if;
            end if;
       end if;
    S <= contador;
	end process;
end cont;
