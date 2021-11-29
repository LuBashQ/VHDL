----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2021 13:14:41
-- Design Name: 
-- Module Name: rgb_dimmer - Behavioral
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

entity rgb_dimmer is
    generic( resolution: integer := 10
           );
    Port (sysclk: in std_logic;
         op_clk: in std_logic;
         n_Reset: in std_logic;
         color: in std_logic_vector (2 downto 0);
         up: in std_logic;
         down: in std_logic;
         color_pwm: out std_logic_vector (2 downto 0)
        );
end rgb_dimmer;

architecture Behavioral of rgb_dimmer is
    component dimmer is
        generic( resolution: integer := resolution
               );
        Port (sysclk: in std_logic;
             op_clk: in std_logic;
             n_Reset: in std_logic;
             enable: in std_logic;
             up: in std_logic;
             down: in std_logic;
             output_dimmer: out std_logic
            );
    end component;

    signal enable_dimmers: std_logic_vector (2 downto 0) := "100";


begin
    dimmer_r: dimmer
        Port map (sysclk => sysclk,
                 op_clk => op_clk,
                 n_Reset => n_Reset,
                 enable => enable_dimmers (2),
                 up => up,
                 down => down,
                 output_dimmer => color_pwm (2)
                );
    dimmer_g: dimmer
        Port map (sysclk => sysclk,
                 op_clk => op_clk,
                 n_Reset=> n_Reset,
                 enable => enable_dimmers (1),
                 up => up,
                 down => down,
                 output_dimmer => color_pwm (1)
                );
    dimmer_b: dimmer
        Port map (sysclk => sysclk,
                 op_clk => op_clk,
                 n_Reset=> n_Reset,
                 enable => enable_dimmers (0),
                 up => up,
                 down => down,
                 output_dimmer => color_pwm (0)
                );
    process(op_clk  , n_Reset) is
    begin
        if n_Reset ='0' then
            enable_dimmers <= "100";
        elsif rising_edge (op_clk)then
            enable_dimmers <= color;
        end if;
    end process;
    

end Behavioral;
