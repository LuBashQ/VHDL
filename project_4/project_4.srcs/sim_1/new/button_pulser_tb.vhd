----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.10.2021 13:15:57
-- Design Name: 
-- Module Name: button_pulser_tb - Behavioral
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

entity button_pulser_tb is
    --  Port ( );
end button_pulser_tb;

architecture Behavioral of button_pulser_tb is

    constant SYSCLK_PERIOD: time := 8ns;
    -- clock divider
    signal sysclk: std_logic := '0';
    signal n_Reset: std_logic := '1';
    signal output_s: std_logic := '0';
    -- button pulser
    signal btn_in_s: std_logic := '0';
    signal btn_out_s: std_logic := '0';


    component clock_divider is
        generic(
            output_f: natural
        );
        port(
            sysclk : in std_logic;
            n_Reset: in std_logic;
            output_s: inout std_logic
        );
    end component clock_divider;

    component button_pulser is
        port (
            btn_in_s: in std_logic;
            clk: in std_logic;
            n_Reset: in std_logic;
            btn_out_s: out std_logic
        );
    end component button_pulser;

begin

    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);
    
    process
    begin
        wait for(SYSCLK_PERIOD * 24);
        btn_in_s <= '1';
        wait for(SYSCLK_PERIOD * 2);
        btn_in_s <= '0';
        wait for(SYSCLK_PERIOD * 10);
        btn_in_s <= '1';
        wait;
    end process;
    

    i_clocky: clock_divider
        generic map(
            output_f => 125e5
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            output_s => output_s
        );


    i_pulsy: button_pulser
        port map(
            clk => output_s,
            btn_in_s => btn_in_s,
            btn_out_s => btn_out_s,
            n_Reset => n_Reset
        );

end Behavioral;
