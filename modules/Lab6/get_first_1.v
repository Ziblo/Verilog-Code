`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 02:12:13 PM
// Design Name: 
// Module Name: get_first_1
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


module get_first_1(
    input [15:0] A,
    output [15:0] sel
    );
    //Go from MSB to LSB and output a 1 in the slot that first has a 1 and 0s elsewhere
    assign sel[15] = A[15]; //if MSH is 1 we just take that
    assign sel[14] = ~A[15]&A[14]; //if top layer is 0 but 2nd layer isn't, take that.
    assign sel[13] = ~|A[15:14]&A[13]; //etc...
    assign sel[12] = ~|A[15:13]&A[12];
    assign sel[11] = ~|A[15:12]&A[11];
    assign sel[10] = ~|A[15:11]&A[10];
    assign sel[9] = ~|A[15:10]&A[9];
    assign sel[8] = ~|A[15:9]&A[8];
    assign sel[7] = ~|A[15:8]&A[7];
    assign sel[6] = ~|A[15:7]&A[6];
    assign sel[5] = ~|A[15:6]&A[5];
    assign sel[4] = ~|A[15:5]&A[4];
    assign sel[3] = ~|A[15:4]&A[3];
    assign sel[2] = ~|A[15:3]&A[2];
    assign sel[1] = ~|A[15:2]&A[1];
    assign sel[0] = ~|A[15:1]&A[0];
endmodule
