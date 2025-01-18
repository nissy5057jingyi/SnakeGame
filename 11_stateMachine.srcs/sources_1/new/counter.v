
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
//�����˶���ֻ������ʱ�������ز��л��ᶯ
//���ļ�����Ϊ:���յ�ǰһ���˵�ʹ���źź�,��ʱ�������ؼ���,��10����,�Ѵ����źŴ���ȥ,�����N����ʱ��������ֵ

//�����ļ��Ͷ˿�
module Generic_counter( //�ļ���
    CLK,//�˿���,�ڶ����ļ��Ͷ˿ڵ�ʱ���Ȳ�������������,�ڶ��幦�ܵ�ʱ���ٶ���
    RESET,//����д�����ɵ��ļ�ʱ������д��
    ENABLE,
    TRIG_OUT,
    COUNT
    );
  
//���幦��

    //�����ļ��ڵĿɵ�����
    parameter COUNTER_WIDTH = 4;//COUNTERת��ʱ�ӵı���
    parameter COUNTER_MAX = 9;//COUNTER�����ֵ
    parameter COUNTER_INIT = 0;//COUNTER����Сֵ
    
    //����˿�
    input CLK;//��������˿�Ϊ����
    input RESET;//��������˿�Ϊ����
    input ENABLE;//��������˿�Ϊ����
    output TRIG_OUT;//��������˿�Ϊ���
    output  [COUNTER_WIDTH - 1: 0] COUNT;//��������˿�Ϊ�����ɲ������Ƶ����
    
    //�������
    reg [COUNTER_WIDTH - 1: 0] count_value;//����һ����ѹԴ,�����ɫѡ��
    reg Trigger_out;//����һ����ѹԴ,����Ƿ񴥷�
    
    //��������
    //������������,�÷����仯��һ���������ı���,���Ƕ˿�
    always@(posedge CLK) begin//��ʱ��������
        if(RESET)//�������
            count_value <= 0;//����������
        else begin
            if(ENABLE) begin//���ʹ��,�����ͼ�һ
                if(count_value == COUNTER_MAX) //������������ֵ
                    count_value <= 0;//��������
                else
                    count_value <= count_value + 1;//���������һ
            end
        end
    end 
    always@(posedge CLK) begin//��ʱ��������
        if(RESET)//�������
            Trigger_out <= 0;//��������
        else begin
            if(ENABLE && (count_value == COUNTER_MAX))//�����ǰһ��ʹ���ұ��ּ��������
                Trigger_out <= 1;//������һ��
            else
                Trigger_out <= 0;//���򲻴�����һ��
        end
    end
    
    assign COUNT = count_value;//�ѱ���ֵ������˿�
    assign TRIG_OUT = Trigger_out;//�ѱ���ֵ������˿�
endmodule
