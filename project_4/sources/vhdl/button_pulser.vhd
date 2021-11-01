----------------------------------------------------------------------------------
-- Company: TUAS
-- Engineers: Veronica Zanella, Cristian Nicolae Lupascu 
-- Create Date: 18.10.2021 12:27:40
-- Design Name: clock_divider
-- Module Name: clock_divider - Behavioral
-- Project Name: LAB4
-- Target Devices: PYNQ-Z2
-- Description: Button pulser
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library clock_divider;
library counter;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity button_pulser is
    generic (
        pulse_rate: natural := 125e3; -- input clock frequency Hz
        pushed_delay: natural := 4; -- clock cycles
        repeat_delay: natural := 2 -- clock cycles
    );
    port (
        btn_in_s: in std_logic;
        clk: in std_logic;
        n_Reset: in std_logic;
        btn_out_s: out std_logic
    );
end button_pulser;

architecture Behavioral of button_pulser is

    signal btn_output_s: std_logic:= '0';

    type button_state is (IDLE, PUSHED, REPEAT, COOLDOWN);
    signal state: button_state := IDLE;

    component counter is
    generic (
        max: natural
    );
    port (
        clk: in std_logic;
        n_Reset: in std_logic;
        out_s: out std_logic;
        enable: in std_logic
    );
    end component counter;

    signal pushed_s: std_logic := '0';
    signal repeat_s: std_logic := '0';
    signal pushed_delay_enable: std_logic := '0';
    signal repeat_delay_enable: std_logic := '0';
    signal pushed_pc: std_logic := '0';
    signal repeat_pc: std_logic := '0';

begin

--pulse: process(clk, n_Reset) is
--begin
--    if n_Reset = '0' then
--        state <= IDLE;
--        btn_output_s <= '0';
--        pushed_delay_enable <= '0';
--        repeat_delay_enable <= '0';
--    elsif rising_edge(clk) then
--        case state is
--            when IDLE =>
--                if btn_in_s = '1' then
--                    state <= PUSHED;
--                    btn_output_s <= '1'; -- button has been pushed
--                    pushed_delay_enable <= '1'; -- starts pushed delay counter
--                else
--                    pushed_delay_enable <= '0';
--                    repeat_delay_enable <= '0';
--                    btn_output_s <= '0';
--                end if;
--            when PUSHED =>
--                btn_output_s <= '0';
--                if btn_in_s = '1' and pushed_s = '1' then
--                    btn_output_s <= '1';
--                    state <= REPEAT; -- delay done
--                    pushed_delay_enable <= '0';
--                    repeat_delay_enable <= '1';
--                elsif btn_in_s <= '0' then  
--                    state <= IDLE;
--                    pushed_delay_enable <= '0';
--                end if;
--            when REPEAT =>
--               btn_output_s <= '0';
--                if btn_in_s = '1' and repeat_s = '1' then
--                    btn_output_s <= '1';
--                elsif btn_in_s <= '0' then  
--                    state <= IDLE;
--                    repeat_delay_enable <= '0';
--                end if;
--            when others =>
--                state <= IDLE;
--        end case;
--    end if;
--end process pulse;

set_state: process(clk, n_Reset)
begin
    if n_Reset = '0' then 
        state <= IDLE;
        pushed_delay_enable <= '0';
        repeat_delay_enable <= '0';
    elsif rising_edge(clk) then
        case state is
            when IDLE =>
                if btn_in_s = '1' then
                    state <= PUSHED;
                    pushed_delay_enable <= '1';
                else
                    pushed_delay_enable <= '0';
                    repeat_delay_enable <= '0';
                end if;
            when PUSHED =>
                if btn_in_s <= '1' and pushed_s = '1' then
                    state <= COOLDOWN;
                    pushed_delay_enable <= '0';
                    repeat_delay_enable <= '1';
                elsif btn_in_s <= '0' then
                    state <= IDLE;
                    pushed_delay_enable <= '0';  
                end if;
            when REPEAT =>
                if btn_in_s = '1' then
                    state <= COOLDOWN;
                    repeat_delay_enable <= '1';
                elsif btn_in_s <= '0' then
                    state <= IDLE;
                    repeat_delay_enable <= '0';  
                end if;
            when COOLDOWN =>
                if btn_in_s = '1' and repeat_s = '1' then
                    repeat_delay_enable <= '0';
                    state <= REPEAT;
                elsif btn_in_s <= '0' then
                    state <= IDLE;
                    repeat_delay_enable <= '0';  
                end if; 
         end case;
    end if;
end process set_state;

set_output: process(state, pushed_s, repeat_s, btn_in_s)
begin
    case state is
    when IDLE =>
        if btn_in_s = '1' then
            btn_output_s <= '1';
        else
            btn_output_s <= '0';
        end if;
    when PUSHED =>
        if btn_in_s = '1' and rising_edge(pushed_s) then
            btn_output_s <= '1';
        else
            btn_output_s <= '0';
        end if;
    when REPEAT =>
        if btn_in_s = '1' then
            btn_output_s <= '1';
        else
            btn_output_s <= '0';
        end if;
    when COOLDOWN =>
        btn_output_s <= '0';
    when others => btn_output_s <= '0';
    end case;
end process set_output;


pushed_delay_counter: counter
    generic map(
        max => pushed_delay
    )
    port map(
        clk => clk,
        n_Reset => n_Reset,
        out_s => pushed_s,
        enable => pushed_delay_enable
    );

repeat_delay_counter: counter
    generic map(
        max => repeat_delay
    )
    port map(
        clk => clk,
        n_Reset => n_Reset,
        out_s => repeat_s,
        enable => repeat_delay_enable
    );

    btn_out_s <= btn_output_s;

end Behavioral;
