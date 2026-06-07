`timescale 1ns / 1ps


module SrcReg(
    OP,
    Func,
    R1,
    R2
    );

    input[5:0] OP;
    input[5:0] Func;
    output reg R1;
    output reg R2;
    
    always @ (*)
        begin
            R1 = 1'b0;
            R2 = 1'b0;
    
            case(OP)
                6'd0: 
                    begin
                        case(Func)
                            6'd0:   // sll
                                begin
                                    R2 = 1'b1;                                   
                                end
                            6'd3:   // sra
                                begin
                                    R2 = 1'b1;                                
                                end
                            6'd2:   // srl
                                begin
                                    R2 = 1'b1;                                  
                                end
                            6'd32:   // add
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                    
                                end
                            6'd33:   // addu
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                   
                                end
                            6'd34:   // sub
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                   
                                end
                            6'd36:   // and
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                  
                                end
                            6'd37:   // or
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                   
                                end
                            6'd39:   // nor
                                begin
                                    R1 = 1'b1; 
                                    R2 = 1'b1;                                   
                                end
                            6'd42:   // slt
                                begin
                                    R1 = 1'b1;
                                    R2 = 1'b1;                                  
                                end
                            6'd43:   // sltu
                                begin
                                    R1 = 1'b1;
                                    R2 = 1'b1;                                   
                                end
                            6'd8:   // jr
                                begin
                                    R1 = 1'b1; 
                                end
                            6'd12:   // syscall注意这里r1r2都用到了
                                begin
                                    R1 = 1'b1;
                                    R2 = 1'b1;                                 
                                end
                        endcase
                    end
                6'd2:   // j
                    begin
                        
                    end
                6'd3:   // jal
                    begin
                        
                    end
                6'd4:   // beq
                    begin
                        R1 = 1'b1; 
                        R2 = 1'b1; 
                    end
                6'd5:   // bne
                    begin
                        R1 = 1'b1; 
                        R2 = 1'b1;
                    end
                6'd8:   // addi
                    begin
                        R1 = 1'b1; 
                    end
                6'd12:   // andi
                    begin
                        R1 = 1'b1; 
                    end
                6'd9:   // addiu
                    begin
                        R1 = 1'b1; 
                    end
                6'd10:   // slti
                    begin
                        R1 = 1'b1; 
                    end
                6'd13:   // ori
                    begin
                        R1 = 1'b1; 
                    end
                6'd35:   // lw
                    begin
                        R1 = 1'b1; 
                    end
                6'd43:   // sw
                    begin
                        R1 = 1'b1; 
                        R2 = 1'b1;
                    end
            endcase
        end
endmodule
