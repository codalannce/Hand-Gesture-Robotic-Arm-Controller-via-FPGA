

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pwm_servo is
  Port (
    clk: in std_logic;
    pwm_out: out std_logic;
    angle: in unsigned(7 downto 0)
    
  );
end pwm_servo;

architecture Behavioral of pwm_servo is

constant servo_pwm_period: integer:= 2000000; -- pwm period (20 ms for servo motor)
signal counter: integer range 0 to servo_pwm_period := 0; -- counting for pulse width calculation.
signal pulse_width: integer range 0 to servo_pwm_period/10 := 0; -- high period is 2 ms for maximum servo spin.
signal angle_safe : integer range 0 to 180 := 0;

begin
    process(clk) begin 
        if rising_edge(clk) then
            
            if (counter = servo_pwm_period -1) then
                counter <= 0;
            else 
                counter <= counter + 1;
            end if;
             if to_integer(angle) > 180 then
                angle_safe <= 180;
            else
                angle_safe <= to_integer(angle);
            end if;
            
            pulse_width <= 100000 + to_integer(angle)*140000 /180 ; -- exp: angle = 90 degree ==> 90* 1ms / 180 + 1 ms = 1.5 ms which is 90 degree for servo.INSTEAD OF 100000 WE PUT 140000 FOR ERROR PERCENTAGE OF SERVO

         
            if (counter < pulse_width) then
                pwm_out <= '1';
            else    pwm_out <= '0';   
            end if;
         end if;
   end process;
end Behavioral;
