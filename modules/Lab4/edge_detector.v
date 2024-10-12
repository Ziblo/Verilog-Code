`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/11/2022 11:25:17 AM
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
    input clock,
    input X,
    output Y
    );
    //EDGE DETECTION
    wire old_X;
    FDRE edge_X (.C(clock), .CE(1'b1), .D(X), .Q(old_X));
    assign Y = ~old_X&X;
    //Edge detection over
endmodule
