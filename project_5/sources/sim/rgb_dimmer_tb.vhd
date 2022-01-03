----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 11:00:21
-- Design Name: 
-- Module Name: rgb_dimmer_tb - Behavioral
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

entity rgb_dimmer_tb is
    --  Port ( );
end rgb_dimmer_tb;

architecture Behavioral of rgb_dimmer_tb is
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
    constant SYSCLK_PERIOD: time := 8ns;
    constant OP_CLK_PERIOD: time := 0.008ms;
    constant LONG_DELAY: integer := 4;
    constant SHORT_DELAY: integer := 2;
    constant OUTPUT_F: real := 125.0e3;
    constant INPUT_F: real := 125.0e6;
    constant SPEEDUP: integer := 125;

    signal sysclk: std_logic := '0';
    signal op_clk: std_logic := '0';
    signal n_Reset: std_logic := '1';
    signal up: std_logic := '0';
    signal down: std_logic := '0';
    signal enable: std_logic_vector(2 downto 0) := "100";
    signal dimmed_out: std_logic_vector(2 downto 0) := "100";
    signal up_cnt: std_logic := '0';
    signal down_cnt: std_logic := '0';
    signal channel_selector: std_logic := '0';
begin

    sysclk <= not sysclk after SYSCLK_PERIOD/2.0;

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
            long_delay => 2.0/OUTPUT_F * SPEEDUP,
            short_delay => 0.5/OUTPUT_F * SPEEDUP
            )
        port map(
            clk => op_clk,
            n_Reset => n_Reset,
            selector => channel_selector,
            colour_value => enable
        );

process
begin
    channel_selector <= '1';
    up <= '0';
    down <= '1';
    wait for OP_CLK_PERIOD * 5000;
    up <= '1';
    down <= '0';
    wait;
end process;

end Behavioral;
