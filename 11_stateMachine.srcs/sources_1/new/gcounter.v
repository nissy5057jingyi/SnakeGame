
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/10/16 21:15:57
// Design Name: 
// Module Name: Generic_counter
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
//所有人都是只有在是时钟上升沿才有机会动
//该文件作用为:接收到前一个人的使能信号后,在时钟上升沿计数,计10个数,把触发信号传出去,并输出N个此时计数器的值

//定义文件和端口
module Generic_counter( //文件名
    CLK,//端口名,在定义文件和端口的时候先不定义输入和输出,在定义功能的时候再定义
    RESET,//这是写参数可调文件时的特有写法
    ENABLE,
    TRIG_OUT,
    COUNT
    );
  
//定义功能

    //定义文件内的可调参数
    parameter COUNTER_WIDTH = 4;//COUNTER转换时钟的比率
    parameter COUNTER_MAX = 9;//COUNTER的最大值
    parameter COUNTER_INIT = 0;//COUNTER的最小值
    
    //定义端口
    input CLK;//定义这个端口为输入
    input RESET;//定义这个端口为输入
    input ENABLE;//定义这个端口为输入
    output TRIG_OUT;//定义这个端口为输出
    output  [COUNTER_WIDTH - 1: 0] COUNT;//定义这个端口为长度由参数控制的输出
    
    //定义变量
    reg [COUNTER_WIDTH - 1: 0] count_value;//定义一个电压源,表达颜色选择
    reg Trigger_out;//定义一个电压源,表达是否触发
    
    //功能描述
    //功能描述里面,让发生变化的一定是最后定义的变量,而非端口
    always@(posedge CLK) begin//在时钟上升沿
        if(RESET)//如果重置
            count_value <= 0;//计数器置零
        else begin
            if(ENABLE) begin//如果使能,计数就加一
                if(count_value == COUNTER_MAX) //如果计数达最大值
                    count_value <= 0;//计数归零
                else
                    count_value <= count_value + 1;//否则计数加一
            end
        end
    end 
    always@(posedge CLK) begin//在时钟上升沿
        if(RESET)//如果重置
            Trigger_out <= 0;//触发置零
        else begin
            if(ENABLE && (count_value == COUNTER_MAX))//如果有前一个使能且本轮计数达最大
                Trigger_out <= 1;//触发下一个
            else
                Trigger_out <= 0;//否则不触发下一个
        end
    end
    
    assign COUNT = count_value;//把变量值给输出端口
    assign TRIG_OUT = Trigger_out;//把变量值给输出端口
endmodule
