`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2022 02:22:25 PM
// Design Name: 
// Module Name: selector
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


module selector(
    input [3:0] sel,
    input [15:0] N,
    output [3:0] H
    );
    //if sel has more than one 1, theose signals will overlap.
    wire [3:0] H1, H2, H3, H4;
    //H is x[15:12] when sel=(1000)
    assign H1 = N[15:12] & {4{sel[3]}};
    //H is x[11:8] when sel=(0100)
    assign H2 = N[11:8] & {4{sel[2]}};
    //H is x[7:4] when sel=(0010)
    assign H3 = N[7:4] & {4{sel[1]}};
    //H is x[3:0] when sel=(0001)
    assign H4 = N[3:0] & {4{sel[0]}};
    assign H = (H1 | H2 | H3 | H4);
endmodule
