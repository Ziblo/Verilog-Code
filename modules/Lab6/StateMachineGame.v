`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2022 08:26:19 PM
// Design Name: 
// Module Name: StateMachineGame
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


module StateMachineGame(
    input clk, dead, ball_off, hole_off, collision, start, two_secs,
    output rand_hole, rand_ball, ball_moving, hole_moving, reset_ball, reset_hole, add_point, ball_flash, reset_timer
    );
    //state machine registers
    wire [1:0] Q, D;
    FDRE #(.INIT(1'b0)) sm_game_reg0 (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) sm_game_reg1 (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));

    //call upon the logic
    smGameLogic smlogicG (.S(start), .C(collision), .bo(ball_off), .ho(hole_off), .d(dead), .s2(two_secs), .Q(Q),
                          .rb(rand_ball), .rh(rand_hole), .sb(reset_ball), .sh(reset_hole), .mb(ball_moving), .mh(hole_moving), .ap(add_point), .F(ball_flash), .rt(reset_timer), .D(D));
endmodule

module smGameLogic(
    input S, C, bo, ho, d, s2,
    input [1:0] Q,
    output rb, rh, sb, sh, mb, mh, ap, F, rt,
    output [1:0] D
    );
    assign rb = ~|Q[1:0]&S | Q[0]&bo | &Q[1:0]&s2;
    assign rh = ~|Q[1:0]&S | Q[0]&ho;
    assign sb = bo | &Q[1:0]&s2;
    assign sh = ho;
    assign mb = Q[1]^Q[0];
    assign mh = ~(Q[1]&~Q[0] | ~|Q[1:0]);
    assign ap = &Q[1:0]&s2;
    assign F = &Q[1:0];
    assign rt = ~Q[1]&Q[0]&C;
    assign D[0] = ~|Q[1:0]&S | Q[0]&~d;
    assign D[1] = (Q[1]^Q[0])&(C|d) | &Q[1:0]&~s2;
endmodule