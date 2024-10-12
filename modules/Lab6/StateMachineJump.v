`timescale 1ns / 1ps

module StateMachineJump(
    input jump, onplat, onborder, haspower, onhole, walkonwater, clk,
    output powerup, fall, rise, flash, dead
    );
    //get edges of jump
    wire old_jump;
    FDRE #(.INIT(1'b0)) edge_detector_jump  (.C(clk), .CE(1'b1), .D(jump), .Q(old_jump));
    wire jump_rising_edge, jump_falling_edge;
    assign jump_rising_edge = jump&~old_jump;
    assign jump_falling_edge = ~jump&old_jump;
    
    //state machine registers
    wire [5:0] D, Q;
    wire _Q0;
    assign Q[0] = ~_Q0;
    FDRE #(.INIT(1'b0)) sm_jump_reg0 (.C(clk), .CE(1'b1), .D(~D[0]), .Q(_Q0 ));
    FDRE #(.INIT(1'b0)) sm_jump_reg1 (.C(clk), .CE(1'b1), .D( D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0)) sm_jump_reg2 (.C(clk), .CE(1'b1), .D( D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0)) sm_jump_reg3 (.C(clk), .CE(1'b1), .D( D[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0)) sm_jump_reg4 (.C(clk), .CE(1'b1), .D( D[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0)) sm_jump_reg5 (.C(clk), .CE(1'b1), .D( D[5]), .Q(Q[5]));

    //call state machine logic
    smJumpLogic smlogic (.Q(Q), .jr(jump_rising_edge), .jf(jump_falling_edge), .j(jump), .hP(haspower), .op(onplat), .ob(onborder), .H(onhole), .W(walkonwater),
                        .D(D), .R(rise), .F(fall), .Pu(powerup), .Fl(flash), .d(dead));
endmodule

module smJumpLogic(
    input jr, jf, j, hP, op, ob, H, W,
    input [5:0] Q,
    output R, F, Pu, Fl, d,
    output [5:0] D
    );
    //one hot encoding
    assign R = Q[2]&hP;                 //rise
    assign F = Q[3]&~op | Q[4]&~ob&~W;  //fall
    assign Pu = Q[1]&~jf;               //Power Up
    assign Fl = |Q[5:4];                //Flash
    assign d = Q[5];                    //dead
    assign D[0] = Q[0]&~jr&~H | Q[3]&~j&op;            //A
    assign D[1] = Q[0]&jr&~H | Q[1]&~jf&~H | Q[3]&j&op;//B
    assign D[2] = Q[1]&jf | Q[2]&hP;                   //C
    assign D[3] = Q[2]&~hP | Q[3]&~op;                 //D
    assign D[4] = Q[0]&H | Q[4]&~ob | Q[1]&H;          //E
    assign D[5] = Q[4]&ob | Q[5];                      //F
endmodule