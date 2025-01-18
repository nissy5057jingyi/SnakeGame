`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2022 16:06:49
// Design Name: 
// Module Name: vga
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


module vga(
    input CLK,
    input RESET,
    input [1:0] MSM_State,
    input [11:0] PLAY_COLOUR,
    input [11:0] WIN_COLOUR,
    input [11:0] LOSE_COLOUR,
    input [11:0] IDLE_COLOUR,
    output [9:0] ADDRH,
    output [8:0] ADDRV,
    output HS,
    output VS,
    output [11:0] COLOUR_OUT
    );

    
    reg [11:0] COLOUR;

    
       VGA_Interface VGA_Interface
       (.CLK(CLK), 
        .COLOUR_IN(COLOUR), 
        .COLOUR_OUT(COLOUR_OUT), 
        .HS(HS), 
        .VS(VS), 
        .ADDRH(ADDRH), 
        .ADDRV(ADDRV));
        
      
    always@(posedge CLK) begin
        if(MSM_State == 2'b00) begin
            COLOUR <= IDLE_COLOUR;
        end

        else if(MSM_State == 2'b01) begin
            COLOUR <= PLAY_COLOUR;
        end
        
        else if(MSM_State == 2'b10) begin
            COLOUR <= WIN_COLOUR;
        end
        
        else if(MSM_State == 2'b11) begin
            COLOUR <= LOSE_COLOUR;
        end
    end
                                               
endmodule