`timescale 1ns / 1ps

module MAX8(
    count0,
    count1, 
    count2,
    count3,
    count4,
    count5,
    count6,
    count7,
    num
    );
    
    input wire[31:0] count0;
    input wire[31:0] count1;
    input wire[31:0] count2;
    input wire[31:0] count3;
    input wire[31:0] count4;
    input wire[31:0] count5;
    input wire[31:0] count6;
    input wire[31:0] count7;
    output reg[2:0] num;
    
    reg[2:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
    reg[31:0] max0, max1, max2, max3, max4, max5;
    always @ (*)
        begin
            temp0 = (count0 >= count1) ? 3'd0 : 3'd1;
            max0 = (count0 >= count1) ? count0 : count1;
            
            temp1 = (count2 >= count3) ? 3'd2 : 3'd3;
            max1 = (count2 >= count3) ? count2 : count3;
            
            temp2 = (count4 >= count5) ? 3'd4 : 3'd5;
            max2 = (count4 >= count5) ? count4 : count5;
            
            temp3 = (count6 >= count7) ? 3'd6 : 3'd7;
            max3 = (count6 >= count7) ? count6 : count7;
            
            temp4 = (max0 >= max1) ? temp0 : temp1;
            max4 = (max0 >= max1) ? max0 : max1;
            
            temp5 = (max2 >= max3) ? temp2 : temp3;
            max5 = (max2 >= max3) ? max2 : max3;
            
            num = (max4 >= max5) ? temp4 : temp5;            
        end
    
endmodule
