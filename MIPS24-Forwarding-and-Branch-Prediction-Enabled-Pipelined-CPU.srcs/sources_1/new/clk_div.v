`timescale 1ns / 1ps

// Ê±ÖÓ½µÆµ
module clk_div(
    clk, 
    clk_1ms, 
    clk_10ms,
    clk_100ms,
    clk_1s
    );
    
    input wire clk;                         // Ð¾Æ¬»ù´¡Ê±ÖÓÆµÂÊ100MHZ
    output reg clk_1ms=1'b0;
    output reg clk_10ms=1'b0;
    output reg clk_100ms=1'b0;
    output reg clk_1s=1'b0;
    
    reg[31:0] cnt_1ms=0;
    always @(posedge clk)
        begin
            if(cnt_1ms<=49_999)
                begin
                    cnt_1ms <= cnt_1ms + 1'b1;
                end
            else
                begin
                    cnt_1ms <= 0;
                    clk_1ms <= ~clk_1ms;
                end    
        end
        
    reg[31:0] cnt_10ms=0;
    always @(posedge clk)
        begin
            if(cnt_10ms<=499_999)
                begin
                    cnt_10ms <= cnt_10ms + 1'b1;
                end
            else
                begin
                    cnt_10ms <= 0;
                    clk_10ms <= ~clk_10ms;
                end    
        end
    
    reg[31:0] cnt_100ms=0;
    always @(posedge clk)
        begin
            if(cnt_100ms<=4_999_999)
                begin
                    cnt_100ms <= cnt_100ms + 1'b1;
                end
            else
                begin
                    cnt_100ms <= 0;
                    clk_100ms <= ~clk_100ms;
                end    
        end
        
    reg[31:0] cnt_1s=0;
    always @(posedge clk)
        begin
            if(cnt_1s<=49_999_999)
                begin
                    cnt_1s <= cnt_1s + 1'b1;
                end
            else
                begin
                    cnt_1s <= 0;
                    clk_1s <= ~clk_1s;
                end
        end   
endmodule