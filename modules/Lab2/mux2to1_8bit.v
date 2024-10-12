`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 09:49:13 AM
// Design Name: 
// Module Name: mux2to1_8bit
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


module mux2to1_8bit(
    input s,
    input [7:0] I0,
    input [7:0] I1,
    output [7:0] Y
    );
    wire [7:0] S;
    assign S = {8{s}};
    assign Y = ~S & I0 | S & I1;
    
endmodule
