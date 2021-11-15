----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 02.11.2021 13:06:00
-- Design Name: button_pulser
-- Module Name: button_pulser - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Button pulser
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb_selector is
    generic (
        operating_f: real := 1.0e3; -- Hz
        long_delay: real := 2.0; -- seconds
        short_delay: real := 0.5 -- seconds
    );
    port (
        clk: in std_logic;
        selector: in std_logic;
        n_Reset: in std_logic;
        colour_value: out std_logic_vector(2 downto 0)
    );
end rgb_selector;

architecture Behavioral of rgb_selector is

    component button_pulser is
        generic (
            long_press_delay: natural;
            repeat_delay: natural
        );
        port (
            btn_in_s: in std_logic;
            clk: in std_logic;
            n_Reset: in std_logic;
            btn_out_s: out std_logic
        );
    end component button_pulser;

    -- button pulser signals --
    signal button_pulser_out: std_logic := '0';
    
    -- rgb selector signals
    type selector_colour is (RED, GREEN, BLUE);
    signal colour: selector_colour := RED;
    signal colour_value_copy: std_logic_vector(2 downto 0) := "100";

begin

    button_pulser_i: button_pulser
        generic map(
            long_press_delay => natural(operating_f * long_delay),
            repeat_delay => natural(operating_f * short_delay)
        )
        port map(
            btn_in_s => selector,
            btn_out_s => button_pulser_out,
            n_Reset => n_Reset,
            clk => clk
        );

    set_colour: process(clk, n_Reset) is
    begin
        if n_Reset = '0' then
            colour <= RED;
            colour_value_copy <= "100";
        elsif rising_edge(clk) and button_pulser_out = '1' then
            case colour is
                when RED =>
                    colour <= GREEN;
                    colour_value_copy <= "010";
                when GREEN =>
                    colour <= BLUE;
                    colour_value_copy <= "001";
                when BLUE =>
                    colour <= RED;
                    colour_value_copy <= "100";
                when others =>
                    colour <= RED;
                    colour_value_copy <= "100";
            end case;
        end if;
    end process set_colour;
    
    colour_value <= colour_value_copy;

end Behavioral;