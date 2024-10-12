`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 10:36:18 AM
// Design Name: 
// Module Name: top_level
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


module top_level(
    input [15:0] sw,
    input btnU,
    input btnR,
    input clkin,
    output [6:0] seg,
    output dp,
    output [15:0] led,
    output [3:0] an
    );
    wire [7:0] StoHex;
    wire dig_sel, overflow;
    wire [6:0] temp_seg0;
    wire [6:0] temp_seg1;
    wire [6:0] seggs;
    //leds correspond to their switches
    assign led[15:0] = sw[15:0];
    //upper 8 switches (+/-) lower 8 switches = StoHex
    AddSub8 addsub8 (.A(sw[15:8]), .B(sw[7:0]), .sub(btnU), .ovfl(overflow), .S(StoHex));
    //load both hexadecimal digits of StoHex into their own 7 bit busses
    hex7seg lower4 (.n(StoHex[3:0]),.seg(temp_seg0[6:0]));
    hex7seg upper4 (.n(StoHex[7:4]),.seg(temp_seg1[6:0]));
    //call clock to rapidly switch between 0 and 1 (for the display)
    lab2_digsel clock (.clkin(clkin), .greset(btnR), .digsel(dig_sel));
    //choose between temp_seg1 and temp_seg2 based on dig_sel. Output seggs. (extra bit is 0 by default)
    mux2to1_8bit digit_selector (.s(dig_sel), .I0({1'b0,temp_seg0[6:0]}), .I1({1'b0,temp_seg1[6:0]}), .Y(seggs[6:0]));
    assign seg = seggs; //assign segment display to whichever temp_seg is chosen by the clock at the time
    assign dp = ~overflow; //dp is on(low) when overflow is true(high)
    assign an[0] = dig_sel; //an[0] is on(low) when dig_sel is 0(seggs=temp_seg1)   (in sync with temp_seg0)
    assign an[1] = ~dig_sel;//an[1] is on(low) when dig_sel is 1(seggs=temp_seg2)   (in sync with temp_seg1)
    assign an[2] = 1'b1;//off(high)
    assign an[3] = 1'b1;//off(high)
endmodule
