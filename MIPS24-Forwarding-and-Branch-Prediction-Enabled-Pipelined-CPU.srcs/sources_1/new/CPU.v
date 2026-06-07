`timescale 1ns / 1ps
    // Êý×ÖÏÔÊ¾
module CPU(
    input clk,
    input rst,
    output [31:0] res
    ); 
    
    // ËíµÀ
    wire halt, jr, jmp, branch, SignedExt, BEQ, BNE, MemtoReg, MemWrite, ALU_SRC, RegWrite, RegDst, JAL, SysCALL, EQ, LEDout, EXJump, EXjr, EXjmp, EXBEQ, EXBNE, EXMemtoReg, EXMemWrite, EXALU_SRC, EXRegWrite, EXRegDst, EXJAL, EXSysCALL, MEMMemtoReg, MEMMemWrite, MEMRegWrite, MEMJAL, MEMhalt, WBMemtoReg, WBRegWrite, WBJAL, WBhalt, loaduse, IFPredictJump, IDPredictJump, EXPredictJump, branchclr, _OF, _UOF;
    wire[1:0] R1Select, R2Select, EXR1Select, EXR2Select;
    wire[3:0] EXALU_OP, ALU_OP;
    wire[4:0] rs, rt, rd, shamt, R1A, R2A, WA, EXWA, EXshamt, MEMWA, WBWA;
    wire[5:0] OP, Func;
    wire[15:0] Imm16;
    wire[25:0] Imm26;
    wire[31:0] pcin, pcout, Instr, IDInstr, IDPC, IDPC4, Data, Imm, SignImm, Din, R, _R2, R1, R2, X, Y, A, B, BranchAddr, JumpAddr, EXPC, MEMPC, MEMALU_Result, MEMRt, WBALU_Result, WBPC, WBRS, RedirectR1, RedirectR2, Predictpcin;
    
    // ·ÖÖ§Ô¤²â»º³åÆ÷
    BTB BTB_0(
    .clk(clk),
    .rst(rst),
    .IFPC(pcout), 
    .EXPC(EXPC),
    .pcin(pcin),
    .BranchSign(EXjr | EXjmp | EXBEQ | EXBNE),
    .EXJump(EXJump),
    .IFPredictJump(IFPredictJump),
    .Predictpcin(Predictpcin)
    );
    
    // PC³ÌÐò¼ÆÊýÆ÷   
    assign pcin = EXjr ? RedirectR1 :
                  EXjmp ? JumpAddr :
                  branch ? BranchAddr :
                  EXPC + 32'h4;  // EXµØÖ·ÐÞ¶©
    
    Reg PC(
    .din(branchclr ? pcin : Predictpcin),
    .en(~(WBhalt | loaduse) ),
    .clk(clk),
    .rst(rst),
    .dout(pcout)
    );
    
    // Ö¸Áî´æ´¢Æ÷
    CS_dram rom(
    .A(pcout[11:2]),
    .D(Instr)
    );
//    dist_mem_gen_0 rom(
//    .a(pcout[11:2]),
//    .spo(Instr)
//    );     
    
    // IF / ID
    IFID IFID_0(
    .clk(clk),
    .en(loaduse),
    .bubble(branchclr),
    .RST(rst),
    .PCIn(pcout),
    .PC4In(pcout + 32'h4),
    .IRIn(Instr),
    .PredictJumpIn(IFPredictJump),
    .PCOut(IDPC),
    .PC4Out(IDPC4),
    .IROut(IDInstr),
    .PredictJumpOut(IDPredictJump)  
    );
    
    // µ¥ÖÜÆÚÓ²²¼Ïß¿ØÖÆÆ÷
    assign OP = IDInstr[31:26];
    assign Func = IDInstr[5:0];
    SigHardCU CU_0(
    .jmp(jmp),
    .jr(jr),
    .SignedExt(SignedExt),
    .OP(OP),
    .Func(Func),
    .BEQ(BEQ),
    .BNE(BNE),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALU_OP(ALU_OP),
    .ALU_SRC(ALU_SRC),
    .RegWrite(RegWrite),
    .JAL(JAL),
    .RegDst(RegDst),
    .SysCALL(SysCALL)
    );      
    
    // ¼Ä´æÆ÷¶Ñ
    assign rs = IDInstr[25:21];
    assign rt = IDInstr[20:16];
    assign rd = IDInstr[15:11];
    assign R1A = SysCALL ? 5'h2 : rs;
    assign R2A = SysCALL ? 5'h4 : rt;
    
    assign Din = WBJAL ? WBPC + 32'h4 : 
                  WBMemtoReg ? WBRS : WBALU_Result;
    RegFile RegFile_0(
    .R1A(R1A),
    .R2A(R2A),
    .WA(WBWA),
    .Din(Din),
    .WE(WBRegWrite),
    .CLK(clk),
    .R1(R1),
    .R2(R2)
    );
    
    // R1R2¼ì²â
    R1R2Detect R1R2Detect_0(
    .OP(OP),
    .Func(Func),
    .EXWA(EXWA),
    .MEMWA(MEMWA),
    .IDR1A(R1A),
    .IDR2A(R2A),
    .EXRegWrite(EXRegWrite),
    .MEMRegWrite(MEMRegWrite),
    .R1Select(R1Select),
    .R2Select(R2Select)
    );
    
    // loaduse¼ì²â
    LoaduseDetect Loaduse_0(
    .OP(OP),
    .Func(Func),
    .EXWA(EXWA),
    .IDR1A(R1A),
    .IDR2A(R2A),
    .EXMemtoReg(EXMemtoReg),
    .loaduse(loaduse)
    );
    
    // ID / EX
    assign shamt = IDInstr[10:6];
    assign WA = JAL ? 5'h1f : RegDst ? rd : rt;
    assign Imm16 = IDInstr[15:0];
    assign Imm26 = IDInstr[25:0];
    assign SignImm = {{16{Imm16[15]}},Imm16};
    IDEX IDEX_0(
    .clk(clk),
    .en(WBhalt),
    .bubble(branchclr | loaduse),
    .RST(rst),
    .PCIn(IDPC),
    .AIn(R1),
    .BIn(R2),
    .ImmIn(SignedExt ? SignImm : {16'h0, Imm16}),
    .BranchAddrIn(IDPC4 + (SignImm << 2)),
    .JumpAddrIn({IDPC4[31:28], Imm26, 2'b00}),
    .jmpIn(jmp),
    .jrIn(jr),
    .BEQIn(BEQ),
    .BNEIn(BNE),
    .MemtoRegIn(MemtoReg),
    .MemWriteIn(MemWrite),
    .ALU_OPIn(ALU_OP),
    .ALU_SRCIn(ALU_SRC),
    .RegWriteIn(RegWrite),
    .JALIn(JAL),
    .RegDstIn(RegDst),
    .SysCALLIn(SysCALL),
    .WAIn(WA),
    .shamtIn(shamt),
    .R1SelectIn(R1Select),
    .R2SelectIn(R2Select),
    .PredictJumpIn(IDPredictJump),
    .PCOut(EXPC),
    .AOut(A),
    .BOut(B), 
    .ImmOut(Imm), 
    .BranchAddrOut(BranchAddr),
    .JumpAddrOut(JumpAddr),
    .jmpOut(EXjmp),
    .jrOut(EXjr),
    .BEQOut(EXBEQ),
    .BNEOut(EXBNE),
    .MemtoRegOut(EXMemtoReg),
    .MemWriteOut(EXMemWrite),
    .ALU_OPOut(EXALU_OP),
    .ALU_SRCOut(EXALU_SRC),
    .RegWriteOut(EXRegWrite),
    .JALOut(EXJAL),
    .RegDstOut(EXRegDst),
    .SysCALLOut(EXSysCALL),
    .WAOut(EXWA),
    .shamtOut(EXshamt),
    .R1SelectOut(EXR1Select),
    .R2SelectOut(EXR2Select),
    .PredictJumpOut(EXPredictJump)
    );
    
    // ÔËËãÆ÷  
    assign RedirectR1 = (EXR1Select==2'b00) ? A :
                         (EXR1Select==2'b10) ? WBALU_Result :
                          MEMALU_Result;
     assign RedirectR2 = (EXR2Select==2'b00) ? B :
                          (EXR2Select==2'b10) ? WBALU_Result :
                           MEMALU_Result;
    
    assign X = RedirectR1;
    assign Y = EXALU_SRC ? Imm : 
               RedirectR2;
    ALU ALU_0(
    .X(X),
    .Y(Y),
    .S(EXALU_OP),
    .shamt(EXshamt),
    .E(EQ),
    .R(R),
    .R2(_R2),
    .OF(_OF),
    .UOF(_UOF)
    );
    
    // ·ÖÖ§
    assign branch = EXBEQ & EQ | EXBNE & ~EQ;
    assign EXJump = EXjr | EXjmp | branch;
    assign branchclr = (EXJump == EXPredictJump) ? 1'b0 : 1'b1;
        
    // Êä³ö¼Ä´æÆ÷
    assign LEDout = EXSysCALL & (RedirectR1==32'h22);
    Reg LED(
    .din(RedirectR2),
    .en(LEDout),
    .clk(clk),
    .rst(rst),
    .dout(res)
    );
    
    // EX / MEM
    assign halt = EXSysCALL & (RedirectR1!=32'h22);
    EXMEM EXMEM_0(
    .clk(clk),
    .en(WBhalt),
    .bubble(1'b0),
    .RST(rst),
    .PCIn(EXPC),
    .ALU_ResultIn(R),
    .RtIn(RedirectR2), 
    .MemtoRegIn(EXMemtoReg),
    .MemWriteIn(EXMemWrite),
    .RegWriteIn(EXRegWrite),
    .JALIn(EXJAL),
    .haltIn(halt),
    .WAIn(EXWA),
    .PCOut(MEMPC),
    .ALU_ResultOut(MEMALU_Result),
    .RtOut(MEMRt), 
    .MemtoRegOut(MEMMemtoReg),
    .MemWriteOut(MEMMemWrite),
    .RegWriteOut(MEMRegWrite),
    .JALOut(MEMJAL),
    .haltOut(MEMhalt),
    .WAOut(MEMWA)
    );
    
    // Êý¾Ý´æ´¢Æ÷
    DS_dram ram(
    .A(MEMALU_Result[11:2]),
    .Din(MEMRt),
    .we(MEMMemWrite),
    .clk(clk),
    .D(Data)
    );
    
    // MEMWB
    MEMWB MEMWB_0(
    .clk(clk),
    .en(WBhalt),
    .bubble(1'b0),
    .RST(rst),
    .PCIn(MEMPC),
    .ALU_ResultIn(MEMALU_Result),
    .RSIn(Data), 
    .MemtoRegIn(MEMMemtoReg),
    .RegWriteIn(MEMRegWrite),
    .JALIn(MEMJAL),
    .haltIn(MEMhalt),
    .WAIn(MEMWA),
    .PCOut(WBPC),
    .ALU_ResultOut(WBALU_Result),
    .RSOut(WBRS), 
    .MemtoRegOut(WBMemtoReg),
    .RegWriteOut(WBRegWrite),
    .JALOut(WBJAL),
    .haltOut(WBhalt),
    .WAOut(WBWA)
    );
    
endmodule