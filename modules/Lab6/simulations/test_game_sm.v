`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2022 01:37:34 AM
// Design Name: 
// Module Name: test_game_sm
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


module test_game_sm();
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
reg dead, ball_off, hole_off, collision, start, two_secs;
wire rand_hole, rand_ball, ball_moving, hole_moving, reset_ball, reset_hole, add_point, ball_flash, reset_timer;
StateMachineGame StateMachineGame (.clk(clk), .start(start), .dead(dead), .two_secs(two_secs), .ball_off(ball_off), .hole_off(hole_off), .collision(collision), .rand_hole(rand_hole), .rand_ball(rand_ball), .ball_moving(ball_moving), .hole_moving(hole_moving), .reset_ball(reset_ball), .reset_hole(reset_hole), .add_point(add_point), .ball_flash(ball_flash), .reset_timer(reset_timer));
initial begin
dead = 1'b0;
ball_off = 1'b0;
hole_off = 1'b0;
collision = 1'b0;
start = 1'b0;
two_secs = 1'b0;
#300;
start = 1'b1;       //start game
#100;
start = 1'b0;
#100;
ball_off = 1'b1;    //ball & hole pass through
#100;
ball_off = 1'b0;
#100;
hole_off = 1'b1;
#100;
hole_off = 1'b0;
#100;
collision = 1'b1;   //score a ball
#100;
collision = 1'b0;
#100;
collision = 1'b1;
#100;
collision = 1'b0;
#100;
two_secs = 1'b1;
#100;
two_secs = 1'b0;
#100;
ball_off = 1'b1;    //ball & hole pass through
#100;
ball_off = 1'b0;
#100;
hole_off = 1'b1;
#100;
hole_off = 1'b0;
#100;
dead = 1'b1;        //dead
#100;
ball_off = 1'b1;    //ball pass through
#100;
ball_off = 1'b0;
#100;
end
endmodule
