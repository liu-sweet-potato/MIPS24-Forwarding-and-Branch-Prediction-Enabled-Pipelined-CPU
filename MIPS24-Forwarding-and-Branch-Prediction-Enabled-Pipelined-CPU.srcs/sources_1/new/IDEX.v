`timescale 1ns / 1ps

module IDEX(
    clk,
    en,
    bubble,
    RST,
    PCIn,
    AIn,
    BIn,
    ImmIn,
    BranchAddrIn,
    JumpAddrIn,
    jmpIn,
    jrIn,
    BEQIn,
    BNEIn,
    MemtoRegIn,
    MemWriteIn,
    ALU_OPIn,
    ALU_SRCIn,
    RegWriteIn,
    JALIn,
    RegDstIn,
    SysCALLIn,
    WAIn,
    shamtIn,
    R1SelectIn,
    R2SelectIn,
    PredictJumpIn,
    PCOut,
    AOut,
    BOut, 
    ImmOut, 
    BranchAddrOut,
    JumpAddrOut,
    jmpOut,
    jrOut,
    BEQOut,
    BNEOut,
    MemtoRegOut,
    MemWriteOut,
    ALU_OPOut,
    ALU_SRCOut,
    RegWriteOut,
    JALOut,
    RegDstOut,
    SysCALLOut,
    WAOut,
    shamtOut,
    R1SelectOut,
    R2SelectOut,
    PredictJumpOut 
    );
    
    input clk;
    input en;
    input bubble;
    input RST;
    input wire[31:0] PCIn;
    input wire[31:0] AIn;
    input wire[31:0] BIn;
    input wire[31:0] ImmIn;
    input wire[31:0] BranchAddrIn;
    input wire[31:0] JumpAddrIn;
    input wire jmpIn;
    input wire jrIn;
    input wire BEQIn;
    input wire BNEIn;
    input wire MemtoRegIn;
    input wire MemWriteIn;
    input wire[3:0] ALU_OPIn;
    input wire ALU_SRCIn;
    input wire RegWriteIn;
    input wire JALIn;
    input wire RegDstIn;
    input wire SysCALLIn;
    input wire[4:0] WAIn;
    input wire[4:0] shamtIn;
    input wire[1:0] R1SelectIn;
    input wire[1:0] R2SelectIn;
    input wire PredictJumpIn;
    output wire[31:0] PCOut;
    output wire[31:0] AOut;
    output wire[31:0] BOut;
    output wire[31:0] ImmOut;
    output wire[31:0] BranchAddrOut;
    output wire[31:0] JumpAddrOut;
    output wire jmpOut;
    output wire jrOut;
    output wire BEQOut;
    output wire BNEOut;
    output wire MemtoRegOut;
    output wire MemWriteOut;
    output wire[3:0] ALU_OPOut;
    output wire ALU_SRCOut;
    output wire RegWriteOut;
    output wire JALOut;
    output wire RegDstOut;
    output wire SysCALLOut;
    output wire[4:0] WAOut;
    output wire[4:0] shamtOut;
    output wire[1:0] R1SelectOut;
    output wire[1:0] R2SelectOut;
    output wire PredictJumpOut;
    
    // Õ¨≤Ω«Â¡„
    Reg PC(
    .din(bubble ? 32'h0 : PCIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PCOut)
    );
    
    Reg A(
    .din(bubble ? 32'h0 : AIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(AOut)
    );
    
    Reg B(
    .din(bubble ? 32'h0 : BIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(BOut)
    );
    
    Reg Imm(
    .din(bubble ? 32'h0 : ImmIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(ImmOut)
    );
    
    Reg BranchAddr(
    .din(bubble ? 32'h0 : BranchAddrIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(BranchAddrOut)
    );
    
    Reg JumpAddr(
    .din(bubble ? 32'h0 : JumpAddrIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(JumpAddrOut)
    );
    
    Reg1 jmp(
    .din(bubble ? 1'b0 : jmpIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(jmpOut)
    );
    
    Reg1 jr(
    .din(bubble ? 1'b0 : jrIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(jrOut)
    );
    
    Reg1 BEQ(
    .din(bubble ? 1'b0 : BEQIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(BEQOut)
    );
    
    Reg1 BNE(
    .din(bubble ? 1'b0 : BNEIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(BNEOut)
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
    
    Reg4 ALU_OP(
    .din(bubble ? 4'b0000 : ALU_OPIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(ALU_OPOut)
    );
    
    Reg1 ALU_SRC(
    .din(bubble ? 1'b0 : ALU_SRCIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(ALU_SRCOut)
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
    
    Reg1 RegDst(
    .din(bubble ? 1'b0 : RegDstIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(RegDstOut)
    );
    
    Reg1 SysCALL(
    .din(bubble ? 1'b0 : SysCALLIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(SysCALLOut)
    );
    
    Reg5 WA(
    .din(bubble ? 5'b00000 : WAIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(WAOut)
    );
    
    Reg5 shamt(
    .din(bubble ? 5'b00000 : shamtIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(shamtOut)
    );
    
    Reg2 R1Select(
    .din(bubble ? 2'b00 : R1SelectIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(R1SelectOut)
    );
    
    Reg2 R2Select(
    .din(bubble ? 2'b00 : R2SelectIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(R2SelectOut)
    );
    
    Reg1 PredictJump(
    .din(bubble ? 1'b0 : PredictJumpIn),
    .en(~en),
    .clk(clk),
    .rst(RST),
    .dout(PredictJumpOut)
    );
endmodule