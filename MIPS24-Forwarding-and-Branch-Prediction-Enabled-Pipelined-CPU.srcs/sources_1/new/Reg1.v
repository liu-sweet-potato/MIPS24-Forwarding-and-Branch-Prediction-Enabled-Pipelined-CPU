`timescale 1ns / 1ps

module Reg1(
    din,
    en,
    clk,
    rst,
    dout
    );
    input din;
    input en;
    input clk;
    input rst;
    output reg dout=1'b0;
    
    always @ (posedge clk, negedge rst)
        begin
            if(~rst) 
                dout <= 1'b0;
            else
                if(en)
                    dout <= din;
        end
endmodule
