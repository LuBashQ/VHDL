----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.11.2021 15:36:22
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    generic (resolution: integer);
    Port ( sysclk: in std_logic;
         n_Reset: in std_logic;
         pwm_value: in std_logic_vector((resolution-1) downto 0);
         pwm_output: out std_logic
        );
end pwm;

architecture Behavioral of pwm is
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
    i_pwm: clock_divider
        generic map(
            input_f => 125.0e6,   --Hz
            output_f => 125.0e6/(2.0**(resolution))  -- Hz
        )
        port map(
            sysclk => sysclk,
            n_Reset => n_Reset,
            ratio => to_integer(unsigned(pwm_value)),
            output_s => pwm_output
        );
    
end Behavioral;
