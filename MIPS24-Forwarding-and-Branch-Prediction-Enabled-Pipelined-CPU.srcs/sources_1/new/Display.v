`timescale 1ns / 1ps
    // 数字显示
module  Display(
    clk_1ms, 
    res, 
    sel_l, 
    sel_r, 
    seg_l, 
    seg_r
    );   
    
    // 管脚
    input wire clk_1ms;                     // 时钟信号 
    input wire[31:0] res;                   // 输入数字
    output wire[3:0] sel_l, sel_r;          // 4位片选信号
    output wire[7:0] seg_l, seg_r;          // 7位数码管控制信号
    wire[31:0] din;
    // 7段数码管译码
    wire[6:0] x1, x2, x3, x4;
    wire[6:0] x5, x6, x7, x8;
    
    assign din = res;
    seg7 U1(.din(din[3:0]), .dout(x1));
    seg7 U2(.din(din[7:4]), .dout(x2));
    seg7 U3(.din(din[11:8]), .dout(x3));
    seg7 U4(.din(din[15:12]), .dout(x4));
    
    seg7 U5(.din(din[19:16]), .dout(x5));
    seg7 U6(.din(din[23:20]), .dout(x6));
    seg7 U7(.din(din[27:24]), .dout(x7));
    seg7 U8(.din(din[31:28]), .dout(x8));
    
    // 循环左移输出数字位
    reg[3:0] shift = 4'b0001;
    always @(posedge clk_1ms)
        begin
            shift <= {shift[2:0], shift[3]};
        end
    
    // 4位片选信号（掩码可选）
    assign sel_r = shift & 4'b1111;
    assign sel_l = shift & 4'b1111;
    
    // 7位数码管控制信号
    wire[6:0] seg_low_r, seg_low_l;
    assign seg_low_r = (shift == 4'b0001)?x1:
                    (shift == 4'b0010)?x2:
                    (shift == 4'b0100)?x3:
                    (shift == 4'b1000)?x4:0;
    assign seg_r = {1'b0, seg_low_r};           // 小数点默认不显示
    
    assign seg_low_l = (shift == 4'b0001)?x5:
                    (shift == 4'b0010)?x6:
                    (shift == 4'b0100)?x7:
                    (shift == 4'b1000)?x8:0;
    assign seg_l = {1'b0, seg_low_l};           // 小数点默认不显示
                    
endmodule