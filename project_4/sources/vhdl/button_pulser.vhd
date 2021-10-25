----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2021 13:15:12
-- Design Name: 
-- Module Name: button_pulser - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_pulser is
    generic (
        long_press_delay: natural := 4; -- clock cycles
        repeat_delay: natural := 2 -- clock cycles
    );
    port (
        btn_in_s: in std_logic;
        clk: in std_logic;
        n_Reset: in std_logic;
        btn_out_s: out std_logic
    );
end button_pulser;

architecture Behavioral of button_pulser is

    signal output_s: std_logic := '0';
    signal is_in_delay: boolean := false;
    signal delay_counter: natural := 0;
    signal is_in_repeat: boolean := false;
    signal repeat_counter: natural := 0;
    
begin

    pulse: process(clk, n_Reset) is
    begin
        output_s <= '0'; -- make sure that signal stays up only until next rising edge
        if n_Reset = '0' or (rising_edge(clk) and btn_in_s = '0') then
            is_in_delay <= false;
            is_in_repeat <= false;
            repeat_counter <= 0;
            delay_counter <= 0;
        elsif rising_edge(clk) and btn_in_s = '1' then -- pulse only if button is pressed
            if is_in_delay then -- the button has been pressed once
                if delay_counter < long_press_delay then
                    delay_counter <= delay_counter + 1;
                    output_s <= '0';
                else -- delay finished, battery can start
                    is_in_repeat <= true;
                    is_in_delay <= false;
                    delay_counter <= 0;
                    output_s <= '1';
                end if; -- delay counter
            elsif is_in_repeat then -- button pulse battery
                if repeat_counter < repeat_delay then
                    repeat_counter <= repeat_counter + 1;
                    output_s <= '0';
                else
                    output_s <= '1';
                    repeat_counter <= 0;
                end if; -- repeat counter
            else -- first button press
                output_s <= '1';
                is_in_delay <= true; -- button pressed once, delay can start
            end if; -- pulser 
        end if; -- event conditions
    end process pulse;

    btn_out_s <= output_s;

end Behavioral;
