module uart_bt_car_top #(
    parameter CLKS_PER_BIT = 16
)(
    input wire clk,
    input wire reset,
    input wire bluetooth_rx,
    output wire motor_left_a,
    output wire motor_left_b,
    output wire motor_right_a,
    output wire motor_right_b
);
    wire [7:0] command;
    wire command_valid;

    uart_rx #(.CLKS_PER_BIT(CLKS_PER_BIT)) RX (
        .clk(clk), .reset(reset), .rx(bluetooth_rx),
        .data_out(command), .data_valid(command_valid)
    );

    bt_car_controller CTRL (
        .clk(clk), .reset(reset),
        .command(command), .command_valid(command_valid),
        .motor_left_a(motor_left_a), .motor_left_b(motor_left_b),
        .motor_right_a(motor_right_a), .motor_right_b(motor_right_b)
    );
endmodule
