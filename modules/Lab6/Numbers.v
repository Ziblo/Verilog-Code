`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 01:59:16 PM
// Design Name: 
// Module Name: Numbers
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


module Numbers10(
    input [9:0] D, init,
    input CE, clk, R,
    output [9:0] Q
    );
    wire [9:0] _Q;
    FDRE #(.INIT(1'b0)) number0 (.C(clk), .CE(CE), .R(R), .D(init[0]^D[0]), .Q(_Q[0]));
    FDRE #(.INIT(1'b0)) number1 (.C(clk), .CE(CE), .R(R), .D(init[1]^D[1]), .Q(_Q[1]));
    FDRE #(.INIT(1'b0)) number2 (.C(clk), .CE(CE), .R(R), .D(init[2]^D[2]), .Q(_Q[2]));
    FDRE #(.INIT(1'b0)) number3 (.C(clk), .CE(CE), .R(R), .D(init[3]^D[3]), .Q(_Q[3]));
    FDRE #(.INIT(1'b0)) number4 (.C(clk), .CE(CE), .R(R), .D(init[4]^D[4]), .Q(_Q[4]));
    FDRE #(.INIT(1'b0)) number5 (.C(clk), .CE(CE), .R(R), .D(init[5]^D[5]), .Q(_Q[5]));
    FDRE #(.INIT(1'b0)) number6 (.C(clk), .CE(CE), .R(R), .D(init[6]^D[6]), .Q(_Q[6]));
    FDRE #(.INIT(1'b0)) number7 (.C(clk), .CE(CE), .R(R), .D(init[7]^D[7]), .Q(_Q[7]));
    FDRE #(.INIT(1'b0)) number8 (.C(clk), .CE(CE), .R(R), .D(init[8]^D[8]), .Q(_Q[8]));
    FDRE #(.INIT(1'b0)) number9 (.C(clk), .CE(CE), .R(R), .D(init[9]^D[9]), .Q(_Q[9]));
    assign Q[9:0] = init[9:0]^_Q[9:0];
endmodule
