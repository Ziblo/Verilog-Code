`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 12:06:47 AM
// Design Name: 
// Module Name: IsBetween
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


module IsBetween(
    input [9:0] lower, X, upper,
    output out
    );
    //return (lower <= X < upper)
    wire [9:0] A, B, C;
    assign A = lower;
    assign B = X;
    assign C = upper;
    wire A_LT_B, B_LT_C, A_EQ_B;
    LessThan LT0 (.a(A), .b(B), .out(A_LT_B));
    LessThan LT1 (.a(B), .b(C), .out(B_LT_C));
    assign A_EQ_B = ~|(A^B);
    assign out = (A_LT_B | A_EQ_B) & B_LT_C; //A <= B < C
endmodule
