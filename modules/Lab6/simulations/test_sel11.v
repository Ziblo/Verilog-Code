`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 02:30:26 PM
// Design Name: 
// Module Name: test_sel11
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


module test_sel11();
reg [7:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10;
reg [10:0] A;
wire [10:0] sel;
wire [7:0] out;
get_first_1 tst_s_get_first (.A({5'h00,A}), .sel(sel));
select_layer tst_s_selector (.sel(sel), .out(out), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .in4(in4), .in5(in5), .in6(in6), .in7(in7), .in8(in8), .in9(in9), .in10(in10));
initial begin
in0 = 8'hFF;
in1 = 8'h11;
in2 = 8'h22;
in3 = 8'h33;
in4 = 8'h44;
in5 = 8'h55;
in6 = 8'h66;
in7 = 8'h77;
in8 = 8'h88;
in9 = 8'h99;
in10 = 8'hAA;
A = 10'h010;
#100;
A = 10'h203;
#100;
A = 10'h013;
#100;
A = 10'h052;
#100;
A = 10'h000;
#100;
A = 10'hFF0;
#100;
A = 10'h001;
end
endmodule
