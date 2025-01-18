`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2022 06:34:58 PM
// Design Name: 
// Module Name: MUX
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
    input [4:0] a,
    input [4:0] b,
    input [4:0] c,
    input [4:0] d,
    input [1:0] Select,
    output reg [4:0] HAX
    );
    always@(a or b or c or d or Select)begin
        case(Select)
            2'b00: HAX[4:0] <= d[4:0];
            2'b01: HAX[4:0] <= d[4:0];
            2'b10: HAX[4:0] <= d[4:0];
            2'b11: HAX[4:0] <= d[4:0];
        endcase
    end
endmodule
