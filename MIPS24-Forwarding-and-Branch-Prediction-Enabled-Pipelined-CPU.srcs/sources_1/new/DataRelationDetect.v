`timescale 1ns / 1ps


module R1R2Detect(
    OP,
    Func,
    EXWA,
    MEMWA,
    IDR1A,
    IDR2A,
    EXRegWrite,
    MEMRegWrite,
    R1Select,
    R2Select
    );
    input[5:0] OP;
    input[5:0] Func;
    input [4:0] EXWA;
    input [4:0] MEMWA;
    input [4:0] IDR1A;
    input [4:0] IDR2A;
    input EXRegWrite;
    input MEMRegWrite;
    output wire[1:0] R1Select;
    output wire[1:0] R2Select;
    
    wire R1, R2, EX1, EX2, MEM1, MEM2;
    
    SrcReg SrcReg_0(
    .OP(OP),
    .Func(Func),
    .R1(R1),
    .R2(R2)
    );

    assign EX1 = ~(EXWA==5'h0) & (IDR1A==EXWA) & EXRegWrite & R1; 
    assign EX2 = ~(EXWA==5'h0) & (IDR2A==EXWA) & EXRegWrite & R2;
    assign MEM1 = ~(MEMWA==5'h0) & (IDR1A==MEMWA) & MEMRegWrite & R1; 
    assign MEM2 = ~(MEMWA==5'h0) & (IDR2A==MEMWA) & MEMRegWrite & R2;
    assign R1Select = {MEM1, EX1};
    assign R2Select = {MEM2, EX2};
    
endmodule
