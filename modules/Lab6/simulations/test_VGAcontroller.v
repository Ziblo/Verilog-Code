`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2022 03:19:07 PM
// Design Name: 
// Module Name: test_VGAcontroller
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


module test_VGAcontroller();
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

//outputs
wire Hsync, Vsync, indicator;
wire [19:0] PixelAddress;
wire [9:0] X, Y;
assign X = PixelAddress[19:10];
assign Y = PixelAddress[9:0];
VGAcontroller test (.clk(clk), .Hsync(Hsync), .Vsync(Vsync), .PixelAddress(PixelAddress), .indicator(indicator));
endmodule
