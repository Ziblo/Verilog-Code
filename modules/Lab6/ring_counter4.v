`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/12/2022 02:38:10 PM
// Design Name: 
// Module Name: ring_counter4
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


module ring_counter4(
    input advance,
    input clk,
    output [3:0] ring
    );
    wire [3:0] Din;
    wire bruh;
    assign Din[0] = ~bruh;
    FDRE #(.INIT(1'b0)) ring_flop0 (.C(clk), .CE(advance), .D(~Din[3]), .Q(bruh));
    FDRE #(.INIT(1'b0)) ring_flop1 (.C(clk), .CE(advance), .D(Din[0]), .Q(Din[1]));
    FDRE #(.INIT(1'b0)) ring_flop2 (.C(clk), .CE(advance), .D(Din[1]), .Q(Din[2]));
    FDRE #(.INIT(1'b0)) ring_flop3 (.C(clk), .CE(advance), .D(Din[2]), .Q(Din[3]));
    assign ring = Din;
endmodule