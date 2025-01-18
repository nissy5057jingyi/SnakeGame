`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 23:31:06
// Design Name: 
// Module Name: MUXM
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


module MUX(
    input [3:0] A,
    input [3:0] B,
    input [3:0] C,
    input [3:0] D,
    input [1:0] Select,
    output reg[3:0] HEX
    );
    always@(A or B or C or D or Select)begin
        case(Select)
            2'b00: HEX[3:0] <= A[3:0];
            2'b01: HEX[3:0] <= B[3:0];
            2'b10: HEX[3:0] <= C[3:0];
            2'b11: HEX[3:0] <= D[3:0];
        endcase
    end
endmodule
