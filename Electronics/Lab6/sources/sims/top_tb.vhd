library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_tb is
    --  Port ( );
end top_tb;

architecture Behavioral of top_tb is
    constant SYSTEMCLOCK: time := 8ns;
    signal sysclk: std_logic := '0';
    signal output: std_logic_vector(7 downto 0) := (others => '0');

    component top is
        generic (
            input_f: real;
            output_f: real
        );
        port (
            sysclk: in std_logic;
            ja: out std_logic_vector(7 downto 0)
        );
    end component top;

begin

    top_DUT: top
        generic map (
            input_f => 125.0e6,
            output_f => 1.0e6
        )
        port map(
            sysclk => sysclk,
            ja => output
        );

    sysclk <= not sysclk after (SYSTEMCLOCK/2);

    process
    begin
        wait;
    end process;


end Behavioral;
