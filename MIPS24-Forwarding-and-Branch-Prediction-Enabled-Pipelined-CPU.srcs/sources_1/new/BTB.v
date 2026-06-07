`timescale 1ns / 1ps

module BTB(
    clk,
    rst,
    IFPC, 
    EXPC,
    pcin,
    BranchSign,
    EXJump,
    IFPredictJump,
    Predictpcin
    );
    
    input wire clk;
    input wire rst;
    input wire[31:0] IFPC;
    input wire[31:0] EXPC;
    input wire[31:0] pcin;
    input wire BranchSign;
    input wire EXJump;
    output wire IFPredictJump;
    output wire[31:0] Predictpcin;
    
    // 隧道
    wire miss;
    reg write0, write1, write2, write3, write4, write5, write6, write7;
    wire L0, L1, L2, L3, L4, L5, L6, L7;
    wire v0, v1, v2, v3, v4, v5, v6, v7;
    wire m0, m1, m2, m3, m4, m5, m6, m7;
    wire[1:0] predict0, predict1, predict2, predict3, predict4, predict5, predict6, predict7;
    wire[2:0] num;
    wire[31:0] tag0, tag1, tag2, tag3, tag4, tag5, tag6, tag7;
    wire[31:0] Addr0, Addr1, Addr2, Addr3, Addr4, Addr5, Addr6, Addr7;
    wire[31:0] count0, count1, count2, count3, count4, count5, count6, count7;
    
    // 8路全相联Cache
    Line Line_0(
    .clk(clk),
    .RST(rst),
    .write(write0),
    .L(L0), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v0),
    .tagOut(tag0),
    .AddrOut(Addr0),
    .countOut(count0)
    );
    
    Line Line_1(
    .clk(clk),
    .RST(rst),
    .write(write1),
    .L(L1), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v1),
    .tagOut(tag1),
    .AddrOut(Addr1),
    .countOut(count1)
    );
    
    Line Line_2(
    .clk(clk),
    .RST(rst),
    .write(write2),
    .L(L2), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v2),
    .tagOut(tag2),
    .AddrOut(Addr2),
    .countOut(count2)
    );
    
    Line Line_3(
    .clk(clk),
    .RST(rst),
    .write(write3),
    .L(L3), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v3),
    .tagOut(tag3),
    .AddrOut(Addr3),
    .countOut(count3)
    );
    
    Line Line_4(
    .clk(clk),
    .RST(rst),
    .write(write4),
    .L(L4), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v4),
    .tagOut(tag4),
    .AddrOut(Addr4),
    .countOut(count4)
    );
    
    Line Line_5(
    .clk(clk),
    .RST(rst),
    .write(write5),
    .L(L5), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v5),
    .tagOut(tag5),
    .AddrOut(Addr5),
    .countOut(count5)
    );
    
    Line Line_6(
    .clk(clk),
    .RST(rst),
    .write(write6),
    .L(L6), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v6),
    .tagOut(tag6),
    .AddrOut(Addr6),
    .countOut(count6)
    );
    
    Line Line_7(
    .clk(clk),
    .RST(rst),
    .write(write7),
    .L(L7), 
    .tagIn(EXPC), 
    .AddrIn(pcin), 
    .validOut(v7),
    .tagOut(tag7),
    .AddrOut(Addr7),
    .countOut(count7)
    );
    
    // 并行比较逻辑
    assign L0 = v0 & (IFPC == tag0);
    assign L1 = v1 & (IFPC == tag1);
    assign L2 = v2 & (IFPC == tag2);
    assign L3 = v3 & (IFPC == tag3);
    assign L4 = v4 & (IFPC == tag4);
    assign L5 = v5 & (IFPC == tag5);
    assign L6 = v6 & (IFPC == tag6);
    assign L7 = v7 & (IFPC == tag7);
    
    assign Predictpcin = L0 ? Addr0 :
                         L1 ? Addr1 :
                         L2 ? Addr2 :
                         L3 ? Addr3 :
                         L4 ? Addr4 :
                         L5 ? Addr5 :
                         L6 ? Addr6 :
                         L7 ? Addr7 :
                         IFPC + 32'h4;
    // 预测逻辑
    assign IFPredictJump = L0 ? predict0[1] :
                           L1 ? predict1[1] :
                           L2 ? predict2[1] :
                           L3 ? predict3[1] :
                           L4 ? predict4[1] :
                           L5 ? predict5[1] :
                           L6 ? predict6[1] :
                           L7 ? predict7[1] :
                           1'b0;
                           
    // 判断命中
    assign m0 = v0 & (EXPC == tag0);
    assign m1 = v1 & (EXPC == tag1);
    assign m2 = v2 & (EXPC == tag2);
    assign m3 = v3 & (EXPC == tag3);
    assign m4 = v4 & (EXPC == tag4);
    assign m5 = v5 & (EXPC == tag5);
    assign m6 = v6 & (EXPC == tag6);
    assign m7 = v7 & (EXPC == tag7);
    
    assign miss = ~(m0 | m1 | m2 | m3 | m4 | m5 | m6 | m7);
    
    // LRU算法
    MAX8 MAX8_0(
    .count0(count0),
    .count1(count1),
    .count2(count2),
    .count3(count3),
    .count4(count4),
    .count5(count5),
    .count6(count6),
    .count7(count7),
    .num(num)
    );
   
   // 写入逻辑
    always @ (v0, v1, v2, v3, v4, v5, v6, v7, num, miss, BranchSign)
        begin
            write0 = 1'b0;
            write1 = 1'b0;
            write2 = 1'b0;
            write3 = 1'b0;
            write4 = 1'b0;
            write5 = 1'b0;
            write6 = 1'b0;
            write7 = 1'b0;           
            if(miss & BranchSign)
                if(~v0)
                    write0 = 1'b1;
                else if(~v1)
                    write1 = 1'b1;
                else if(~v2)
                    write2 = 1'b1;
                else if(~v3)
                    write3 = 1'b1;
                else if(~v4)
                    write4 = 1'b1;
                else if(~v5)
                    write5 = 1'b1;
                else if(~v6)
                    write6 = 1'b1;
                else if(~v7)
                    write7 = 1'b1;
                else 
                    case(num)
                        3'd0:
                            write0 = 1'b1;
                        3'd1:
                            write1 = 1'b1;
                        3'd2:
                            write2 = 1'b1;
                        3'd3:
                            write3 = 1'b1;
                        3'd4:
                            write4 = 1'b1;
                        3'd5:
                            write5 = 1'b1;
                        3'd6:
                            write6 = 1'b1;
                        3'd7:
                            write7 = 1'b1;
                    endcase
        end
    
    // 动态分支预测
    PredictJump PredictJump_0(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m0),
    .EXJump(EXJump),   
    .predict(predict0)
    );
    
    PredictJump PredictJump_1(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m1),
    .EXJump(EXJump),   
    .predict(predict1)
    );
    
    PredictJump PredictJump_2(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m2),
    .EXJump(EXJump),   
    .predict(predict2)
    );
    
    PredictJump PredictJump_3(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m3),
    .EXJump(EXJump),   
    .predict(predict3)
    );
    
    PredictJump PredictJump_4(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m4),
    .EXJump(EXJump),   
    .predict(predict4)
    );
    
    PredictJump PredictJump_5(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m5),
    .EXJump(EXJump),   
    .predict(predict5)
    );
    
    PredictJump PredictJump_6(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m6),
    .EXJump(EXJump),   
    .predict(predict6)
    );
    
    PredictJump PredictJump_7(
    .clk(clk),
    .rst(rst),
    .BranchSign(BranchSign),
    .m(m7),
    .EXJump(EXJump),   
    .predict(predict7)
    );
    
    
endmodule
