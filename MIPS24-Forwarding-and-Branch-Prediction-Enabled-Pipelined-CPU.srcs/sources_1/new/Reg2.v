`timescale 1ns / 1ps

module Reg2(
    din,
    en,
    clk,
    rst,
    dout
    );
    input wire[1:0] din;
    input en;
    input clk;
    input rst;
    output reg[1:0] dout=2'b00;
    
    always @ (posedge clk, negedge rst)
        begin
            if(~rst) 
                dout <= 2'b00;
            else
                if(en)
                    dout <= din;
        end
endmodule
