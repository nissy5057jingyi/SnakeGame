`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 23:25:47
// Design Name: 
// Module Name: digit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digit(

     input CLK,
     input [7:0] Num,
     output reg [3:0] OUT_0,
     output reg [3:0] OUT_1,
     output reg [3:0] OUT_2,
     output reg [3:0] OUT_3
    );
    
    
    always@(posedge CLK) begin
            if(Num < 10) begin
                OUT_0 <= Num;
                OUT_1 <= 4'hF;
                OUT_2 <= 4'hF;
                OUT_3 <= 4'hF;
            end
            else if((Num > 9) && (Num < 100)) begin
                OUT_0 <= Num - (Num/10)*10;
                OUT_1 <= Num/10;
                OUT_2 <= 4'hF;
                OUT_3 <= 4'hF;
            end
            else if((Num > 99) && (Num < 1000)) begin
                OUT_0 <= Num - (Num/10)*10;
                OUT_1 <= (Num - (Num/100)*100)/10;
                OUT_2 <= Num/100;
                OUT_3 <= 4'hF;
            end
            else if((Num > 999) && (Num < 9999)) begin
                OUT_0 <= Num - (Num/10)*10;
                OUT_1 <= (Num - (Num/100)*100)/10;
                OUT_2 <= (Num - (Num/1000)*1000)/100;
                OUT_3 <= Num/1000;
            end
            else begin
                OUT_0 <= 0;
                OUT_1 <= 4'hF;
                OUT_2 <= 4'hF;
                OUT_3 <= 4'hF;
            end
        end
    
endmodule
