----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 18.10.2021 12:27:40
-- Design Name: clock_divider
-- Module Name: clock_divider - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Button pulser
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library clock_divider;
library counter;

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

    signal btn_output_copy: std_logic:= '0';

    type button_state is (IDLE, PRESSED, REPEATED);
    signal state: button_state := IDLE;

    component counter is
        generic (
            max: natural
        );
        port (
            clk: in std_logic;
            n_Reset: in std_logic;
            out_s: out std_logic;
            enable: in std_logic;
            count: out natural
        );
    end component counter;

    signal long_press: std_logic := '0';
    signal repeat: std_logic := '0';
    signal long_press_enable: std_logic := '0';
    signal repeat_enable: std_logic := '0';
    signal long_press_count: natural := 0;
    signal repeat_count: natural := 0;

begin

    set_state: process(clk, n_Reset) is
    begin
        if n_Reset = '0' then
            state <= IDLE;
            long_press_enable <= '0';
            repeat_enable <= '0';
        elsif rising_edge(clk) then
            if btn_in_s = '1' then
                case state is
                    when IDLE =>
                        state <= PRESSED;
                        long_press_enable <= '1';
                    when PRESSED =>
                        if long_press_count = long_press_delay - 2 then -- we have to anticipate the delay by 1 :(
                            repeat_enable <= '1';
                        elsif long_press = '1' then
                            long_press_enable <= '0';
                            state <= REPEATED;
                        end if;
                    when REPEATED =>
                    when others =>
                        state <= IDLE;
                end case;
            else
                state <= IDLE;
                long_press_enable <= '0';
                repeat_enable <= '0';
            end if;
        end if;
    end process set_state;

    set_output: process(clk, n_Reset) is
    begin
        if n_Reset = '0' then
            btn_output_copy  <= '0';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    btn_output_copy <= btn_in_s;
                when PRESSED =>
                    btn_output_copy <= btn_in_s and long_press;
                when REPEATED =>
                    btn_output_copy <= btn_in_s and repeat;
                when others =>
                    btn_output_copy <= '0';
            end case;
        end if;
    end process set_output;

    pushed_delay_counter: counter
        generic map(
            max => long_press_delay - 1
        )
        port map(
            clk => clk,
            n_Reset => n_Reset,
            out_s => long_press ,
            enable => long_press_enable,
            count => long_press_count
        );

    repeat_delay_counter: counter
        generic map(
            max => repeat_delay
        )
        port map(
            clk => clk,
            n_Reset => n_Reset,
            out_s => repeat,
            enable => repeat_enable,
            count => repeat_count
        );

    btn_out_s <= btn_output_copy;

end Behavioral;
