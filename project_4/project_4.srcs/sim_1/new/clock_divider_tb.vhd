----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2021 15:05:42
-- Design Name: 
-- Module Name: clock_divider_tb - Behavioral
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

entity clock_divider_tb is
--  Port ( );
end clock_divider_tb;

architecture Behavioral of clock_divider_tb is
    constant SYSCLK_PERIOD: time := 8ns;
    signal sysclk: std_logic := '0';
    signal n_Reset: std_logic := '0';
    signal output_s: std_logic := '0';
    
    component clock_divider is
        port(sysclk : in std_logic;
            n_Reset: in std_logic;
            output_s: inout std_logic
            );
    end component clock_divider;

begin
sysclk<= not sysclk after (SYSCLK_PERIOD/2.0);
process
begin
    wait;
    
end process;
i_clocky: clock_divider
    port map(
        sysclk => sysclk,
        n_Reset => n_Reset,
        output_s => output_s
        );
end Behavioral;
