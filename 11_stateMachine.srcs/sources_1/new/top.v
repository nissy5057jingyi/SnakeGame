`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.11.2022 16:06:23
// Design Name: 
// Module Name: top
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


module top(
    input CLK,
    input RESET,
    input BTNL,
    input BTNR,
    input BTNU,
    input BTND,
    input [2:0] Level,
    input [2:0] Size,
    output [3:0] SEG_SELECT,
    output [6:0] HEX_OUT,
    output [11:0] COLOUR_OUT,
    output HS,
    output VS
    );
    
     wire [1:0] MSM_State;
     wire [1:0] direction;
     wire [9:0] ADDRH;
     wire [8:0] ADDRV;
     wire [9:0] Target_x;
     wire [8:0] Target_y;
     wire [9:0] Obstacle_x;
     wire [8:0] Obstacle_y;    
     wire [11:0] PLAY_COLOUR;
     wire [11:0] WIN_COLOUR;
     wire [11:0] LOSE_COLOUR;
     wire [11:0] IDLE_COLOUR;     
     wire Reached_Target;
     wire Reached_Obstacle;
     wire [7:0]Current_Score;
     wire [7:0]Current_Blood;
     wire HIT;
     wire [31:0] Counter;
     wire [7:0] timer;
     wire [2:0] size;
     wire [9:0] MaxX;
     wire [8:0] MaxY;

     
     Master_state_machine Master_state_machine(
           .CLK(CLK),
           .RESET(RESET),
           .BTNL(BTNL),
           .BTNR(BTNR),
           .BTNU(BTNU),
           .BTND(BTND),
           .Current_Score(Current_Score),
           .Current_Blood(Current_Blood),
           .HIT(HIT),
           .MSM_State(MSM_State),
           .timer(timer)
           );
           
     Navigation_state_machine Navigation_state_machine
          (.CLK(CLK),
           .RESET(RESET),
           .BTNL(BTNL),
           .BTNR(BTNR),
           .BTNU(BTNU),
           .BTND(BTND),
           .direction(direction)
           );
               
     SnakeControl SnakeControl
         (.CLK(CLK),
          .RESET(RESET),
          .MSM_State(MSM_State), 
          .direction(direction),
          .ADDRH(ADDRH),
          .ADDRV(ADDRV), 
          .Target_x(Target_x),  
          .Target_y(Target_y),
          .Obstacle_x(Obstacle_x),  
          .Obstacle_y(Obstacle_y),
          .Counter(Counter),
          .size(size),
          .MaxX(MaxX),
          .MaxY(MaxY),
          .PLAY_COLOUR(PLAY_COLOUR),
          .Reached_Target(Reached_Target),
          .Reached_Obstacle(Reached_Obstacle),
          .Current_Blood(Current_Blood),
          .HIT(HIT)
          );

     Target_Generator Target_Generator(
         .CLK(CLK),
         .RESET(RESET),
         .Reached_Target(Reached_Target),
         .size(size),
         .MaxX(MaxX),
         .MaxY(MaxY),
         .Target_x(Target_x),  
         .Target_y(Target_y)
         );    
            
        Obstacle_Generator Obstacle_Generator(
         .CLK(CLK),
         .RESET(RESET),
         .Counter(Counter), 
         .MaxY(MaxY),
         .MSM_State(MSM_State), 
         .Obstacle_x(Obstacle_x),  
         .Obstacle_y(Obstacle_y)
         ); 
       
    Score_Counter Score_Counter(
             .CLK(CLK),
             .RESET(RESET),
             .MSM_State(MSM_State),
             .Reached_Target(Reached_Target),
             .Current_Score(Current_Score)
             );
        
         
      Seg_Display Seg_Display(
         .CLK(CLK),
         .RESET(RESET),
         .Current_Score(Current_Score),
         .Current_Blood(Current_Blood),
         .timer(timer),
         .SEG_SELECT(SEG_SELECT),
         .HEX_OUT(HEX_OUT)
             );
       
    vga vga(
        .CLK(CLK),
        .RESET(RESET),
        .MSM_State(MSM_State),
        .PLAY_COLOUR(PLAY_COLOUR),
        .WIN_COLOUR(WIN_COLOUR),
        .LOSE_COLOUR(LOSE_COLOUR),
        .IDLE_COLOUR(IDLE_COLOUR),
        .COLOUR_OUT(COLOUR_OUT),
        .ADDRH(ADDRH),
        .ADDRV(ADDRV),
        .HS(HS),
        .VS(VS)
        );
       
       
        win win
        (.CLK(CLK),
         .ADDRH(ADDRH),
         .ADDRV(ADDRV), 
         .WIN_COLOUR(WIN_COLOUR)
         ); 
     
         lose lose
         (.CLK(CLK),
          .ADDRH(ADDRH),
          .ADDRV(ADDRV), 
          .LOSE_COLOUR(LOSE_COLOUR)
          ); 

        idle idle
        (.CLK(CLK),
         .ADDRH(ADDRH),
         .ADDRV(ADDRV), 
         .IDLE_COLOUR(IDLE_COLOUR)
         );            

       Speed_Selector Speed_Selector
       (.CLK(CLK),
        .Level(Level),
        .MSM_State(MSM_State),
        .Counter(Counter));         
            
      Size_Selecter Size_Selecter(
            .CLK(CLK),
            .Size(Size),
            .size(size)
            );        
endmodule