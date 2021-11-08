----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2021 10:29:36
-- Design Name: 
-- Module Name: lab4_top_tb - Behavioral
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

entity lab4_top_tb is
--  Port ( );
end lab4_top_tb;

architecture Behavioral of lab4_top_tb is
component lab4_top is
    generic(
        operating_f: real := 1.0e3;
        long_delay: real := 2.0;
        short_delay: real := 0.5
    );
    Port ( 
        sysclk: in std_logic;
        selector: in std_logic;
        reset: in std_logic;
        led5_r: out std_logic;
        led5_g: out std_logic;
        led5_b: out std_logic
       );
end component lab4_top;

signal sysclk: std_logic := '0';
signal selector: std_logic := '0';
signal n_Reset:std_logic := '1';
signal rgb_output: std_logic_vector (2 downto 0) := (others =>'0');

-- to manage time
constant SPEEDUP: natural := 1000;
constant SYSCLK_PERIOD: time := 8ns;
constant CLOCK_PERIOD: time := 1ms / SPEEDUP;

begin
process 
begin
    wait for (CLOCK_PERIOD * 10);
    selector <= '1';
    wait for (CLOCK_PERIOD * 2500);
    selector <= '0';
    wait for (CLOCK_PERIOD * 10);
    selector <= '1';
    wait;
end process;

i_lab4_top: lab4_top 
    generic map(
        operating_f => 1.0e3*SPEEDUP,
        long_delay => 2.0/SPEEDUP,
        short_delay => 0.5/SPEEDUP 
    )
    port map(
        sysclk => sysclk,
        reset => not n_Reset,
        selector => selector,
        led5_r => rgb_output (2),
        led5_g => rgb_output (1),
        led5_b => rgb_output (0)
    );
sysclk <= not sysclk after (SYSCLK_PERIOD/2);


end Behavioral;
