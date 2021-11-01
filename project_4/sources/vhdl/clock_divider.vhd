----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 18.10.2021 12:27:40
-- Design Name: clock_divider
-- Module Name: clock_divider - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Clock divider
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity clock_divider is
    generic(
        input_f: natural := 125e6;
        output_f: natural:= 125e3 --Hz
    );
    Port (  sysclk : in std_logic;
         n_Reset: in std_logic;
         output_s: out std_logic;
         enable: in std_logic;
         period_complete: out std_logic
        );
end clock_divider;

architecture Behavioral of clock_divider is


    signal count: natural := 0;
    signal max: natural := input_f/output_f;
    signal output_copy: std_logic := '0';
    signal pc: std_logic := '0';

begin

    process(sysclk, n_Reset) is
    begin
        if n_Reset='0' or enable = '0' then -- reset the state
            count <= 0;
            output_copy <= '0';
            pc <= '0';
        elsif rising_edge(sysclk) and enable = '1' then
            if count >= max/2 - 1 then -- invert the output signal at half period
                count <= 0;
                output_copy <= not output_copy;
                pc <= '1';
            else
                pc <= '0';
                count <= count + 1;
            end if;
        end if; -- signal conditions
    end process;

    output_s <= output_copy;
    period_complete <= pc;

end Behavioral;
