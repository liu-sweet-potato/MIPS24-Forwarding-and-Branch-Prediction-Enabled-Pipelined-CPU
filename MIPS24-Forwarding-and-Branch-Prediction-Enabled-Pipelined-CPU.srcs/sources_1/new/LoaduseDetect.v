`timescale 1ns / 1ps

module LoaduseDetect(
    OP,
    Func,
    EXWA,
    IDR1A,
    IDR2A,
    EXMemtoReg,
    loaduse
    );
    input[5:0] OP;
    input[5:0] Func;
    input [4:0] EXWA;
    input [4:0] IDR1A;
    input [4:0] IDR2A;
    input EXMemtoReg;
    output wire loaduse;
    
    wire R1, R2, EX1, EX2;
    
    SrcReg SrcReg_0(
    .OP(OP),
    .Func(Func),
    .R1(R1),
    .R2(R2)
    );

    assign EX1 = ~(EXWA==5'h0) & (IDR1A==EXWA) & EXMemtoReg & R1; 
    assign EX2 = ~(EXWA==5'h0) & (IDR2A==EXWA) & EXMemtoReg & R2;
    assign loaduse = EX1 | EX2;
endmodule
