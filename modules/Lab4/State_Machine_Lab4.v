`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/25/2022 03:59:49 PM
// Design Name: 
// Module Name: State_Machine
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


module State_Machine(
    input Go,
    input Stop,
    input FourSecs,
    input TwoSecs,
    input Match,
    input clk,
    output LoadTarget,
    output ResetTimer,
    output LoadNumbers,
    output SHR,
    output SHL,
    output FlashBoth,
    output FlashAlt
    );
    
    wire [1:0] Q;
    wire [1:0] D;
    
    state_machine_logic  state_logic (.Q(Q), .s2(TwoSecs), .s4(FourSecs), .G(Go), .S(Stop), .M(Match), .D(D), .LT(LoadTarget), .RT(ResetTimer), .LN(LoadNumbers), .SL(SHL), .SR(SHR), .FB(FlashBoth), .FA(FlashAlt));
    
    FDRE #(.INIT(1'b0)) Q0_FF (.C(clk), .CE(1'b1), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0)) Q1_FF (.C(clk), .CE(1'b1), .D(D[1]), .Q(Q[1]));
endmodule

module state_machine_logic(
    input [1:0] Q,
    input s2,
    input s4,
    input G,
    input S,
    input M,
    output [1:0] D,
    output LT,
    output RT,
    output LN,
    output SL,
    output SR,
    output FB,
    output FA
    );
    
    assign D[1] = ~Q[1]&Q[0]&s2 | Q[1]&~Q[0] | Q[1]&~s4;
    assign D[0] = ~Q[1]&~Q[0]&G | Q[0]&~s2&~s4 | Q[1]&~s4&S | Q[1]&Q[0]&~s4;
    assign LT = ~Q[1]&~Q[0]&G;
    assign RT = ~Q[1]&~Q[0] | ~Q[1]&s2 | ~Q[0]&S | ~Q[0]&s2;
    assign LN = ~Q[1]&Q[0]&s2 | Q[1]&~Q[0]&s2&~S;
    assign SL = Q[1]&Q[0]&s4&M;
    assign SR = Q[1]&Q[0]&s4&~M;
    assign FB = Q[1]&~Q[0]&S&~M | Q[1]&Q[0]&~s4&~M;
    assign FA = Q[1]&~Q[0]&S&M | Q[1]&Q[0]&~s4&M;

endmodule