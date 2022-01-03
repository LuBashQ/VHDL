----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2021 14:58:02
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

component clock_divider is
    generic(
        input_f: integer := 125e6; -- Hz
        output_f: integer:= 125e3 -- Hz
    );
    port(
        sysclk : in std_logic;
        n_Reset: in std_logic;
        output_s: out std_logic
    );
end component clock_divider;

constant SYSCLK_PERIOD: time := 8ns;
signal sysclk: std_logic := '0';
signal n_Reset: std_logic := '1';
signal output_s: std_logic := '0';

begin
    i_clock: clock_divider
        generic map (
            output_f =>  125e6/(2 ** 10)
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            output_s => output_s
        );
    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);

process
begin
wait;
end process;

end Behavioral;
