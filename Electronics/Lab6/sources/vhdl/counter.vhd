library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity counter is
    generic (
        max: natural range 0 to 15 := 15 -- max 8 bits because Pmod ports have only 8 outputs
    );
    port (
        clk: in std_logic;
        out_s: out std_logic_vector(7 downto 0)
    );
end counter;

architecture Behavioral of counter is

    signal counter: natural range 0 to 15 := 0;

begin

    process(clk) is
    begin
        if rising_edge(clk) then
            if counter >= max then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    out_s <= std_logic_vector(to_unsigned(counter, out_s'length));

end Behavioral;
