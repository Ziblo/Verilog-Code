`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2022 02:52:47 PM
// Design Name: 
// Module Name: draw
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


module draw(
    input [9:0] x1, y1, x2, y2, X, Y,
    input [8:0] color,
    input off, //for flashing
    output [9:0] RGBt
    );
    //IF (x1 <= X < x2) AND (y1 <= Y < y2):
    //    rgb = color
    wire X_IsBetween, Y_IsBetween;
    IsBetween a1 (.lower(x1), .X(X), .upper(x2), .out(X_IsBetween));
    IsBetween b1 (.lower(y1), .X(Y), .upper(y2), .out(Y_IsBetween));
    assign RGBt[9:0] = {{9{X_IsBetween&Y_IsBetween&~off}}&color[8:0], X_IsBetween&Y_IsBetween&~off};
endmodule
