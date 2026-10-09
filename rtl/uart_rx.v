`timescale 1ns/1ps

module uart_rx #(
    parameter CLKS_PER_BIT = 434
)(
    input wire clk,
    input wire reset,
    input wire rx,
    output reg [7:0] data_out,
    output reg data_valid
);

    localparam IDLE  = 2'd0;
    localparam START = 2'd1;
    localparam DATA  = 2'd2;
    localparam STOP  = 2'd3;

    reg [1:0] state;
    reg [15:0] count;
    reg [2:0] bit_index;
    reg [7:0] shift_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            count <= 0;
            bit_index <= 0;
            shift_reg <= 0;
            data_out <= 0;
            data_valid <= 0;
        end else begin
            data_valid <= 0;

            case (state)
                IDLE: begin
                    count <= 0;
                    bit_index <= 0;
                    if (!rx)
                        state <= START;
                end

                START: begin
                    if (count == (CLKS_PER_BIT/2)-1) begin
                        count <= 0;
                        if (!rx)
                            state <= DATA;
                        else
                            state <= IDLE;
                    end else
                        count <= count + 1;
                end

                DATA: begin
                    if (count == CLKS_PER_BIT-1) begin
                        count <= 0;
                        shift_reg[bit_index] <= rx;

                        if (bit_index == 7)
                            state <= STOP;
                        else
                            bit_index <= bit_index + 1;
                    end else
                        count <= count + 1;
                end

                STOP: begin
                    if (count == CLKS_PER_BIT-1) begin
                        count <= 0;
                        state <= IDLE;
                        data_out <= shift_reg;
                        data_valid <= 1;
                    end else
                        count <= count + 1;
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule
