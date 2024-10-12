`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 08:09:56 PM
// Design Name: 
// Module Name: Add4
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


module Add4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
    );
    wire [3:0] C;
    FA f1 (.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(C[0]));
    FA f [3:1] (.a(A[3:1]), .b(B[3:1]), .Cin(C[2:0]), .s(S[3:1]), .Cout(C[3:1]));
    assign Cout = C[3];
endmodule
