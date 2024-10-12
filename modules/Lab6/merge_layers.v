`timescale 1ns / 1ps

module MergeLayers(
    input [9:0] LayerAbove, LayerBelow, //RGBt format
    output [9:0] RGBt
    );
    wire tAbove, tBelow;
    assign tAbove = LayerAbove[0];
    assign tBelow = LayerBelow[0];
    assign RGBt = LayerAbove[9:0]&{10{tAbove}} | LayerBelow[9:0]&{10{~tAbove&tBelow}};
endmodule
