`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 10:58:38 AM
// Design Name: 
// Module Name: HalfAdder
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


module HalfAdder(
    input a,
    input b,
    output c,
    output s
    );
    assign c = a & b;
    assign s = a ^ b;
endmodule
