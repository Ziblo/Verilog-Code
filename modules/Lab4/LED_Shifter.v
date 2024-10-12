`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 01:19:55 PM
// Design Name: 
// Module Name: LED_Shifter
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


module LED_Shifter(
    input in, //What to shift in
    input SHR, //subtract one
    input SHL, //add one
    output [15:0] led,
    input clk
    );
    //The LEDs can be controlled using a 16-bit shift register. 
    //Each time the target is matched, a 1 can be shifted in from the right, 
    //and when it is not matched, a 0 can be shifted in from the left.
    wire [15:0] bruh;
    FDRE #(.INIT(1'b0)) led_shifter_reg0  (.C(clk), .CE(SHR^SHL), .D(     in&SHL  | bruh[ 1]&SHR), .Q(bruh[ 0]));
    FDRE #(.INIT(1'b0)) led_shifter_reg1  (.C(clk), .CE(SHR^SHL), .D(bruh[0]&SHL  | bruh[ 2]&SHR), .Q(bruh[ 1]));
    FDRE #(.INIT(1'b0)) led_shifter_reg2  (.C(clk), .CE(SHR^SHL), .D(bruh[1]&SHL  | bruh[ 3]&SHR), .Q(bruh[ 2]));
    FDRE #(.INIT(1'b0)) led_shifter_reg3  (.C(clk), .CE(SHR^SHL), .D(bruh[2]&SHL  | bruh[ 4]&SHR), .Q(bruh[ 3]));
    FDRE #(.INIT(1'b0)) led_shifter_reg4  (.C(clk), .CE(SHR^SHL), .D(bruh[3]&SHL  | bruh[ 5]&SHR), .Q(bruh[ 4]));
    FDRE #(.INIT(1'b0)) led_shifter_reg5  (.C(clk), .CE(SHR^SHL), .D(bruh[4]&SHL  | bruh[ 6]&SHR), .Q(bruh[ 5]));
    FDRE #(.INIT(1'b0)) led_shifter_reg6  (.C(clk), .CE(SHR^SHL), .D(bruh[5]&SHL  | bruh[ 7]&SHR), .Q(bruh[ 6]));
    FDRE #(.INIT(1'b0)) led_shifter_reg7  (.C(clk), .CE(SHR^SHL), .D(bruh[6]&SHL  | bruh[ 8]&SHR), .Q(bruh[ 7]));
    FDRE #(.INIT(1'b0)) led_shifter_reg8  (.C(clk), .CE(SHR^SHL), .D(bruh[7]&SHL  | bruh[ 9]&SHR), .Q(bruh[ 8]));
    FDRE #(.INIT(1'b0)) led_shifter_reg9  (.C(clk), .CE(SHR^SHL), .D(bruh[8]&SHL  | bruh[10]&SHR), .Q(bruh[ 9]));
    FDRE #(.INIT(1'b0)) led_shifter_reg10 (.C(clk), .CE(SHR^SHL), .D(bruh[9]&SHL  | bruh[11]&SHR), .Q(bruh[10]));
    FDRE #(.INIT(1'b0)) led_shifter_reg11 (.C(clk), .CE(SHR^SHL), .D(bruh[10]&SHL | bruh[12]&SHR), .Q(bruh[11]));
    FDRE #(.INIT(1'b0)) led_shifter_reg12 (.C(clk), .CE(SHR^SHL), .D(bruh[11]&SHL | bruh[13]&SHR), .Q(bruh[12]));
    FDRE #(.INIT(1'b0)) led_shifter_reg13 (.C(clk), .CE(SHR^SHL), .D(bruh[12]&SHL | bruh[14]&SHR), .Q(bruh[13]));
    FDRE #(.INIT(1'b0)) led_shifter_reg14 (.C(clk), .CE(SHR^SHL), .D(bruh[13]&SHL | bruh[15]&SHR), .Q(bruh[14]));
    FDRE #(.INIT(1'b0)) led_shifter_reg15 (.C(clk), .CE(SHR^SHL), .D(bruh[14]&SHL |       in&SHR), .Q(bruh[15]));
    assign led = bruh;
endmodule
