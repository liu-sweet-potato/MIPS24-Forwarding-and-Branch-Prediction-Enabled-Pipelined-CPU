`timescale 1ns / 1ps

module Line(
    clk,
    RST,
    write,
    L, 
    tagIn, 
    AddrIn, 
    validOut,
    tagOut,
    AddrOut,
    countOut
    );
    
    input wire clk;
    input wire RST;
    input wire write;
    input wire L;   
    input wire[31:0] tagIn;
    input wire[31:0] AddrIn;
    output wire validOut;
    output wire[31:0] tagOut;
    output wire[31:0] AddrOut;
    output wire[31:0] countOut;
    
    wire Resetc;
    
    parameter ENA=1'b1;
    
//    reg [31:0] count_reg;
//    always @(posedge clk) begin
//      if (~RST)               // global active-low reset
//        count_reg <= 32'h0;
//      else if (write | L)     // Í¬²½ÇåÁã
//        count_reg <= 32'h0;
//      else
//        count_reg <= count_reg + 32'h1;
//    end
//    assign countOut = count_reg;

    Reg1 countReset(
     .din(write | L), 
     .en(ENA), 
     .clk(clk), 
     .rst(RST), 
     .dout(Resetc) );
     
    Reg count( 
    .din(countOut + 32'h1), 
    .en(ENA), 
    .clk(clk), 
    .rst(~Resetc),
    .dout(countOut)
    );
    
    Reg1 valid(
    .din(1'b1),
    .en(write),
    .clk(clk),
    .rst(RST),
    .dout(validOut)
    );
    
    Reg tag(
    .din(tagIn),
    .en(write),
    .clk(clk),
    .rst(RST),
    .dout(tagOut)
    );
      
    Reg Addr(
    .din(AddrIn),
    .en(write),
    .clk(clk),
    .rst(RST),
    .dout(AddrOut)
    );
endmodule
