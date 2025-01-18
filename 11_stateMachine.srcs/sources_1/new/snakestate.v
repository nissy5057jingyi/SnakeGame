`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.11.2022 20:02:43
// Design Name: 
// Module Name: snakestate
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


module SnakeControl(
    input CLK,
    input RESET,
    input [1:0] MSM_State,  
    input [1:0] direction,  
    input [9:0] Target_x,  
    input [8:0] Target_y,
    input [9:0] Obstacle_x,  
    input [8:0] Obstacle_y,
    input [9:0] ADDRH,
    input [8:0] ADDRV, 
    input [31:0] Counter, 
    input [2:0] size, 
    output reg [11:0] PLAY_COLOUR,
    output reg Reached_Target,
    output reg Reached_Obstacle,
    output reg [7:0] Current_Blood,
    output reg [9:0] MaxX,
    output reg [8:0] MaxY,  
    output reg HIT
    );
    
    reg [9:0] SnakeState_X [0:SnakeLength-1];
    reg [8:0] SnakeState_Y [0:SnakeLength-1];
    reg [SnakeLength - 1: 0] Snake_shade;
    reg [1:0] direction_now;
    reg hit;	      
    parameter SnakeLength = 40;
    
    
  	initial begin
        HIT <= 0;
        hit <= 0;
        Current_Blood<=10;
        Snake_shade = 'h00000000FF;
        Reached_Target <= 1'b0;
        Reached_Obstacle <= 1'b0;
    end  
    
    always@(posedge CLK)begin
        case(size)
        3'd1:begin
          MaxX<=320;
          MaxY<=240;
        end
        3'd2:begin
          MaxX<=160;
          MaxY<=120;
        end
        3'd4:begin
          MaxX<=40;
          MaxY<=30;
        end
      endcase
    end
    always @(posedge CLK) begin
        direction_now <= direction;
    end
      
    always @(posedge CLK) begin  
        if (RESET || MSM_State == 2'b00)
            Snake_shade = 'h000000FFFF;
        else begin
            if (Reached_Target) begin
                Snake_shade <= (Snake_shade << 1) + 1;  
            end
        end
    end
    
    
    genvar PixNo;
    generate
         for(PixNo=0;PixNo<SnakeLength-1; PixNo = PixNo+1)
         begin:PixShift
            always@(posedge CLK) begin
               if(RESET||MSM_State == 2'b00)begin
                   SnakeState_X[PixNo+1] <= 15-(PixNo+1);
                   SnakeState_Y[PixNo+1] <= 20;
               end
               else if (Counter==0||direction != direction_now) begin
                  SnakeState_X[PixNo+1] <= SnakeState_X[PixNo];
                  SnakeState_Y[PixNo+1] <= SnakeState_Y[PixNo];
               end
             end
          end
    endgenerate
       
       
       always@(posedge CLK)begin
           if(RESET|| MSM_State == 2'b00)begin
               SnakeState_X[0] <= 15;
               SnakeState_Y[0] <= 20;
           end
           else if (Counter==0 || direction != direction_now) begin
             case(direction)
                2'b00://UP
                begin
                   if(SnakeState_Y[0] ==0)
                    SnakeState_Y[0] <= MaxY;
                   else
                    SnakeState_Y[0] <= SnakeState_Y[0]-1;
                end
                
                2'b01://RIGHT
                begin
                   if(SnakeState_X[0] ==MaxX)
                    SnakeState_X[0] <= 0;
                   else
                    SnakeState_X[0] <= SnakeState_X[0]+1;
                end
                
                2'b10://DOWN
                begin
                   if(SnakeState_Y[0] ==MaxY)
                    SnakeState_Y[0] <= 0;
                   else
                    SnakeState_Y[0] <= SnakeState_Y[0]+1;
                end
                
                2'b11://LEFT
                begin
                   if(SnakeState_X[0] == 0)
                    SnakeState_X[0] <= MaxX;
                   else
                    SnakeState_X[0] <= SnakeState_X[0]-1;
                end
               endcase
             end
         end
         
	always @(posedge CLK) begin  //Reached_TargetÐÅºÅÉú³É
             if (RESET) begin
                 Reached_Target <= 1'b0;
             end
             else begin
                 if (Target_x == SnakeState_X[0] && Target_y == SnakeState_Y[0]) begin
                     Reached_Target <= 1'b1;
                 end
                 else begin
                     Reached_Target <= 1'b0;
                 end
             end
         end
                 
         
         
         
         integer i;
         always @(posedge CLK) begin  
             if (RESET)
                 HIT <= 0;
             else 
                 for (i = 1; i < SnakeLength; i = i + 1)begin
                     if ((SnakeState_X[0] == SnakeState_X[i]) && (SnakeState_Y[0] == SnakeState_Y[i]) && Snake_shade[i])
                         HIT <= 1;
                 end               
          end
          
          
          
         always @(posedge CLK) begin  
              if (RESET) 
                  Reached_Obstacle <= 0;
              else begin
                  if (hit)
                      Reached_Obstacle <= 1;
                  else 
                      Reached_Obstacle <= 0;
              end
         end
         
         integer n;
         always @(posedge CLK) begin  
            if (RESET || Reached_Obstacle)
            hit <= 0;
            else if ((Counter==0) && (MSM_State==2'b01)) begin
              for (n = 1; n < SnakeLength; n = n + 1)begin
              if ((Obstacle_x == SnakeState_X[n]) && (Obstacle_y == SnakeState_Y[n]) && Snake_shade[n])
                  hit <= 1;
              end   
            end  
          end   
        
        always @(posedge CLK) begin
          if(RESET || Current_Blood == 0 || MSM_State != 2'b01)
              Current_Blood <= 10;
          if (Reached_Obstacle) 
              Current_Blood <= Current_Blood - 1;
      end
              
        integer j;  
        always@(posedge CLK) begin
            PLAY_COLOUR = 12'hF00;//back ground
            case(size)
            3'd1:begin
            for (j = 0; j < SnakeLength; j = j + 1)begin
                if ((ADDRH[9:1] == SnakeState_X[j]) && (ADDRV[8:1] == SnakeState_Y[j]) && Snake_shade[j])
                    PLAY_COLOUR <= 12'h0FF;//snake colour
            end        
            if(ADDRH[9:1] == Target_x && ADDRV[8:1] == Target_y)
                    PLAY_COLOUR <= 12'h00F;//apple colour
            if(ADDRH[9:1] == Obstacle_x && ADDRV[8:1] == Obstacle_y)
                    PLAY_COLOUR <= 12'hF0F;//obstacle colour
            end
            
            3'd2:begin
            for (j = 0; j < SnakeLength; j = j + 1)begin
                if ((ADDRH[9:2] == SnakeState_X[j]) && (ADDRV[8:2] == SnakeState_Y[j]) && Snake_shade[j])
                    PLAY_COLOUR <= 12'h0FF;//snake colour
            end        
            if(ADDRH[9:2] == Target_x && ADDRV[8:2] == Target_y)
                    PLAY_COLOUR <= 12'h00F;//apple colour
            if(ADDRH[9:2] == Obstacle_x && ADDRV[8:2] == Obstacle_y)
                    PLAY_COLOUR <= 12'hF0F;//obstacle colour
            end
           
            3'd4:begin
            for (j = 0; j < SnakeLength; j = j + 1)begin
                if ((ADDRH[9:4] == SnakeState_X[j]) && (ADDRV[8:4] == SnakeState_Y[j]) && Snake_shade[j])
                    PLAY_COLOUR <= 12'h0FF;//snake colour
            end        
            if(ADDRH[9:4] == Target_x && ADDRV[8:4] == Target_y)
                    PLAY_COLOUR <= 12'h00F;//apple colour
            if(ADDRH[9:4] == Obstacle_x && ADDRV[8:4] == Obstacle_y)
                    PLAY_COLOUR <= 12'hF0F;//obstacle colour
            end
         endcase
        end
         
    
endmodule
