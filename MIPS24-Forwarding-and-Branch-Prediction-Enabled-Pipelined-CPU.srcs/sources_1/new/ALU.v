`timescale 1ns / 1ps

module ALU(
    X,
    Y,
    S,
    shamt,
    E,
    R,
    R2,
    OF,
    UOF
    );
    input [31:0] X;
    input [31:0] Y;
    input [3:0] S;
    input [4:0] shamt;
    output reg E;
    output reg [31:0] R;
    output reg [31:0] R2;
    output  reg OF;
    output reg UOF;

    reg[63:0] temp;
    reg[31:0] temp1, temp2;
    reg C,Cf;
    initial
        begin
            R2 = 0;
            R = 0;
            OF = 0;
            UOF = 0;
            temp = 0;
            temp1 = 0;
            temp2 = 0;
            C = 0;
            Cf = 0;
        end
    always @ (*)
        begin
            E = (X==Y?1:0);
            if (S==4'd0)                   // 逻辑左移
                begin
                    R2 = 0;
                    R = Y << shamt;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd1)              // 算数右移
                begin
                    R2 = 0;
                    R = $signed(Y) >>> shamt;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd2)              // 逻辑右移
                begin
                    R2 = 0;
                    R = Y >> shamt;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd3)              // 乘法
                 begin
                    temp = X * Y;
                    R2 = temp[63:32];
                    R = temp[31:0];
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd4)              // 除法
                begin
                    if(Y==0)
                        begin 
                            R2 = 32'hffffffff;
                            R = 32'hffffffff;
                            OF = 0;
                            UOF = 0;
                        end
                    else
                        begin
                            R2 = X % Y;
                            R = X / Y;
                            OF = 0;
                            UOF = 0;
                        end
                end
            else if (S==4'd5)              // 加法
                begin
                    // 有符号数
                    temp = X[30:0] + Y[30:0];
                    C = temp[31];
                    Cf = X[31] + Y[31];
                    OF = C ^ Cf;
                    //  无符号数
                    R2 = 0;
                    {UOF, R} = X + Y;              
                end
            else if (S==4'd6)              // 减法
                begin
                    // 有符号数
                    temp1 = -Y;
                    temp = X[30:0] + temp1[30:0];
                    C = temp[31];
                    Cf = X[31] + temp1[31];
                    OF = C ^ Cf;
                    // 无符号数
                    UOF = (X>=Y)?0:1;
                    // 减法
                    R2 = 0;
                    R = X - Y;
                end
            else if (S==4'd7)              // 按位与
                begin
                    R2 = 0;
                    R = X & Y;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd8)              // 按位或
                begin
                    R2 = 0;
                    R = X | Y;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd9)              // 按位异或
                begin
                    R2 = 0;
                    R = X ^ Y;
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd10)             // 按位或非
                begin
                    R2 = 0;
                    R = ~(X | Y);
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd11)             // 有符号数比较
                begin
                    R2 = 0;
                    if (X[31]==1 && Y[31]==0)
                        R = 1;
                    else if (X[31]==0 && Y[31]==1)
                        R = 0;
                    else if (X[31]==0 && Y[31]==0)
                        R = (X < Y)?1:0;
                    else
                        begin
                            temp1 = -X;
                            temp2 = -Y;
                            R = temp1<temp2?0:1;
                        end                    
                    OF = 0;
                    UOF = 0;
                end
            else if (S==4'd12)             // 无符号数比较
                begin
                    R2 = 0;
                    R = (X < Y)?1:0;
                    OF = 0;
                    UOF = 0;
                end    
            else
                begin
                    R2 = 0;
                    R = 0;
                    OF = 0;
                    UOF = 0;
                end            
        end
endmodule

    