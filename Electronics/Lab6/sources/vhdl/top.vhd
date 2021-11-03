library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    generic (
        input_f: real := 125.0e6;
        output_f: real := 125.0e6
    );
    port (
        sysclk: in std_logic;
        ja: out std_logic_vector(7 downto 0)
    );
end top;

architecture Behavioral of top is

    component clock_divider is
        generic(
            input_f: real; -- Hz
            output_f: real -- Hz
        );
        Port (
            sysclk : in std_logic;
            output_s: out std_logic
        );
    end component clock_divider;

    component counter is
        generic (
            max: natural range 0 to 256 -- max 8 bits because Pmod ports have only 8 outputs
        );
        port (
            clk: in std_logic;
            out_s: out std_logic_vector(7 downto 0)
        );
    end component counter;

    signal clk: std_logic := '0';

begin

    clock: clock_divider
        generic map (
            input_f => input_f,
            output_f => output_f
        )
        port map(
            sysclk => sysclk,
            output_s => clk
        );

    freq_divider: counter
        generic map(
            max => 256
        )
        port map(
            clk => clk,
            out_s => ja
        );

end Behavioral;
