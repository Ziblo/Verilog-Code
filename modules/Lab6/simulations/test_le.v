`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2022 09:55:43 PM
// Design Name: 
// Module Name: test_le
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


module test_inequalities();
reg [9:0] A, B;
wire gte, lte, lt;
greater_or_eq asf (.a(A), .b(B), .out(gte));
less_or_eq assa (.a(A), .b(B), .out(lte));
LessThan assea (.a(A), .b(B), .out(lt));
initial begin
A = 10'b0000000000;
B = 10'b0000000000;
#100;
B = 10'b0000000001;
#100;
A = 10'b0000000010;
#100;
B = 10'b0000000011;
#100;
A = 10'b0000000100;
end
endmodule
