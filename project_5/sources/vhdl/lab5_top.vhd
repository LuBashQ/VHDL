----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2021 12:15:23
-- Design Name: 
-- Module Name: lab5_top - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab5_top is
    Port (sysclk: in std_logic;
         reset: in std_logic;
         up: in std_logic;
         down: in std_logic;
         channel_selector: in std_logic;
         led4_r: out std_logic;
         led4_g: out std_logic;
         led4_b: out std_logic;
         ja: out std_logic_vector (7 downto 0)
        );
end lab5_top;

architecture Behavioral of lab5_top is

    constant LONG_DELAY: integer := 4;
    constant SHORT_DELAY: integer := 2;
    constant RESOLUTION: integer := 10;

    component clock_divider is
        generic(
            input_f: real := 125.0e6; -- Hz
            output_f: real:= 125.0e3 -- Hz
        );
        Port (  sysclk : in std_logic;
             n_Reset: in std_logic;
             ratio: in integer;
             output_s: out std_logic
            );

    end component clock_divider;
    -- op_clk
    signal clk: std_logic := '0';

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
    -- buttons
    signal count_up: std_logic := '0';
    signal count_down: std_logic := '0';

    component rgb_selector is
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
    end component rgb_selector;
    signal selected_color: std_logic_vector(2 downto 0) := "100";

    component rgb_dimmer is
        generic( resolution: integer := 10
               );
        Port (sysclk: in std_logic;
             op_clk: in std_logic;
             n_Reset: in std_logic;
             color: in std_logic_vector (2 downto 0);
             up: in std_logic;
             down: in std_logic;
             color_pwm: out std_logic_vector (2 downto 0)
            );
    end component rgb_dimmer;
    
    signal colors_pwm_out: std_logic_vector (2 downto 0) := "100";

begin
    i_clock_divider: clock_divider
        generic map(
            output_f => 1.0e3
        )
        port map(
            sysclk => sysclk,
            n_Reset => not reset,
            ratio => (125e6/1e3)/2,
            output_s => clk
        );

    i_up: button_pulser
        generic map(
            long_press_delay => LONG_DELAY ,
            repeat_delay => SHORT_DELAY
        )
        port map(
            btn_in_s => up,
            clk => clk,
            n_Reset => not reset,
            btn_out_s => count_up
        );

    i_down: button_pulser
        generic map(
            long_press_delay => LONG_DELAY ,
            repeat_delay => SHORT_DELAY
        )
        port map(
            btn_in_s => down,
            clk => clk,
            n_Reset => not reset,
            btn_out_s => count_down
        );

    i_rgb_selector: rgb_selector
        generic map (
            operating_f => 1.0e3
            )
        port map(
            clk => clk,
            n_Reset => not reset,
            selector => channel_selector,
            colour_value => selected_color
        );

    i_dimmer: rgb_dimmer
        generic map(
            resolution => RESOLUTION
        )
        port map(
            sysclk => sysclk,
            op_clk => clk,
            up => count_up,
            down => count_down,
            color => selected_color,
            n_Reset => not reset,
            color_pwm => colors_pwm_out
        );

led4_r <= colors_pwm_out(2);
led4_g <= colors_pwm_out(1);
led4_b <= colors_pwm_out(0);

ja(2) <= colors_pwm_out(2);
ja(1) <= colors_pwm_out(1);
ja(0) <= colors_pwm_out(0);
end Behavioral;
