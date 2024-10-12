`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/24/2022 01:40:26 PM
// Design Name: 
// Module Name: LFSR8
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


module LFSR8(
    input clk,
    output [7:0] rnd
    );
    wire D0, _rnd0;
    assign D0 = rnd[0]^rnd[5]^rnd[6]^rnd[7];
    //initialize them to an arbitrary number (seed: 10000000)
    FDRE #(.INIT(1'b0)) lfsr_flop0 (.C(clk), .CE(1'b1), .D(~D0), .Q(_rnd0));
    assign rnd[0] = ~_rnd0; //first flip flop is inverted so that global reset will set the seed to 1000000 
    FDRE #(.INIT(1'b0)) lfsr_flop1 (.C(clk), .CE(1'b1), .D(rnd[0]), .Q(rnd[1]));
    FDRE #(.INIT(1'b0)) lfsr_flop2 (.C(clk), .CE(1'b1), .D(rnd[1]), .Q(rnd[2]));
    FDRE #(.INIT(1'b0)) lfsr_flop3 (.C(clk), .CE(1'b1), .D(rnd[2]), .Q(rnd[3]));
    FDRE #(.INIT(1'b0)) lfsr_flop4 (.C(clk), .CE(1'b1), .D(rnd[3]), .Q(rnd[4]));
    FDRE #(.INIT(1'b0)) lfsr_flop5 (.C(clk), .CE(1'b1), .D(rnd[4]), .Q(rnd[5]));
    FDRE #(.INIT(1'b0)) lfsr_flop6 (.C(clk), .CE(1'b1), .D(rnd[5]), .Q(rnd[6]));
    FDRE #(.INIT(1'b0)) lfsr_flop7 (.C(clk), .CE(1'b1), .D(rnd[6]), .Q(rnd[7]));
endmodule
