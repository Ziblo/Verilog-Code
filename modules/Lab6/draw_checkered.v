`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 04:56:54 PM
// Design Name: 
// Module Name: draw_checkered
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


module draw_checkered(
    input [10:0] x1, y1, x2, y2, X, Y,
    input [8:0] color1, color2,
    output [9:0] RGBt
    );
    //if x1 <= x <= x2;
    //  rgb = color
    wire X_IsBetween, Y_IsBetween;
    IsBetween a1 (.lower(x1), .X(X), .upper(x2), .out(X_IsBetween));
    IsBetween b1 (.lower(y1), .X(Y), .upper(y2), .out(Y_IsBetween));
    assign RGBt[9:0] = {{9{X_IsBetween&Y_IsBetween&(X[1]^Y[1])}}&color1[8:0] | {9{X_IsBetween&Y_IsBetween&~(X[1]^Y[1])}}&color2[8:0], X_IsBetween&Y_IsBetween};
endmodule
