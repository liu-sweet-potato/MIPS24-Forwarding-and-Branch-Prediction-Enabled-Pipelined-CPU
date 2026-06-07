`timescale 1ns / 1ps

module IFID(
    clk,
    en,
    bubble,
    RST,
    PCIn,
    PC4In,
    IRIn,
    PredictJumpIn,
    PCOut,
    PC4Out,
    IROut,
    PredictJumpOut  
    );
    
    input clk;
    input en;
    input bubble;
    input RST;
    input wire[31:0] PCIn;
    input wire[31:0] PC4In;
    input wire[31:0] IRIn;
    input wire PredictJumpIn;
    output wire[31:0] PCOut;
    output wire[31:0] PC4Out;
    output wire[31:0] IROut;
    output wire PredictJumpOut;
    
    // Õ¨≤Ω«Â¡„
    Reg PC(
    .din(bubble ? 32'h0 : PCIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PCOut)
    );
    
    Reg PC4(
    .din(bubble ? 32'h0 : PC4In),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PC4Out)
    );
    
    Reg IR(
    .din(bubble ? 32'h0 : IRIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(IROut)
    );
    
    Reg1 PredictJump(
    .din(bubble ? 1'b0 : PredictJumpIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PredictJumpOut)
    );
endmodule