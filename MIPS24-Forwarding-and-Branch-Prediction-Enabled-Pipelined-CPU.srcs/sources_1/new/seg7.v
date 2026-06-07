`timescale 1ns / 1ps

// 7∂Œ ˝¬Îπ‹“Î¬Î∆˜
module seg7(din, dout);
    
    input  wire[3:0] din;
    output reg[6:0] dout;
    always @(*)
        begin
            case(din)
                4'b0000: dout = 7'b011_1111;
                4'b0001: dout = 7'b000_0110;
                4'b0010: dout = 7'b101_1011;
                4'b0011: dout = 7'b100_1111;
                4'b0100: dout = 7'b110_0110;
                4'b0101: dout = 7'b110_1101;
                4'b0110: dout = 7'b111_1101;
                4'b0111: dout = 7'b000_0111;
                4'b1000: dout = 7'b111_1111;
                4'b1001: dout = 7'b110_1111;
                4'b1010: dout = 7'b111_0111;
                4'b1011: dout = 7'b111_1100;
                4'b1100: dout = 7'b011_1001;
                4'b1101: dout = 7'b101_1110;
                4'b1110: dout = 7'b111_1001;
                4'b1111: dout = 7'b111_0001;
             endcase   
        end
endmodule
