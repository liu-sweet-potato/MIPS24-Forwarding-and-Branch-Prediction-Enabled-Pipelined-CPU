`timescale 1ns / 1ps

module Reg4(
    din,
    en,
    clk,
    rst,
    dout
    );
    input wire[3:0] din;
    input en;
    input clk;
    input rst;
    output reg[3:0] dout=4'b0000;
    
    always @ (posedge clk, negedge rst)
        begin
            if(~rst) 
                dout <= 4'b0000;
            else
                if(en)
                    dout <= din;
        end
endmodule

