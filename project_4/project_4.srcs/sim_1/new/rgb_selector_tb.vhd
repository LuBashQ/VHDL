library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rgb_selector_tb is
    --  Port ( );
end rgb_selector_tb;

architecture Behavioral of rgb_selector_tb  is
    
    constant SPEEDUP: natural := 1000;
    constant SYSCLK_PERIOD: time := 8ns;
    constant CLOCK_PERIOD: time := 1ms / SPEEDUP;
    -- clock divider
    signal sysclk: std_logic := '1';
    signal n_Reset: std_logic := '0';
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
            operating_f: real := 1.0e3 * SPEEDUP;
            long_delay: real := 2.0 / SPEEDUP;
            short_delay: real := 0.5 / SPEEDUP
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
        n_Reset <= '0';
        btn_in_s <= '0';
        wait for(CLOCK_PERIOD * 1000);
        btn_in_s <= '1';
        n_Reset <= '1';
        wait for(CLOCK_PERIOD * 500);
        btn_in_s <= '0';
        wait for(CLOCK_PERIOD * 1000);
        btn_in_s <= '1';
        n_Reset <= '0';
        wait for(CLOCK_PERIOD * 500);
        n_Reset <= '1';
        wait;
    end process;


    clock_divider_UT: clock_divider
        generic map(
            output_f => 1.0e3 * SPEEDUP
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
