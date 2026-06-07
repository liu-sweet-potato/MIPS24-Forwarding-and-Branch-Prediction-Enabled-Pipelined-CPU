`timescale 1ns / 1ps


module sim_TOP();
reg clk=0, rst=1;
wire[3:0] sel_l, sel_r;

wire [7:0] seg_l, seg_r;

TOP test(
    clk,
    rst,
    sel_l,
    sel_r,
    seg_l,
    seg_r
    );

always #0.05 clk <= ~clk;
endmodule
