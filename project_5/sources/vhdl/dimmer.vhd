----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2021 14:22:55
-- Design Name: 
-- Module Name: dimmer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dimmer is
    generic( resolution: integer := 10
           );
    Port (sysclk: in std_logic;
         op_clk: in std_logic;
         n_Reset: in std_logic;
         enable: in std_logic;
         up: in std_logic;
         down: in std_logic;
         output_dimmer: out std_logic
        );
end dimmer;

architecture Behavioral of dimmer is
    constant HALF_DUTY_CYCLE_I: integer := (2** resolution)/2;
    constant HALF_DUTY_CYCLE_V: std_logic_vector  := std_logic_vector(to_unsigned(HALF_DUTY_CYCLE_I, resolution));
    component pwm is
        generic (resolution: integer);
        Port ( sysclk: in std_logic;
             n_Reset: in std_logic;
             pwm_value: in std_logic_vector ((resolution-1) downto 0);
             pwm_output: out std_logic
            );
    end component pwm;
    signal pwm_value_copy: std_logic_vector((resolution-1) downto 0) := HALF_DUTY_CYCLE_V;
    signal pwm_integer: integer := HALF_DUTY_CYCLE_I; 
    signal pwm_out: std_logic := '0';
begin
 process(op_clk, n_Reset) is
    begin
        if n_Reset ='0' then
            pwm_value_copy <= HALF_DUTY_CYCLE_V;
        elsif rising_edge(op_clk) and enable = '1' then
            if up = '1' and pwm_integer  < 2**resolution - 1 then
                --pwm_value_copy <= std_logic_vector(to_unsigned(to_integer(unsigned(pwm_value_copy))+1, resolution)); 
                pwm_integer <= pwm_integer +1;
            elsif down = '1'and pwm_integer  > 0 then
                --pwm_value_copy <= std_logic_vector(to_unsigned(to_integer(unsigned(pwm_value_copy))-1, resolution)); 
                pwm_integer <= pwm_integer -1;
            end if;
        end if;
    end process;
   
   pwm_value_copy <= std_logic_vector(to_unsigned(pwm_integer, resolution));
   
   i_pwm: pwm 
    generic map (resolution => resolution)
        Port map( sysclk=> sysclk,
             n_Reset=> n_Reset,
             pwm_value=>pwm_value_copy,
             pwm_output => output_dimmer 
            );
    
  --output_dimmer <= pwm_out when enable ='1' else '0';

end Behavioral;
