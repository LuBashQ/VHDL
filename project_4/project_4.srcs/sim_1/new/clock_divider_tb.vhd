----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineer: Veronica Zanella, Cristian Nicolae Lupascu
-- Create Date: 18.10.2021 15:05:42
-- Design Name: clock_divider test bench
-- Module Name: clock_divider_tb - Behavioral
-- Project Name: LAB4
-- Description: Test bench for clock_divider component
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clock_divider_tb is
    --  Port ( );
end clock_divider_tb;

architecture Behavioral of clock_divider_tb is

    constant SYSCLK_PERIOD: time := 8ns;
    signal sysclk: std_logic := '0';
    signal n_Reset: std_logic := '1';
    signal output_s: std_logic := '0';

    component clock_divider is
        port(
            sysclk : in std_logic;
            n_Reset: in std_logic;
            output_s: inout std_logic
        );
    end component clock_divider;

begin

    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);

    process
    begin
        wait for(SYSCLK_PERIOD * 50);
        n_Reset <= not n_Reset;
        wait for(SYSCLK_PERIOD * 2);
        n_Reset <= not n_Reset;
        wait for(SYSCLK_PERIOD * 50);
        wait;
    end process;
    
    i_clocky: clock_divider
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            output_s => output_s
        );
        
end Behavioral;
