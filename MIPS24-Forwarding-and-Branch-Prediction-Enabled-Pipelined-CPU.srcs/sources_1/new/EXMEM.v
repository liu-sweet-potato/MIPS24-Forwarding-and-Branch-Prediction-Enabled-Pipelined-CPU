`timescale 1ns / 1ps

module EXMEM(
    clk,
    en,
    bubble,
    RST,
    PCIn,
    ALU_ResultIn,
    RtIn,
    MemtoRegIn,
    MemWriteIn,
    RegWriteIn,
    JALIn,
    haltIn,
    WAIn,
    PCOut,
    ALU_ResultOut,
    RtOut, 
    MemtoRegOut,
    MemWriteOut,
    RegWriteOut,
    JALOut,
    haltOut,
    WAOut
    );
    
    input clk;
    input en;
    input bubble;
    input RST;
    input wire[31:0] PCIn;
    input wire[31:0] ALU_ResultIn;
    input wire[31:0] RtIn;
    input wire MemtoRegIn;
    input wire MemWriteIn;
    input wire RegWriteIn;
    input wire JALIn;
    input wire haltIn;
    input wire[4:0] WAIn;
    output wire[31:0] PCOut;
    output wire[31:0] ALU_ResultOut;
    output wire[31:0] RtOut;
    output wire MemtoRegOut;
    output wire MemWriteOut;
    output wire RegWriteOut;
    output wire JALOut;
    output wire haltOut;
    output wire[4:0] WAOut;
    
    // Õ¨≤Ω«Â¡„
    Reg PC(
    .din(bubble ? 32'h0 : PCIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PCOut)
    );
    
    Reg ALU_Result(
    .din(bubble ? 32'h0 : ALU_ResultIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(ALU_ResultOut)
    );
    
    Reg Rt(
    .din(bubble ? 32'h0 : RtIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(RtOut)
    );
    
    
    Reg1 MemtoReg(
    .din(bubble ? 1'b0 : MemtoRegIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(MemtoRegOut)
    );
    
    Reg1 MemWrite(
    .din(bubble ? 1'b0 : MemWriteIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(MemWriteOut)
    );
    
    
    Reg1 RegWrite(
    .din(bubble ? 1'b0 : RegWriteIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(RegWriteOut)
    );
    
    Reg1 JAL(
    .din(bubble ? 1'b0 : JALIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(JALOut)
    );
    
    
    Reg1 halt(
    .din(bubble ? 1'b0 : haltIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(haltOut)
    );
    
    Reg5 WA(
    .din(bubble ? 5'b00000 : WAIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(WAOut)
    );
    
endmodule