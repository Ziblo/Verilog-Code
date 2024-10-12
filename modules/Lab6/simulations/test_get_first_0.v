`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 02:21:04 PM
// Design Name: 
// Module Name: test_get_first_0
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


module test_get_first_1();
reg [7:0] A;
wire [7:0] sel;
get_first_1 tst_get_first (.A({8'h00, A}), .sel(sel));
initial begin
A = 8'h3A;
#100;
A = 8'h61;
#100;
A = 8'h69;
#100;
A = 8'h00;
#100;
A = 8'h02;
end
endmodule
