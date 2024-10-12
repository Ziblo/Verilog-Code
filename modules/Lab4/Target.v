`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 02:19:01 PM
// Design Name: 
// Module Name: Target
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


module Target(
    input [3:0] D,
    input CE, clk,
    output [3:0] Q
    );
    FDRE #(.INIT(1'b0)) target0 (.C(clk), .CE(CE), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) target1 (.C(clk), .CE(CE), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) target2 (.C(clk), .CE(CE), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) target3 (.C(clk), .CE(CE), .D(D[3]), .Q(Q[3]));
endmodule
