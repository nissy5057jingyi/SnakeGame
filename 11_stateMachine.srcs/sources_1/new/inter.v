
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/19 19:15:45
// Design Name: 
// Module Name: VGA_Interface
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
//该文件作用:
//先用timer计时自带时钟,把自带时钟频率降到原先1/4,即把模块内做事的刷新率降到时钟的1/4
//再用timer触发横向计数,横向计数满800下,触发一下纵向计数,纵向计数满521下,横纵重新开始计数





module VGA_Interface(
    input CLK,
    input [11:0] COLOUR_IN,
    output reg [9:0] ADDRH,
    output reg [8:0] ADDRV,
    output reg [11:0] COLOUR_OUT,
    output reg HS,
    output reg VS,
    output wire [9:0] HorzOut,
    output wire [9:0] VertOut
    );
    

parameter HorzTimeToPulseWidthEnd = 10'd96;//电脑左边界
parameter HorzTimeToBackPorchEnd = 10'd144;//显示屏左边界
parameter HorzTimeToDisplayTimeEnd = 10'd784;//显示屏右边界
parameter HorzTimeToFrontPorchEnd = 10'd800;//电脑右边界  

parameter VertTimeToPulseWidthEnd = 10'd2;//电脑上边界
parameter VertTimeToBackPorchEnd = 10'd31;//显示屏上边界
parameter VertTimeToDisplayTimeEnd = 10'd511;//显示屏下边界
parameter VertTimeToFrontPorchEnd = 10'd521;//电脑下边界

//定义变量(真正在功能里发生变化的东西
wire HorzTrig;//定义一根线,显示横向是否换行
wire VertTrig;//定义一根线,显示纵向是否换行   
wire [9:0] HorzCount;//定义一根10bit的线,显示横向计的数
wire [9:0] VertCount;//定义一根10bit的线,显示纵向计的数
wire Trig;//定义一根线,显示是否

//大家的时钟信号总是相同的,一个大文件不能有多个时钟信号
//引用文件
//文件名
//timer模块作用:在有开始和置零的情况下,每数4个输出一个触发信号(TRIG_OUT),并输出自己计数器的值(0-3用2bit来储存)(COUNT)
Generic_counter # (.COUNTER_WIDTH(2),//输出2个计数器
                   .COUNTER_MAX(3))//计数最大值为3
                   timer(//模块名
                   .CLK(CLK),//把引用文件的CLK端口接到此文件的CLK端口
                   .ENABLE(1'b1),//把引用文件的ENABLE端口赋值为1
                   .RESET(1'b0),//把引用文件的RESET端口赋值为0
                   .TRIG_OUT(Trig)//把引用文件的TRIG_OUT端口接上此文件的Trig线
                   //COUNT用不到所以本身有但是不接线
                   );
//通过使能信号控制降低自己的刷新率                   
//Horz_sync_count模块作用:在timer给使能信号时,每数800个输出一个横向触发信号(TRIG_OUT),说明横向计数已完成要换行,
//并输出自己计数器的值(0-799用10bit来储存)(COUNT)                                         
Generic_counter # (.COUNTER_WIDTH(10),//输出10个计数器
                   .COUNTER_MAX(799))//计数最大值为799
                   Horz_sync_count(//模块名
                   .CLK(CLK),//把引用文件的CLK端口接到此文件的CLK端口
                   .ENABLE(Trig),//把引用文件的ENABLE端口接上此文件的Trig线
                   .RESET(1'b0),//把引用文件的RESET端口赋值为0
                   .TRIG_OUT(HorzTrig),//把引用文件的TRIG_OUT端口接上此文件的HorzTrig线
                   .COUNT(HorzCount)//把引用文件的TRIG_OUT端口接上此文件的HorzTrig线
                   );

//Vert_sync_count模块作用:在HorzTrig给使能信号时,每数521个输出一个纵向触发信号(TRIG_OUT),说明纵向计数已完成要结束显示,
//并输出自己计数器的值(0-520用10bit来储存)(COUNT)
Generic_counter # (.COUNTER_WIDTH(10),//输出10个计数器
                   .COUNTER_MAX(520))//计数最大值为520
                   Vert_sync_count(//模块名
                   .CLK(CLK),//把引用文件的CLK端口接到此文件的CLK端口
                   .ENABLE(HorzTrig),//把引用文件的ENABLE端口接上此文件的HorzTrig线
                   .RESET(1'b0),//把引用文件的RESET端口赋值为0
                   .TRIG_OUT(VertTrig),//把引用文件的TRIG_OUT端口接上此文件的VertTrig线
                   .COUNT(VertCount)//把引用文件的TRIG_OUT端口接上此文件的VertCount线
                   );

//定义功能  
//定义功能就是用变量给各个输出端口赋值
//HS和VS判定是否开始工作,数够一顶数自己会停,所以只需要规定什么时候开始,不用规定什么时候结束
always@(posedge CLK) begin//在时钟上升沿时
    if(HorzCount < HorzTimeToPulseWidthEnd)//如果横向计数器在电脑左边界以左
        HS <= 0;//不开始
    else
        HS <= 1;//否则开始
end
               
always@(posedge CLK) begin//在时钟上升沿时
    if(VertCount < VertTimeToPulseWidthEnd)//如果纵向计数器在电脑上边界以上
        VS <= 0;//不开始
    else
        VS <= 1;//否则开始
end

always@(posedge CLK) begin//在时钟上升沿时
    if((VertCount > VertTimeToBackPorchEnd) //如果横纵计数器都满足显示屏边界条件
              && (VertCount < VertTimeToDisplayTimeEnd) 
              && (HorzCount > HorzTimeToBackPorchEnd)
              && (HorzCount < HorzTimeToDisplayTimeEnd))
        COLOUR_OUT <= COLOUR_IN;//输出的颜色为输入的颜色
    else
        
        COLOUR_OUT <= 0;//输出颜色置零,即黑屏
end

always@(posedge CLK) begin//在时钟上升沿时
    if((VertCount > VertTimeToBackPorchEnd) //如果横纵计数器都满足显示屏边界条件
              && (VertCount < VertTimeToDisplayTimeEnd) 
              && (HorzCount > HorzTimeToBackPorchEnd)
              && (HorzCount < HorzTimeToDisplayTimeEnd))
    ADDRH = HorzCount - HorzTimeToBackPorchEnd;//横向地址为计数器地址-左边界地址
    ADDRV = VertCount - VertTimeToBackPorchEnd;//纵向地址为计数器地址-上边界地址
end

assign HorzOut = HorzCount;//把横向计数器的值给横向输出端口
assign VertOut = VertCount;//把纵向计数器的值给纵向输出端口

endmodule