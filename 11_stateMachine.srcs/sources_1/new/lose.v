`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.11.2022 15:38:42
// Design Name: 
// Module Name: lose
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


module lose(
        input CLK,
        input [9:0]ADDRH,
        input [8:0]ADDRV, 
        output [11:0] LOSE_COLOUR
    );
    
    
    wire [9:0] X;
    wire [8:0] Y;
    wire BlinkTriggOut;
    reg blink;
    reg [11:0] COLOUR;
    reg [11:0] COLOUR_tongue_r;
    reg [11:0] COLOUR_tongue_b;
    assign X=ADDRH;
    assign Y=ADDRV;
    
     //bink counter
    Generic_counter # (.COUNTER_WIDTH(30),
                       .COUNTER_MAX(4*800*520*32)
                      )
                   blink_counter(
                   .CLK(CLK),
                   .RESET(1'b0),
                   .ENABLE(1'b1),
                   .TRIG_OUT(BlinkTriggOut)             
                   );
                   
    always@(posedge CLK) begin
        if(BlinkTriggOut) begin
        blink = ~blink;
        end
    end    
                         
    always@(posedge CLK) begin
        if(blink) begin
            COLOUR_tongue_r <= 12'h00f;
            COLOUR_tongue_b <= 12'h000;
        end
        else begin     
            COLOUR_tongue_r <= 12'h0ff;
            COLOUR_tongue_b <= 12'h0ff;
        end
    end
                       
    always@(posedge CLK) begin
           //dispaly eyes
           if((X>=270)&&(X<=280)&&(Y>=180)&&(Y<=210))                         COLOUR<=12'h000;
           else if((X>=360)&&(X<=370)&&(Y>=180)&&(Y<=210))                    COLOUR<=12'h000;
           
           //dispaly tone
           else if((Y>290)&&(((X-350)*(X-350)+(Y-290)*(Y-290))<28*28))        COLOUR<=COLOUR_tongue_r; 
           else if((Y>290)&&(((X-350)*(X-350)+(Y-290)*(Y-290))<30*30))        COLOUR<=COLOUR_tongue_b;  
           
           //display mouse
           else if((X>=260)&&(X<=380)&&(Y>=285)&&(Y<=290))                    COLOUR<=12'h000;
           
           //display ball
           else if(((X-320)*(X-320)+(Y-240)*(Y-240))<150*150)                 COLOUR<=12'h0ff;
           else if(((X-320)*(X-320)+(Y-240)*(Y-240))<152*152)                 COLOUR<=12'h000; 
           
           else    COLOUR<=12'h00f;
//   end
   end
   
   assign LOSE_COLOUR=COLOUR;
    
endmodule