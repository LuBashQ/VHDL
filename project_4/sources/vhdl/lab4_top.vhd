----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 08.11.2021 09:22:35
-- Design Name: lab4_top
-- Module Name: lab4_top - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Lab4 top module
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

entity lab4_top is
    Port ( 
        sysclk: in std_logic;
        selector: in std_logic;
        reset: in std_logic;
        led5_r: out std_logic;
        led5_g: out std_logic;
        led5_b: out std_logic
       );
end lab4_top;

architecture Behavioral of lab4_top is

constant OUTPUT_FREQUENCY: real := 1.0e3;

component clock_divider is
    generic(
        input_f: real;
        output_f: real
    );
    port(
        sysclk: in std_logic;
        n_Reset: in std_logic;
        output_s: out std_logic 
    );
 end component clock_divider;
 
 component rgb_selector is
    generic(
        operating_f: real;
        long_delay: real;
        short_delay: real 
    );
    port(
        clk: in std_logic;
        n_Reset: in std_logic;
        selector: in std_logic;
        colour_value: out std_logic_vector (2 downto 0)
    );
 end component rgb_selector;
 
 signal clock_output: std_logic := '0';
 signal rgb_output: std_logic_vector (2 downto 0):= (others => '0');
 
begin
i_clock_divider: clock_divider 
    generic map(
        input_f => 125.0e6,
        output_f => OUTPUT_FREQUENCY 
    )
    port map(
        sysclk => sysclk,
        n_Reset => not reset,
        output_s => clock_output
    );
i_rgb_selector: rgb_selector 
    generic map(
        operating_f => OUTPUT_FREQUENCY , -- Hz
        long_delay => 2.0, -- seconds
        short_delay => 0.5 -- seconds
    )
    port map(
        clk => clock_output,
        n_Reset => not reset,
        selector => selector,
        colour_value => rgb_output
    );
    led5_r <= rgb_output(0);
    led5_g <= rgb_output(1);
    led5_b <= rgb_output(2);

end Behavioral;
