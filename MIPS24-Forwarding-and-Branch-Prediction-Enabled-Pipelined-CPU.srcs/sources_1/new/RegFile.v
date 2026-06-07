module RegFile(
    R1A,
    R2A,
    WA,
    Din,
    WE,
    CLK,
    R1,
    R2
    );
    input [4:0] R1A;
    input [4:0] R2A;
    input [4:0] WA;
    input [31:0] Din;
    input WE;
    input CLK;
    output [31:0] R1;
    output [31:0] R2;
    
    reg [31:0] rs [31:0];
    integer i;
    initial
        begin
            for(i=0;i<32;i=i+1)
                rs[i] = 0;
        end
        
    // 下降沿写
    always @ (negedge CLK)
        begin
            if(WE)
                if(WA==0)
                    rs[WA] <= 0;
                else
                    rs[WA] <= Din;
        end 
    
    // 读为组合逻辑
    assign R1 = rs[R1A];
    assign R2 = rs[R2A];
endmodule