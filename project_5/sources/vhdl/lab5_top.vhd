library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

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

    --    constant LONG_DELAY: integer := 4;
    --    constant SHORT_DELAY: integer := 2;
    --    constant RESOLUTION: integer := 10;

    --    component clock_divider is
    --        generic(
    --            input_f: real := 125.0e6; -- Hz
    --            output_f: real:= 125.0e3 -- Hz
    --        );
    --        Port (  sysclk : in std_logic;
    --             n_Reset: in std_logic;
    --             ratio: in integer;
    --             output_s: out std_logic
    --            );

    --    end component clock_divider;
    --    -- op_clk
    --    signal clk: std_logic := '0';

    --    component button_pulser is
    --        generic (
    --            long_press_delay: natural;
    --            repeat_delay: natural
    --        );
    --        port (
    --            btn_in_s: in std_logic;
    --            clk: in std_logic;
    --            n_Reset: in std_logic;
    --            btn_out_s: out std_logic
    --        );
    --    end component button_pulser;
    --    -- buttons
    --    signal count_up: std_logic := '0';
    --    signal count_down: std_logic := '0';

    --    component rgb_selector is
    --        generic (
    --            operating_f: real := 1.0e3; -- Hz
    --            long_delay: real := 2.0; -- seconds
    --            short_delay: real := 0.5 -- seconds
    --        );
    --        port (
    --            clk: in std_logic;
    --            selector: in std_logic;
    --            n_Reset: in std_logic;
    --            colour_value: out std_logic_vector(2 downto 0)
    --        );
    --    end component rgb_selector;
    --    signal selected_color: std_logic_vector(2 downto 0) := "100";

    --    component rgb_dimmer is
    --        generic( resolution: integer := 10
    --               );
    --        Port (sysclk: in std_logic;
    --             op_clk: in std_logic;
    --             n_Reset: in std_logic;
    --             color: in std_logic_vector (2 downto 0);
    --             up: in std_logic;
    --             down: in std_logic;
    --             color_pwm: out std_logic_vector (2 downto 0)
    --            );
    --    end component rgb_dimmer;

    --    signal colors_pwm_out: std_logic_vector (2 downto 0) := "100";

    --begin
    --    i_clock_divider: clock_divider
    --        generic map(
    --            output_f => 1.0e3
    --        )
    --        port map(
    --            sysclk => sysclk,
    --            n_Reset => not reset,
    --            ratio => (125e6/1e3)/2,
    --            output_s => clk
    --        );

    --    i_up: button_pulser
    --        generic map(
    --            long_press_delay => LONG_DELAY ,
    --            repeat_delay => SHORT_DELAY
    --        )
    --        port map(
    --            btn_in_s => up,
    --            clk => clk,
    --            n_Reset => not reset,
    --            btn_out_s => count_up
    --        );

    --    i_down: button_pulser
    --        generic map(
    --            long_press_delay => LONG_DELAY ,
    --            repeat_delay => SHORT_DELAY
    --        )
    --        port map(
    --            btn_in_s => down,
    --            clk => clk,
    --            n_Reset => not reset,
    --            btn_out_s => count_down
    --        );

    --    i_rgb_selector: rgb_selector
    --        generic map (
    --            operating_f => 1.0e3
    --            )
    --        port map(
    --            clk => clk,
    --            n_Reset => not reset,
    --            selector => channel_selector,
    --            colour_value => selected_color
    --        );

    --    i_dimmer: rgb_dimmer
    --        generic map(
    --            resolution => RESOLUTION
    --        )
    --        port map(
    --            sysclk => sysclk,
    --            op_clk => clk,
    --            up => count_up,
    --            down => count_down,
    --            color => selected_color,
    --            n_Reset => not reset,
    --            color_pwm => colors_pwm_out
    --        );

    --led4_r <= colors_pwm_out(2);
    --led4_g <= colors_pwm_out(1);
    --led4_b <= colors_pwm_out(0);

    --ja(2) <= colors_pwm_out(2);
    --ja(1) <= colors_pwm_out(1);
    --ja(0) <= colors_pwm_out(0);
    --end Behavioral;
    component rgb_dimmer is
        generic(
            resolution: integer
        );
        Port (
            sysclk: in std_logic;
            op_clk: in std_logic;
            n_Reset: in std_logic;
            color: in std_logic_vector (2 downto 0);
            up: in std_logic;
            down: in std_logic;
            color_pwm: out std_logic_vector (2 downto 0)
        );
    end component rgb_dimmer;

    component clock_divider is
        generic(
            input_f: real; -- Hz
            output_f: real -- Hz
        );
        Port (
            sysclk : in std_logic;
            n_Reset: in std_logic;
            ratio: in integer;
            output_s: out std_logic
        );

    end component clock_divider;

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

    component rgb_selector is
        generic (
            operating_f: real; -- Hz
            long_delay: real; -- seconds
            short_delay: real -- seconds
        );
        port (
            clk: in std_logic;
            selector: in std_logic;
            n_Reset: in std_logic;
            colour_value: out std_logic_vector(2 downto 0)
        );
    end component rgb_selector;

    constant RESOLUTION: integer := 10;
    constant LONG_DELAY: integer := 4;
    constant SHORT_DELAY: integer := 2;
    constant OUTPUT_F: real := 1.0e3;
    constant INPUT_F: real := 125.0e6;

    signal op_clk: std_logic := '0';
    signal enable: std_logic_vector(2 downto 0) := "100";
    signal dimmed_out: std_logic_vector(2 downto 0) := "100";
    signal up_cnt: std_logic := '0';
    signal down_cnt: std_logic := '0';
    signal n_Reset: std_logic := not reset;
begin


    i_dimmer: rgb_dimmer
        generic map(
            resolution => RESOLUTION
        )
        port map(
            sysclk => sysclk,
            op_clk => op_clk,
            up => up_cnt,
            down => down_cnt,
            color => enable,
            n_Reset => n_Reset,
            color_pwm => dimmed_out
        );

    i_clock_divider: clock_divider
        generic map(
            input_f => INPUT_F,
            output_f => OUTPUT_F
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            ratio => (integer(INPUT_F)/integer(OUTPUT_F)) / 2,
            output_s => op_clk
        );

    i_up: button_pulser
        generic map(
            long_press_delay => LONG_DELAY ,
            repeat_delay => SHORT_DELAY
        )
        port map(
            btn_in_s => up,
            clk => op_clk,
            n_Reset => n_Reset,
            btn_out_s => up_cnt
        );

    i_down: button_pulser
        generic map(
            long_press_delay => LONG_DELAY ,
            repeat_delay => SHORT_DELAY
        )
        port map(
            btn_in_s => down,
            clk => op_clk,
            n_Reset => n_Reset,
            btn_out_s => down_cnt
        );

    i_rgb_selector: rgb_selector
        generic map (
            operating_f => OUTPUT_F,
            long_delay => 2.0,
            short_delay => 0.5
        )
        port map(
            clk => op_clk,
            n_Reset => n_Reset,
            selector => channel_selector,
            colour_value => enable
        );

    led4_r <= dimmed_out(2);
    led4_g <= dimmed_out(1);
    led4_b <= dimmed_out(0);
    -- debug
    ja(2) <= dimmed_out(2);
    ja(1) <= dimmed_out(2);
    ja(0) <= dimmed_out(2);

end Behavioral;
