`timescale 1ns / 1ps

    // 顶层模块
module TOP(
    input clk,
    input rst,
    output [3:0] sel_l,
    output [3:0] sel_r,
    output [7:0] seg_l,
    output [7:0] seg_r
    );
    
    // 隧道
    wire [31:0] result;
    wire clk_1ms, clk_10ms, clk_100ms, clk_1s;
    
    // 时钟分频（CPU运算速度必须小于1kHZ / 4）
    clk_div clk_0(
    .clk(clk),
    .clk_1ms(clk_1ms),
    .clk_10ms(clk_10ms),
    .clk_100ms(clk_100ms),
    .clk_1s(clk_1s)
    );
    
    // 硬布线单周期CPU
    CPU cpu_0(
    .clk(clk_10ms), 
    .rst(rst),
    .res(result)
    );

    // 7端数码管显示
    Display dis_0(
    .clk_1ms(clk_1ms),
    .res(result), 
    .sel_l(sel_l), 
    .sel_r(sel_r), 
    .seg_l(seg_l), 
    .seg_r(seg_r)
     );

endmodule