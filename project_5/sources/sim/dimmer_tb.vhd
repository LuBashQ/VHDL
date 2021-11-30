----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 10:14:38
-- Design Name: 
-- Module Name: dimmer_tb - Behavioral
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

entity dimmer_tb is
    --  Port ( );
end dimmer_tb;

architecture Behavioral of dimmer_tb is
    component dimmer is
        generic(
            resolution: integer := 10
        );
        Port (
            sysclk: in std_logic;
            op_clk: in std_logic;
            n_Reset: in std_logic;
            enable: in std_logic;
            up: in std_logic;
            down: in std_logic;
            output_dimmer: out std_logic
        );
    end component dimmer;

    component clock_divider is
        generic(
            input_f: real := 125.0e6; -- Hz
            output_f: real:= 125.0e3 -- Hz
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

    constant RESOLUTION: integer := 10;
    constant SYSCLK_PERIOD: time := 8ns;
    constant OP_CLK_PERIOD: time := 0.008ms;
    constant LONG_DELAY: integer := 4;
    constant SHORT_DELAY: integer := 2;

    signal sysclk: std_logic := '0';
    signal op_clk: std_logic := '0';
    signal n_Reset: std_logic := '1';
    signal up: std_logic := '0';
    signal down: std_logic := '0';
    signal enable: std_logic := '1';
    signal dimmed_out: std_logic := '0';
    signal up_cnt: std_logic := '0';
    signal down_cnt: std_logic := '0';

begin

    sysclk <= not sysclk after SYSCLK_PERIOD/2.0;

    i_clock_divider: clock_divider
        generic map(
            output_f => 125.0e3
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            ratio => (125e6/125e3)/2,
            output_s => op_clk
        );

    dimmer_r: dimmer
        Port map (
            sysclk => sysclk,
            op_clk => op_clk,
            n_Reset => n_Reset,
            enable => enable,
            up => up_cnt,
            down => down_cnt,
            output_dimmer => dimmed_out
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

    process
    begin
        wait for OP_CLK_PERIOD * 15;
        up <= '1';
        wait for OP_CLK_PERIOD * 200;
        up <= '0';
        down <= '1';
        wait for OP_CLK_PERIOD * 500;
        enable <= '0';
        wait for OP_CLK_PERIOD * 200;
        down <= '0';
        up <= '1';
        enable <= '1';
        wait;
    end process;



end Behavioral;
