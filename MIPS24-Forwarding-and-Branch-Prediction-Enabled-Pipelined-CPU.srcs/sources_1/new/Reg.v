`timescale 1ns / 1ps

module Reg(
    din,
    en,
    clk,
    rst,
    dout
    );
    input [31:0] din;
    input en;
    input clk;
    input rst;
    output reg[31:0] dout;
    
    initial
        begin
            dout <= 32'h0;
        end
    
    always @ (posedge clk, negedge rst)
        begin
            if(~rst) 
                dout <= 32'h0;
            else
                if(en)
                    dout <= din;
        end
endmodule