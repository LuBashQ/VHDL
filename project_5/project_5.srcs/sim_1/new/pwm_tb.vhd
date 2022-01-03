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
            pwm_value: std_logic_vector ((resolution-1) downto 0);
            pwm_output: out std_logic 
     );
end component pwm;
constant RESOLUTION: integer := 17;
constant SYSCLK_PERIOD: time := 8ns;
constant PWM_PERIOD: time := SYSCLK_PERIOD * (2**RESOLUTION);
signal sysclk: std_logic := '0';
signal n_Reset: std_logic := '1';
signal output_s: std_logic := '0';
signal duty_value: integer:= 0;

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
   
    i_pwm: pwm
        generic map (
            resolution =>  RESOLUTION 
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            pwm_value => std_logic_vector (to_unsigned(duty_value, resolution)),
            pwm_output => output_s
        );
    sysclk <= not sysclk after (SYSCLK_PERIOD/2.0);
    
process
begin
   wait for (PWM_PERIOD*2);
   duty_value <= 2**(RESOLUTION)/4;
   wait for (PWM_PERIOD*2);
   duty_value <= 2**(RESOLUTION)/2;
   wait for (PWM_PERIOD*2);
   duty_value <= 2**(RESOLUTION)-1;
   wait for (PWM_PERIOD*2);
   duty_value <= 2**(RESOLUTION)*3/4;
   wait for (PWM_PERIOD*2);
   duty_value <= 2**(RESOLUTION);
   wait;
end process;

end Behavioral;
