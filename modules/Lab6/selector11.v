`timescale 1ns / 1ps

module select_layer(
    input [10:0] sel,
    input [8:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15,
    output [8:0] out
    );
    //only one bit of sel is on at a time.
    //it determines which input goes to out
    //there should always be a layer selected, but if there isn't, it will default to (9'h000)
    wire [8:0] def;
    assign def = 9'h000; //default
    assign out = {9{sel[0]}}&in0 | {9{sel[1]}}&in1 | {9{sel[2]}}&in2 | {9{sel[3]}}&in3 | {9{sel[4]}}&in4 | {9{sel[5]}}&in5 | {9{sel[6]}}&in6 | {9{sel[7]}}&in7 | {9{sel[8]}}&in8 | {9{sel[9]}}&in9 | {9{sel[10]}}&in10 | {9{sel[11]}}&in11 | {9{sel[12]}}&in12 | {9{sel[13]}}&in13 | {9{sel[14]}}&in14 | {9{sel[15]}}&in15 | {9{~|sel}}&def;
endmodule
