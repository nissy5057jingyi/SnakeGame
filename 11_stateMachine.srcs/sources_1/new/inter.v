
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
//���ļ�����:
//����timer��ʱ�Դ�ʱ��,���Դ�ʱ��Ƶ�ʽ���ԭ��1/4,����ģ�������µ�ˢ���ʽ���ʱ�ӵ�1/4
//����timer�����������,���������800��,����һ���������,���������521��,�������¿�ʼ����





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
    

parameter HorzTimeToPulseWidthEnd = 10'd96;//������߽�
parameter HorzTimeToBackPorchEnd = 10'd144;//��ʾ����߽�
parameter HorzTimeToDisplayTimeEnd = 10'd784;//��ʾ���ұ߽�
parameter HorzTimeToFrontPorchEnd = 10'd800;//�����ұ߽�  

parameter VertTimeToPulseWidthEnd = 10'd2;//�����ϱ߽�
parameter VertTimeToBackPorchEnd = 10'd31;//��ʾ���ϱ߽�
parameter VertTimeToDisplayTimeEnd = 10'd511;//��ʾ���±߽�
parameter VertTimeToFrontPorchEnd = 10'd521;//�����±߽�

//�������(�����ڹ����﷢���仯�Ķ���
wire HorzTrig;//����һ����,��ʾ�����Ƿ���
wire VertTrig;//����һ����,��ʾ�����Ƿ���   
wire [9:0] HorzCount;//����һ��10bit����,��ʾ����Ƶ���
wire [9:0] VertCount;//����һ��10bit����,��ʾ����Ƶ���
wire Trig;//����һ����,��ʾ�Ƿ�

//��ҵ�ʱ���ź�������ͬ��,һ�����ļ������ж��ʱ���ź�
//�����ļ�
//�ļ���
//timerģ������:���п�ʼ������������,ÿ��4�����һ�������ź�(TRIG_OUT),������Լ���������ֵ(0-3��2bit������)(COUNT)
Generic_counter # (.COUNTER_WIDTH(2),//���2��������
                   .COUNTER_MAX(3))//�������ֵΪ3
                   timer(//ģ����
                   .CLK(CLK),//�������ļ���CLK�˿ڽӵ����ļ���CLK�˿�
                   .ENABLE(1'b1),//�������ļ���ENABLE�˿ڸ�ֵΪ1
                   .RESET(1'b0),//�������ļ���RESET�˿ڸ�ֵΪ0
                   .TRIG_OUT(Trig)//�������ļ���TRIG_OUT�˿ڽ��ϴ��ļ���Trig��
                   //COUNT�ò������Ա����е��ǲ�����
                   );
//ͨ��ʹ���źſ��ƽ����Լ���ˢ����                   
//Horz_sync_countģ������:��timer��ʹ���ź�ʱ,ÿ��800�����һ�����򴥷��ź�(TRIG_OUT),˵��������������Ҫ����,
//������Լ���������ֵ(0-799��10bit������)(COUNT)                                         
Generic_counter # (.COUNTER_WIDTH(10),//���10��������
                   .COUNTER_MAX(799))//�������ֵΪ799
                   Horz_sync_count(//ģ����
                   .CLK(CLK),//�������ļ���CLK�˿ڽӵ����ļ���CLK�˿�
                   .ENABLE(Trig),//�������ļ���ENABLE�˿ڽ��ϴ��ļ���Trig��
                   .RESET(1'b0),//�������ļ���RESET�˿ڸ�ֵΪ0
                   .TRIG_OUT(HorzTrig),//�������ļ���TRIG_OUT�˿ڽ��ϴ��ļ���HorzTrig��
                   .COUNT(HorzCount)//�������ļ���TRIG_OUT�˿ڽ��ϴ��ļ���HorzTrig��
                   );

//Vert_sync_countģ������:��HorzTrig��ʹ���ź�ʱ,ÿ��521�����һ�����򴥷��ź�(TRIG_OUT),˵��������������Ҫ������ʾ,
//������Լ���������ֵ(0-520��10bit������)(COUNT)
Generic_counter # (.COUNTER_WIDTH(10),//���10��������
                   .COUNTER_MAX(520))//�������ֵΪ520
                   Vert_sync_count(//ģ����
                   .CLK(CLK),//�������ļ���CLK�˿ڽӵ����ļ���CLK�˿�
                   .ENABLE(HorzTrig),//�������ļ���ENABLE�˿ڽ��ϴ��ļ���HorzTrig��
                   .RESET(1'b0),//�������ļ���RESET�˿ڸ�ֵΪ0
                   .TRIG_OUT(VertTrig),//�������ļ���TRIG_OUT�˿ڽ��ϴ��ļ���VertTrig��
                   .COUNT(VertCount)//�������ļ���TRIG_OUT�˿ڽ��ϴ��ļ���VertCount��
                   );

//���幦��  
//���幦�ܾ����ñ�������������˿ڸ�ֵ
//HS��VS�ж��Ƿ�ʼ����,����һ�����Լ���ͣ,����ֻ��Ҫ�涨ʲôʱ��ʼ,���ù涨ʲôʱ�����
always@(posedge CLK) begin//��ʱ��������ʱ
    if(HorzCount < HorzTimeToPulseWidthEnd)//�������������ڵ�����߽�����
        HS <= 0;//����ʼ
    else
        HS <= 1;//����ʼ
end
               
always@(posedge CLK) begin//��ʱ��������ʱ
    if(VertCount < VertTimeToPulseWidthEnd)//�������������ڵ����ϱ߽�����
        VS <= 0;//����ʼ
    else
        VS <= 1;//����ʼ
end

always@(posedge CLK) begin//��ʱ��������ʱ
    if((VertCount > VertTimeToBackPorchEnd) //������ݼ�������������ʾ���߽�����
              && (VertCount < VertTimeToDisplayTimeEnd) 
              && (HorzCount > HorzTimeToBackPorchEnd)
              && (HorzCount < HorzTimeToDisplayTimeEnd))
        COLOUR_OUT <= COLOUR_IN;//�������ɫΪ�������ɫ
    else
        
        COLOUR_OUT <= 0;//�����ɫ����,������
end

always@(posedge CLK) begin//��ʱ��������ʱ
    if((VertCount > VertTimeToBackPorchEnd) //������ݼ�������������ʾ���߽�����
              && (VertCount < VertTimeToDisplayTimeEnd) 
              && (HorzCount > HorzTimeToBackPorchEnd)
              && (HorzCount < HorzTimeToDisplayTimeEnd))
    ADDRH = HorzCount - HorzTimeToBackPorchEnd;//�����ַΪ��������ַ-��߽��ַ
    ADDRV = VertCount - VertTimeToBackPorchEnd;//�����ַΪ��������ַ-�ϱ߽��ַ
end

assign HorzOut = HorzCount;//�Ѻ����������ֵ����������˿�
assign VertOut = VertCount;//�������������ֵ����������˿�

endmodule