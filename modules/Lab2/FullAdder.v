`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2022 10:52:15 AM
// Design Name: 
// Module Name: FullAdder
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


module FullAdder(
    input a,
    input b,
    input Cin,
    output s,
    output Cout
    );
    
    wire c1, c2, s1;
    
    HalfAdder HA1 (.a(a), .b(b), .s(s1), .c(c1));
    HalfAdder HA2 (.a(Cin), .b(s1), .s(s), .c(c2));
    assign Cout = c1 | c2;
    
endmodule
