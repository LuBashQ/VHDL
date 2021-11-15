----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 18.10.2021 11:45:00
-- Design Name: clock_divider
-- Module Name: clock_divider - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Button pulser
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity counter is
    port (
        clk: in std_logic;
        n_Reset: in std_logic;
        enable: in std_logic;
        ratio: in integer;
        out_s: out std_logic := '0';
        count: out natural
    );
end counter;

architecture Behavioral of counter is
    
    signal counter: natural := 0;
    --signal output: std_logic := '0';
    
begin

    process(clk, n_Reset) is
    begin
        if n_Reset = '0' or enable = '0' then
            counter <= 0;
            out_s <= '0';
        elsif rising_edge(clk) and enable = '1' then
            if counter >= ratio - 1 then
                counter <= 0;
                out_s <= '1';
            else
                out_s <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;
    count <= counter;

end Behavioral;
