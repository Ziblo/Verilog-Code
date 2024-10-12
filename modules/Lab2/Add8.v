`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 11:07:56 AM
// Design Name: 
// Module Name: Add8
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


module Add8(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] S,
    output Cout
    );
    wire [7:0] C;
    FA f1 (.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(C[0]));
    FA f [7:1] (.a(A[7:1]), .b(B[7:1]), .Cin(C[6:0]), .s(S[7:1]), .Cout(C[7:1]));
    assign Cout = C[7];
    
endmodule
