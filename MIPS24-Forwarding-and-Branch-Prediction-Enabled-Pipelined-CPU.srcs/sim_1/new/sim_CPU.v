`timescale 1ns / 1ps


module sim_CPU();
    reg clk;
    reg rst;
    wire [31:0] res;

CPU test(
    clk,
    rst,
    res
    );
initial
    begin
        # 0 clk <= 0;
        # 0 rst <= 1;
    end

always #5 clk <= ~clk;
endmodule
