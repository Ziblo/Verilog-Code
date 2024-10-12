`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 11:49:46 AM
// Design Name: 
// Module Name: AddSub8
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


module AddSub8(
    input [7:0] A,
    input [7:0] B,
    input sub,
    output ovfl,
    output [7:0] S
    );
    wire [8:0] C;
    wire [7:0] Kbus;
    wire [7:0] BxorK;
    assign Kbus = {8{sub}};
    assign BxorK = B^Kbus;
    assign C[0] = sub;
    FA f [7:0] (.a(A[7:0]), .b(BxorK[7:0]), .Cin(C[7:0]), .s(S[7:0]), .Cout(C[8:1]));
    assign ovfl = (~sub & ~A[7] & ~B[7] & S[7]) | (~sub & A[7] & B[7] & ~S[7]) | (sub & ~A[7] & B[7] & S[7]) | (sub & A[7] & ~B[7] & ~S[7]);
    
endmodule
