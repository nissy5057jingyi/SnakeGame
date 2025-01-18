`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 21:15:08
// Design Name: 
// Module Name: Master_state_machine
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


module Master_state_machine(
    input CLK,
    input RESET,
    input BTNU,
    input BTND,
    input BTNL,
    input BTNR,
    input HIT,
    input [7:0] Current_Score,
    input [7:0] Current_Blood,
    output reg [1:0] MSM_State,
    output [7:0] timer
    );
    
      reg [1:0] Next_State;
      wire TRIG_OUT;
      wire Cy;
      wire [7:0] COUNT;
      
      Generic_counter # (
          .COUNTER_WIDTH(17),
          .COUNTER_MAX(99999))  
      counter1 (  
          .CLK(CLK),
          .ENABLE(MSM_State == 2'b01),
          .RESET(RESET),
          .TRIG_OUT(TRIG_OUT)
      );
      
     Generic_counter # (
          .COUNTER_WIDTH(10),
          .COUNTER_MAX(999))  
      second_counter (  
          .CLK(CLK),
          .ENABLE(TRIG_OUT),
          .RESET(RESET),
          .TRIG_OUT(Cy)
      );
      
      Generic_counter # (
           .COUNTER_WIDTH(8),
           .COUNTER_MAX(60))  
      timer_counter (  
           .CLK(CLK),
           .ENABLE(Cy),
           .RESET(RESET),
           .COUNT(COUNT)
       );
       
       
      assign timer = 60-COUNT;
     
      
      initial begin
          MSM_State <= 0;
      end
      
      always@(posedge CLK)begin
      if(RESET)begin
      MSM_State<=2'b00;
      end
      else begin
      MSM_State<=Next_State;
      end
    end              
                
    always@(*)begin
      case(MSM_State)
        2'b00:begin
            if(BTNL || BTNR || BTNU || BTND)
            Next_State<=2'b01;
            else
            Next_State<=MSM_State;
        end
        
        2'b01:begin
            if(Current_Score==20)
            Next_State<=2'b10;
            else if(HIT==1)
            Next_State<=2'b11;
            else if(Current_Blood==0)
            Next_State<=2'b11;
            else if(COUNT==60)
            Next_State<=2'b11;
            else
            Next_State<=MSM_State;
        end
        
        2'b10:begin
        	if(RESET) 
            Next_State<=2'b00;
            else
            Next_State<= MSM_State;
        end       
        
        2'b11:begin
            if(RESET) 
            Next_State<=2'b00;
            else
            Next_State<= MSM_State;
        end 
       
    
   endcase
 end
    
    
endmodule
