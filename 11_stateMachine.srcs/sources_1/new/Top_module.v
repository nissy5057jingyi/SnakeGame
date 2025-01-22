`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2022 09:50:22 PM
// Design Name: 
// Module Name: Top_module
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


module Top_module(
    input CLK,
    input [11:0] Colour_In,
    output [11:0] Colour_Out,
    output HS,
    output VS
    );
    wire [11:0] Colour;
    wire [9:0] X;
    wire [8:0] Y;
    
    VGA_interface inter(.CLK(CLK), .Colour(Colour), .ADDH(X), .ADDV(Y), .Colour_Out(Colour_Out), .HS(HS), .VS(VS));
    Combination some_logic(.CLK(CLK), .Colour_In(Colour_In), .ADDH(X), .ADDV(Y), .Colour(Colour));
endmodule
