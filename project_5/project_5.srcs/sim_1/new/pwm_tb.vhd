----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2021 12:17:43
-- Design Name: 
-- Module Name: pwm_tb - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm_tb is
--  Port ( );
end pwm_tb;

architecture Behavioral of pwm_tb is
component pwm is
    generic (resolution: integer);
    Port ( sysclk: in std_logic;
            n_Reset: in std_logic;
            pwm_value: integer;
            pwm_output: out std_logic 
     );
end component pwm;
constant RESOLUTION: integer := 10;
constant SYSCLK_PERIOD: time := 8ns;
constant PWM_PERIOD: time := SYSCLK_PERIOD * (2**RESOLUTION);
signal sysclk: std_logic := '0';
signal n_Reset: std_logic := '1';
signal output_s: std_logic := '0';
signal duty_value: integer:= 0;
signal sine_s: std_logic := '0';

component clock_divider is
    generic(
        input_f: real;
        output_f: real
    );
    Port (
        sysclk : in std_logic;
        n_Reset: in std_logic;
        ratio: in integer;
        output_s: out std_logic
    );
end component clock_divider;
 
begin
   sine_clock: clock_divider
        generic map(
            input_f => 125.0e6,   --Hz
            output_f => 125.0e2  -- Hz
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            ratio => duty_value,
            output_s => sine_s
        );
    i_pwm: pwm
        generic map (
            resolution =>  RESOLUTION 
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            pwm_value => duty_value,
            pwm_output => output_s
        );
    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);
    
process(sysclk)
begin
    if rising_edge(sysclk) then
        duty_value <= duty_value - (duty_value ** 3)/6 + (duty_value**5)/120;
    end if;
end process;

end Behavioral;
