----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.10.2021 14:57:41
-- Design Name: 
-- Module Name: counter - Behavioral
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

entity counter is
    generic (
        max: natural
    );
    port (
        clk: in std_logic;
        n_Reset: in std_logic;
        out_s: out std_logic;
        enable: in std_logic
    );
end counter;

architecture Behavioral of counter is
    
    signal counter: natural := 0;
    signal output: std_logic := '0';
    
begin

    process(clk, n_Reset) is
    begin
        if n_Reset = '0' or enable = '0' then
            counter <= 0;
            output <= '0';
        elsif rising_edge(clk) and enable = '1' then
            if counter >= max - 1 then
                counter <= 0;
                output <= '1';
            else
                output <= '0';
                counter <= counter + 1;
            end if;
        end if;
    end process;

    out_s <= output;

end Behavioral;
