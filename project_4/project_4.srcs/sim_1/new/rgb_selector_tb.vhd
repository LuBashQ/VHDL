library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb_selector_tb is
    --  Port ( );
end rgb_selector_tb;

architecture Behavioral of rgb_selector_tb  is

    constant SYSCLK_PERIOD: time := 8ns;
    constant CLOCK_PERIOD: time := 1ms;
    -- clock divider
    signal sysclk: std_logic := '0';
    signal n_Reset: std_logic := '1';
    signal output_s: std_logic := '0';
    -- rgb_selector
    signal btn_in_s: std_logic := '0';
    signal colour: std_logic_vector(2 downto 0) := "000";

    component clock_divider is
        generic(
            output_f: real
        );
        port(
            sysclk : in std_logic;
            n_Reset: in std_logic;
            output_s: inout std_logic
        );
    end component clock_divider;

    component rgb_selector is
        generic (
            operating_f: real := 1.0e3; -- Hz
            long_delay: real := 1.0; -- seconds
            short_delay: real := 0.5 -- seconds
        );
        port (
            clk: in std_logic;
            selector: in std_logic;
            n_Reset: in std_logic;
            colour_value: out std_logic_vector(2 downto 0)
        );
    end component rgb_selector;

begin

    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);

    process
    begin
        btn_in_s <= '1';
        wait for(CLOCK_PERIOD * 3000);
        btn_in_s <= '0';
        wait for(CLOCK_PERIOD * 1000);
        btn_in_s <= '1';
        wait;
    end process;


    i_clocky: clock_divider
        generic map(
            output_f => 1.0e3
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            output_s => output_s
        );

    rgb_selector_UT: rgb_selector
        port map(
            clk => output_s,
            selector => btn_in_s,
            n_Reset => n_Reset,
            colour_value => colour
        );
end Behavioral;
