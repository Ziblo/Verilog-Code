`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 12:21:43 AM
// Design Name: 
// Module Name: top_sim
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


module top_sim();
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
reg [15:0] sw;
reg btnU, btnD, btnC, btnL, btnR;
Top_Level_Lab6 top_sim (.btnU(btnU), .btnD(btnD), .btnC(btnC), .btnR(btnR), .btnL(btnL), .sw(sw), .clk(clk));
initial begin
sw[15] = 1'b0;
#200;
sw[15] = 1'b1;
end
endmodule
