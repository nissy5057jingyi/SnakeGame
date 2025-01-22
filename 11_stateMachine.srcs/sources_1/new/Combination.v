`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2022 09:08:16 PM
// Design Name: 
// Module Name: Combination
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


module Combination(
    input CLK,
    input [11:0] Colour_In,
    input [9:0] ADDH,
    input [8:0] ADDV,
    output reg [11:0] Colour
    );
    
    parameter VPushWidthEnd = 10'd2;
    parameter VBackPorchEnd = 10'd31;
    parameter VDisplayTimeEnd = 10'd511;
    parameter VFrontPorchEnd = 10'd521;

    parameter HPushWidthEnd = 10'd96;
    parameter HBackPorchEnd = 10'd144;
    parameter HDisplayTimeEnd = 10'd784;
    parameter HFrontPorchEnd = 10'd800;
    
    always@(posedge CLK) begin
        if(ADDH>HBackPorchEnd && ADDH<HDisplayTimeEnd && ADDV>VBackPorchEnd && ADDV<VDisplayTimeEnd)
            Colour = Colour_In;
        else
            Colour = 0;
    end
    
endmodule
