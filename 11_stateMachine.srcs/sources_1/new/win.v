`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 20:51:59
// Design Name: 
// Module Name: win
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


module win(
         input CLK,
         input [9:0] ADDRH,
         input [8:0] ADDRV, 
         output reg [11:0] WIN_COLOUR
    );
    
    reg [15:0] FrameCount;
    
    always@(posedge CLK) begin
       if(ADDRV==479) begin
       FrameCount <= FrameCount+1;
       end
    end
         
                                       
    always@(posedge CLK) begin
         if(ADDRV[8:0]>240) begin
           if(ADDRH[9:0]>320)
              WIN_COLOUR <= FrameCount[15:8] + ADDRV[7:0]+ADDRH[7:0]-240-320;
           else
              WIN_COLOUR <= FrameCount[15:8] + ADDRV[7:0]-ADDRH[7:0]-240+320;
         end  
         else begin
           if(ADDRH[9:0]>320)
            WIN_COLOUR <= FrameCount[15:8] - ADDRV[7:0]+ADDRH[7:0]+240-320;
           else
            WIN_COLOUR <= FrameCount[15:8] - ADDRV[7:0]-ADDRH[7:0]+240+320;
         end
     end    
                 


endmodule
