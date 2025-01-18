`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2022 15:06:20
// Design Name: 
// Module Name: LED_DisplaySM
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


module Navigation_state_machine(
    input CLK,
    input RESET,
    input BTNU,
    input BTND,
    input BTNL,
    input BTNR,
    output [1:0] direction
    );
     

    reg [1:0] Curr_State;
    reg [1:0] Next_State;
    
    initial begin
    Curr_State=0;
    end
    
    always@(posedge CLK) begin
     if(RESET)begin
        Curr_State <=2'b00;
     end
     else
         Curr_State <=Next_State;
   end
   
   
    always@(*)begin
      case(Curr_State)
        2'b00://UP
        begin
          if(BTNL)
          Next_State<=2'b11;
          else if(BTNR)
          Next_State<=2'b01;
          else
          Next_State<=Curr_State;
      end
        
        2'b01://RIGHT
        begin
            if(BTNU)
            Next_State<=2'b00;
            else if(BTND)
            Next_State<=2'b10;
            else
            Next_State<=Curr_State;
        end
        
        2'b10://DOWN
        begin
            if(BTNL)
            Next_State<=2'b11;
            else if(BTNR)
            Next_State<=2'b01;
            else
            Next_State<=Curr_State;
        end
        
        2'b11://LEFT
        begin
            if(BTNU)
            Next_State<=2'b00;
            else if(BTND)
            Next_State<=2'b10;
            else
            Next_State<=Curr_State;
        end       
     endcase
   end

  assign direction=Curr_State;    
    
endmodule
