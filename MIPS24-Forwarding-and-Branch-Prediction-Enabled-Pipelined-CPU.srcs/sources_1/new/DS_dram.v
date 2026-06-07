`timescale 1ns / 1ps

module DS_dram(
    A,
    Din,
    we,
    clk,
    D
    );
    input [9:0] A;
    input [31:0] Din;
    input we;
    input clk;
    output [31:0] D;
    
    dist_mem_gen_1 dram (
    .a(A),      // input wire [9 : 0] a
    .d(Din),      // input wire [31 : 0] d
    .clk(clk),  // input wire clk
    .we(we),    // input wire we
    .spo(D)  // output wire [31 : 0] spo
    );
    
endmodule