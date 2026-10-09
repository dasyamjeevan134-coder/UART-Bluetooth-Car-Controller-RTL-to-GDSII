`timescale 1ns/1ps

module bt_car_controller (
    input wire clk,
    input wire reset,
    input wire [7:0] command,
    input wire command_valid,
    output reg motor_left_a,
    output reg motor_left_b,
    output reg motor_right_a,
    output reg motor_right_b
);

    // Motor outputs are logic signals for a motor driver.
    // Do not connect motors directly to FPGA pins.

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            motor_left_a  <= 0;
            motor_left_b  <= 0;
            motor_right_a <= 0;
            motor_right_b <= 0;
        end else if (command_valid) begin
            case (command)
                "F": begin
                    motor_left_a  <= 1;
                    motor_left_b  <= 0;
                    motor_right_a <= 1;
                    motor_right_b <= 0;
                end

                "B": begin
                    motor_left_a  <= 0;
                    motor_left_b  <= 1;
                    motor_right_a <= 0;
                    motor_right_b <= 1;
                end

                "L": begin
                    motor_left_a  <= 0;
                    motor_left_b  <= 1;
                    motor_right_a <= 1;
                    motor_right_b <= 0;
                end

                "R": begin
                    motor_left_a  <= 1;
                    motor_left_b  <= 0;
                    motor_right_a <= 0;
                    motor_right_b <= 1;
                end

                "S": begin
                    motor_left_a  <= 0;
                    motor_left_b  <= 0;
                    motor_right_a <= 0;
                    motor_right_b <= 0;
                end

                default: begin
                    motor_left_a  <= 0;
                    motor_left_b  <= 0;
                    motor_right_a <= 0;
                    motor_right_b <= 0;
                end
            endcase
        end
    end
endmodule
