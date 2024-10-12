`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 02:58:46 PM
// Design Name: 
// Module Name: Time_Counter
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


module counter10(
    input inc,
    input R,
    input clk,
    output [9:0] Q
    );
    wire [9:0] D;
    assign D[9] = Q[9]^inc & &Q[8:0];
    assign D[8] = Q[8]^inc & &Q[7:0];
    assign D[7] = Q[7]^inc & &Q[6:0];
    assign D[6] = Q[6]^inc & &Q[5:0];
    assign D[5] = Q[5]^inc & &Q[4:0];
    assign D[4] = Q[4]^inc & &Q[3:0]; 
    assign D[3] = Q[3]^inc & &Q[2:0];
    assign D[2] = Q[2]^inc & &Q[1:0];
    assign D[1] = Q[1]^inc & Q[0];
    assign D[0] = Q[0]^inc;
    FDRE #(.INIT(1'b0)) count0 (.C(clk), .R(R), .CE(inc), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) count1 (.C(clk), .R(R), .CE(inc), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) count2 (.C(clk), .R(R), .CE(inc), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) count3 (.C(clk), .R(R), .CE(inc), .D(D[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) count4 (.C(clk), .R(R), .CE(inc), .D(D[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0)) count5 (.C(clk), .R(R), .CE(inc), .D(D[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0)) count6 (.C(clk), .R(R), .CE(inc), .D(D[6]), .Q(Q[6]));
    FDRE #(.INIT(1'b0)) count7 (.C(clk), .R(R), .CE(inc), .D(D[7]), .Q(Q[7]));
    FDRE #(.INIT(1'b0)) count8 (.C(clk), .R(R), .CE(inc), .D(D[8]), .Q(Q[8]));
    FDRE #(.INIT(1'b0)) count9 (.C(clk), .R(R), .CE(inc), .D(D[9]), .Q(Q[9]));
endmodule
