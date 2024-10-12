`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2022 09:35:03 AM
// Design Name: 
// Module Name: hex7seg
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


module hex7seg(
    input [3:0] n,
    output [6:0] seg
    );
    //if they match, its 0000
    //when at least one matches, the seg should be off
    //if there's a bit off, it has a 1
    //if all of them have 1s, the seg should be on
    assign seg[0] = ~(|(n^4'h1) & |(n^4'h4) & |(n^4'hB) & |(n^4'hD));
    assign seg[1] = ~(|(n^4'h5) & |(n^4'h6) & |(n^4'hB) & |(n^4'hC) & |(n^4'hE) & |(n^4'hF));
    assign seg[2] = ~(|(n^4'h2) & |(n^4'hC) & |(n^4'hE) & |(n^4'hF));
    assign seg[3] = ~(|(n^4'h1) & |(n^4'h4) & |(n^4'h7) & |(n^4'h9) & |(n^4'hA) & |(n^4'hF));
    assign seg[4] = ~(|(n^4'h1) & |(n^4'h3) & |(n^4'h4) & |(n^4'h5) & |(n^4'h7) & |(n^4'h9));
    assign seg[5] = ~(|(n^4'h1) & |(n^4'h2) & |(n^4'h3) & |(n^4'h7) & |(n^4'hD));
    assign seg[6] = ~(|(n^4'h0) & |(n^4'h1) & |(n^4'h7) & |(n^4'hC));
endmodule
