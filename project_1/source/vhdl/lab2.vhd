----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/09/2019 10:47:12 AM
-- Design Name: 
-- Module Name: logic_gates - Behavioral
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

entity logic_gates is
  Port (
    btn :       in  std_logic_vector(1 downto 0);
    sw :        in  std_logic_vector(1 downto 0);
    led :       out  std_logic_vector (3 downto 0);
    led4_r :    out STD_LOGIC;
    led4_g :    out STD_LOGIC;
    led4_b :    out STD_LOGIC;
    led5_r :    out STD_LOGIC;
    led5_g :    out STD_LOGIC;
    led5_b :    out STD_LOGIC
  );
end logic_gates;

architecture Behavioral of logic_gates is
   
    -- group of RGB led signals
    signal RGB_Led_4: std_logic_vector(0 to 2);
    -- group of RGB led signals
    signal RGB_Led_5: std_logic_vector(0 to 2);


begin
    led4_r <= RGB_Led_4 (0);
    led4_g <= RGB_Led_4 (1);
    led4_b <= RGB_Led_4 (2);
    
    led5_r <= RGB_Led_5 (0);
    led5_g <= RGB_Led_5 (1);
    led5_b <= RGB_Led_5 (2); 
    
    with btn(1 downto 0) select
        led <=  "0001" when "00",
                "0010" when "01",
                "0100" when "10",
                "1000" when others;
    
    with btn(1 downto 0) select
        RGB_Led_4 <=    "000" when "00",
                        "100" when "01",
                        "010" when "10",
                        "001" when others;   
                       
    RGB_Led_5 <= "000" when sw = "00" else
                 RGB_Led_4 when sw = "01" else
                 "111";           
           
                        
end Behavioral;