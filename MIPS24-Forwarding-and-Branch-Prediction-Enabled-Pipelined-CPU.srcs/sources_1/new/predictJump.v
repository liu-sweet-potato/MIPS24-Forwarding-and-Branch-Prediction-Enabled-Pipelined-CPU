`timescale 1ns / 1ps

module PredictJump(
    clk,
    rst,
    BranchSign,
    m,
    EXJump,   
    predict
    );
    
    input wire clk;
    input wire rst;
    input wire BranchSign;
    input wire m;
    input wire EXJump;   
    output wire[1:0] predict;
    
    wire[1:0] stateOut;
    
    Reg2 state(
    .din(stateOut),
    .en(BranchSign & m),
    .clk(clk),
    .rst(rst),
    .dout(predict)
    );
    
    // Ë«Î»Ô¤²â×´Ì¬»ú
    FSM FSM_0(
    .stateIn(predict),
    .EXJump(EXJump),
    .stateOut(stateOut)
    );
endmodule
