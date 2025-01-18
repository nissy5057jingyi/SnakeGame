`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.11.2022 12:56:31
// Design Name: 
// Module Name: Basic_state_machine
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


module Basic_state_machine(
    input CLK,
    input RESET,
    input BTNL,
    input BTNC,
    input BTNR,
    input MSM_State,
    output [2:0] STATE_OUT
    );
    
    reg [2:0] Curr_State;
    reg [2:0] Next_State;
    
    always@(posedge CLK)begin
      if(RESET)begin
      Curr_State<=3'd0;
      end
      else begin
      Curr_State<=Next_State;
      end
    end
    
    
    always@(Curr_State or BTNL or BTNR or BTNC or MSM_State)begin
      if(Curr_State==9)
      Curr_State<=0;
      else
      Curr_State<=Curr_State+1;
  end

   assign STATE_OUT=Curr_State;

endmodule
