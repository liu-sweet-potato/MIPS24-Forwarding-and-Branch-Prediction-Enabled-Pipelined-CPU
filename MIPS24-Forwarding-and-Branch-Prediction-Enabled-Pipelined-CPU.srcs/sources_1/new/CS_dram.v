`timescale 1ns / 1ps

module CS_dram(
    A,
    D
    );
    input [9:0] A; 
    output [31:0] D;  
    
    dist_mem_gen_0 rom (
    .a(A),      // input wire [9 : 0] a
    .spo(D)  // output wire [31 : 0] spo
    );
endmodule