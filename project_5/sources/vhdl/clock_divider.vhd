----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 18.10.2021 12:27:40
-- Design Name: clock_divider
-- Module Name: clock_divider - Behavioral
-- Project Name: LAB5
-- Target Devices: PYNQ-Z2
-- Description: Clock divider
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity clock_divider is
    generic(
        input_f: real := 125.0e6; -- Hz
        output_f: real:= 125.0e3 -- Hz
    );
    Port (  sysclk : in std_logic;
         n_Reset: in std_logic;
         ratio: in integer;
         output_s: out std_logic
        );
end clock_divider;

architecture Behavioral of clock_divider is

    signal count: integer := 0;
    constant max: integer := integer(input_f / output_f)-1;
    signal output_copy: std_logic := '0';
    signal limit: integer := max-ratio;
    signal off: boolean := true;

begin

    process(sysclk, n_Reset) is
    begin
        if n_Reset='0' then -- reset the state
            count <= 0;
            output_copy <= '0';
        elsif rising_edge(sysclk) then
--            if off then
--                limit <= max - ratio;
--            else
--                limit <= max - limit;
--            end if;
            if limit = 0 then
                output_copy <= '1';
                limit <= max - ratio;
            elsif limit = max then
                output_copy  <= '0';
                limit <= max - ratio; 
            elsif count >= limit then
                count <= 0;
                if output_copy = '0' then
                    limit <= max - limit;
                else
                    limit <= max - ratio;
                end if;
                output_copy <= not output_copy;
--                off <= not off; 
            else
                count <= count + 1;
            end if;
        end if; -- signal conditions
        
    end process;
    output_s <= output_copy;



end Behavioral;
