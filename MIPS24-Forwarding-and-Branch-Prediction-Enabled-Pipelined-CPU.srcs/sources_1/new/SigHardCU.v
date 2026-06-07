`timescale 1ns / 1ps

module SigHardCU(
    jmp,
    jr,
    SignedExt,
    OP,
    Func,
    BEQ,
    BNE,
    MemtoReg,
    MemWrite,
    ALU_OP,
    ALU_SRC,
    RegWrite,
    JAL,
    RegDst,
    SysCALL
    );
    
    output reg jmp;
    output reg jr;
    output reg SignedExt;
    input[5:0] OP;
    input[5:0] Func;
    output reg BEQ;
    output reg BNE;
    output reg MemtoReg;
    output reg MemWrite;
    output reg[3:0] ALU_OP;
    output reg ALU_SRC;
    output reg RegWrite;
    output reg JAL;
    output reg RegDst;
    output reg SysCALL;
    
    always @ (*)
        begin
            jmp = 0;
            jr = 0;
            SignedExt = 0;
            BEQ = 0;
            BNE = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALU_OP = 0;
            ALU_SRC = 0;
            RegWrite = 0;
            JAL = 0;
            RegDst = 0;
            SysCALL = 0;
        
            case(OP)
                6'd0: 
                    begin
                        case(Func)
                            6'd0:   // sll
                                begin
                                    ALU_OP = 4'd0;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd3:   // sra
                                begin
                                    ALU_OP = 4'd1;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd2:   // srl
                                begin
                                    ALU_OP = 4'd2;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd32:   // add
                                begin
                                    ALU_OP = 4'd5;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd33:   // addu
                                begin
                                    ALU_OP = 4'd5;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd34:   // sub
                                begin
                                    ALU_OP = 4'd6;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd36:   // and
                                begin
                                    ALU_OP = 4'd7;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd37:   // or
                                begin
                                    ALU_OP = 4'd8;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd39:   // or
                                begin
                                    ALU_OP = 4'd10;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd42:   // slt
                                begin
                                    ALU_OP = 4'd11;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd43:   // sltu
                                begin
                                    ALU_OP = 4'd12;
                                    RegWrite = 1'b1;
                                    RegDst = 1'b1;                                   
                                end
                            6'd8:   // jr
                                begin
                                    jr = 1'b1;                                  
                                end
                            6'd12:   // syscall
                                begin
                                    SysCALL = 1'b1;                                  
                                end
                        endcase
                    end
                6'd2:   // j
                    begin
                        jmp = 1'b1;
                    end
                6'd3:   // jal◊¢“‚’‚¿Ôjmp=1
                    begin
                        RegWrite = 1'b1;
                        jmp = 1'b1;
                        JAL = 1'b1;
                    end
                6'd4:   // beq
                    begin
                        BEQ = 1'b1;
                    end
                6'd5:   // bne
                    begin
                        BNE = 1'b1;
                    end
                6'd8:   // addi
                    begin
                        ALU_OP = 4'd5;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                        SignedExt = 1'b1;
                    end
                6'd12:   // andi
                    begin
                        ALU_OP = 4'd7;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                    end
                6'd9:   // addiu
                    begin
                        ALU_OP = 4'd5;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                        SignedExt = 1'b1;
                    end
                6'd10:   // slti
                    begin
                        ALU_OP = 4'd11;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                        SignedExt = 1'b1;
                    end
                6'd13:   // ori
                    begin
                        ALU_OP = 4'd8;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                    end
                6'd35:   // lw
                    begin
                        ALU_OP = 4'd5;
                        MemtoReg = 1'b1;
                        ALU_SRC = 1'b1;
                        RegWrite = 1'b1;
                        SignedExt = 1'b1;
                    end
                6'd43:   // sw
                    begin
                        ALU_OP = 4'd5;
                        MemWrite = 1'b1;
                        ALU_SRC = 1'b1;
                        SignedExt = 1'b1;
                    end
            endcase
        end
endmodule
