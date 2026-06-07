`timescale 1ns / 1ps

module FSM(
    stateIn,
    EXJump,
    stateOut
    );
    
    input wire[1:0] stateIn;
    input wire EXJump;
    output reg[1:0] stateOut;
    
    always @ (*)
        begin
            stateOut = 2'b00;
            case(stateIn)
                2'b00:
                    if(EXJump)
                        stateOut = 2'b01;
                    else
                        stateOut = 2'b00;
                2'b01:
                    if(EXJump)
                        stateOut = 2'b10;
                    else
                        stateOut = 2'b00;
                2'b10:
                    if(EXJump)
                        stateOut = 2'b11;
                    else
                        stateOut = 2'b01;
                2'b11:
                    if(EXJump)
                        stateOut = 2'b11;
                    else
                        stateOut = 2'b10;
            endcase
        end
        
endmodule
