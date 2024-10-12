`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2022 11:52:08 PM
// Design Name: 
// Module Name: LessThan
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


module LessThan(
    input [9:0] a,
    input [9:0] b,
    output out
    );
    //a<b
    //if a[i] == 0 when b[i] == 1, instantly true
    //if a[i] == 1 when b[i] == 0, instantly false
    //if a[i] == b[i], don't know, check i-1
    wire [9:0] check, lt; //compare a and b
    assign check[9:0] = (a[9:0]^b[9:0]);
    //get value of first different bits
    assign lt[9] = check[9]&b[9];
    assign lt[8] = ~check[9]&check[8]&b[8];
    assign lt[7] = ~|check[9:8]&check[7]&b[7];
    assign lt[6] = ~|check[9:7]&check[6]&b[6];
    assign lt[5] = ~|check[9:6]&check[5]&b[5];
    assign lt[4] = ~|check[9:5]&check[4]&b[4];
    assign lt[3] = ~|check[9:4]&check[3]&b[3];
    assign lt[2] = ~|check[9:3]&check[2]&b[2];
    assign lt[1] = ~|check[9:2]&check[1]&b[1];
    assign lt[0] = ~|check[9:1]&check[0]&b[0];
    assign out = |lt[9:0];
endmodule
