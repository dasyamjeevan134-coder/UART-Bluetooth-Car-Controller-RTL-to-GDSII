`timescale 1ns/1ps
module tb_uart_bt_car;
    reg clk=0, reset=1, bluetooth_rx=1;
    wire la,lb,ra,rb;
    integer errors=0;

    uart_bt_car_top #(.CLKS_PER_BIT(16)) dut (
        .clk(clk), .reset(reset), .bluetooth_rx(bluetooth_rx),
        .motor_left_a(la), .motor_left_b(lb),
        .motor_right_a(ra), .motor_right_b(rb)
    );

    always #5 clk=~clk;

    task send_byte(input [7:0] data);
        integer i;
        begin
            bluetooth_rx=0; repeat(16) @(posedge clk);
            for(i=0;i<8;i=i+1) begin
                bluetooth_rx=data[i]; repeat(16) @(posedge clk);
            end
            bluetooth_rx=1; repeat(20) @(posedge clk);
        end
    endtask

    task check(input [7:0] cmd, input [3:0] expected);
        begin
            send_byte(cmd);
            if ({la,lb,ra,rb} !== expected) begin
                $display("FAIL cmd=%c got=%b expected=%b",
                         cmd,{la,lb,ra,rb},expected);
                errors=errors+1;
            end else $display("PASS cmd=%c outputs=%b",
                              cmd,{la,lb,ra,rb});
        end
    endtask

    initial begin
        $dumpfile("simulation/uart_bt_car.vcd");
        $dumpvars(0, tb_uart_bt_car);
        repeat(4) @(posedge clk);
        reset=0;
        check("F",4'b1010);
        check("B",4'b0101);
        check("L",4'b0110);
        check("R",4'b1001);
        check("S",4'b0000);
        if(errors==0) $display("ALL TESTS PASSED");
        else $display("TEST FAILURES: %0d",errors);
        $finish;
    end
endmodule
