`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 05:23:58 PM
// Design Name: 
// Module Name: Add10
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


module Add10(
    input [9:0] A,
    input [9:0] B,
    input Cin,
    output [9:0] S,
    output Cout
    );
    //S = A + B
    wire [9:0] C;
    FA f1 (.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(C[0]));
    FA f [9:1] (.a(A[9:1]), .b(B[9:1]), .Cin(C[8:0]), .s(S[9:1]), .Cout(C[9:1]));
    assign Cout = C[9];
endmodule
