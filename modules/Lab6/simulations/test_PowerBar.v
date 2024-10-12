`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 08:32:37 PM
// Design Name: 
// Module Name: test_PowerBar
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


module test_PowerBar();
//generate a fake clock signal (if this module needs a clock)
    reg clk;
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    initial    // Clock process for clkin
    begin
        #OFFSET
		  clk = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;
        end
    end
reg charge;
wire [7:0] Q;
PowerBar tst_pb (.clk(clk), .charge(charge), .Q(Q));
initial begin
#100;
charge = 1'b0;
#200;
charge = 1'b1;
#200;
charge = 1'b0;
#100;
charge = 1'b1;
#1000;
charge = 1'b0;
end
endmodule
