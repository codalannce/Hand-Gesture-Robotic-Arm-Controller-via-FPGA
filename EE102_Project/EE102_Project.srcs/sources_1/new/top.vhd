

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
  Port ( 
    basys_clk: in std_logic;
    rx: in std_logic;
    servo_pitch_angle: out std_logic;
    servo_roll_angle: out std_logic;
    servo_yaw_angle: out std_logic
  );
end top;

architecture Behavioral of top is

signal raw_angle: std_logic_vector(7 downto 0);
signal s1, s2, s3:  std_logic_vector(7 downto 0);
signal angle1, angle2, angle3:  unsigned(7 downto 0);
signal rx_valid: std_logic;

begin
    
    uart_inst: entity work.uart
        port map(
        rx  => rx,
        clk => basys_clk,
        data => raw_angle,
        rx_stop  => rx_valid
        );
             
    packet_fsm_inst: entity work.packet_fsm
        port map(
            clk  => basys_clk,
            rx_data  => raw_angle,
            servo_pitch_angle  => s1,
            servo_yaw_angle  => s2,
            servo_roll_angle  => s3,
            rx_valid  => rx_valid
        );
       
    angle_mapping_inst_servo1: entity work.AngleMapping
        port map(
            raw_angle => signed(s1),
            servo_angle => angle1
            );        
    pwm_servo_inst_servo1: entity work.pwm_servo
        port map(
            clk => basys_clk,
            angle => angle1,
            pwm_out => servo_pitch_angle
        );
    
        
    angle_mapping_inst_servo2: entity work.AngleMapping
        port map(
            raw_angle => signed(s2),
            servo_angle => angle2
            );        
    pwm_servo_inst_servo2: entity work.pwm_servo
        port map(
            clk => basys_clk,
            angle => angle2,
            pwm_out => servo_yaw_angle
        );
        
     angle_mapping_inst_servo3: entity work.AngleMapping
        port map(
            raw_angle => signed(s3),
            servo_angle => angle3
            );           

    pwm_servo_inst_servo3: entity work.pwm_servo
        port map(
            clk => basys_clk,
            angle => angle3,
            pwm_out => servo_roll_angle
        );
        
        
end Behavioral;
