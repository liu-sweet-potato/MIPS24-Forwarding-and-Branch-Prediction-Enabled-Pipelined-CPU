`timescale 1ns / 1ps

module Reg5(
    din,
    en,
    rst,
    clk,
    dout
    );
    input wire[4:0] din;
    input en;
    input rst;
    input clk;
    output reg[4:0] dout=5'b00000;
    
    always @ (posedge clk, negedge rst)
        begin
            if(~rst)
                dout <= 5'b00000;
            else
                if(en)
                    dout <= din;
        end
endmodule

