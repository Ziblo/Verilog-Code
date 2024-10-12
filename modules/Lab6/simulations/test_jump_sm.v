`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2022 06:04:22 PM
// Design Name: 
// Module Name: test_jump_sm
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


module test_jump_sm();
//generate a fake clock signal
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
reg jump, onplat, onborder, power, inhole;
wire charge, fall, rise, flash, dead;
StateMachineJump TestSMJ (.clk(clk), .jump(jump), .onplat(onplat), .onborder(onborder), .haspower(power), .onhole(inhole), .powerup(charge), .fall(fall), .rise(rise), .flash(flash), .dead(dead));
initial begin
jump = 1'b0;
onplat = 1'b1;
onborder = 1'b0;
power = 1'b0;
inhole = 1'b0;
#300;
jump = 1'b1;    //charge up jump
#100;
power = 1'b1;   //bar increases
#100;
jump = 1'b0;    //release!
onplat = 1'b0;
#100;
power = 1'b0;   //ran out of power
#100;
onplat = 1'b1;  //hit platform
#100;
jump = 1'b1;    //charge up jump
#100;
inhole = 1'b1;  //oh no!
onplat = 1'b0;
#100;
inhole = 1'b0;  //hole moves away
#100;
jump = 1'b0;    //release button :(
#100;
onborder = 1'b1;
end
endmodule
