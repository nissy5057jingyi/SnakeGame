`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2022 05:52:52 PM
// Design Name: 
// Module Name: VGA_interface
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

//Interface，计数依次产生每一个地址并将地址发给
module VGA_interface(
    input CLK,
    input [11:0] Colour,
    output [9:0] ADDH,
    output [8:0] ADDV,
    output [11:0] Colour_Out,
    output reg HS,
    output reg VS
    );
    
    parameter VPushWidthEnd = 10'd2;
    parameter VBackPorchEnd = 10'd31;
    parameter VDisplayTimeEnd = 10'd511;
    parameter VFrontPorchEnd = 10'd521;

    parameter HPushWidthEnd = 10'd96;
    parameter HBackPorchEnd = 10'd144;
    parameter HDisplayTimeEnd = 10'd784;
    parameter HFrontPorchEnd = 10'd800;
       
    reg [9:0] CounterH = 0;
    reg [8:0] CounterV = 0;
    
    always@(posedge CLK) begin
        if(CounterH == 799) begin
            CounterH = 0;
            if(CounterV == 520)
                CounterV = 0;
            else
                CounterV = CounterV + 1;
        end
        else
            CounterH = CounterH + 1;
    end
    
    always@(CounterH) begin
        if(CounterH > HPushWidthEnd) 
            HS = 1;
        else
            HS = 0;
    end
    
    always@( CounterV) begin
        if(CounterV > VPushWidthEnd) 
            VS = 1;
        else
            VS = 0;
    end
    
    assign ADDH = CounterH;
    assign ADDV = CounterV;
    assign Colour_Out = Colour;
    
endmodule
