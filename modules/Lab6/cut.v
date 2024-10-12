`timescale 1ns / 1ps

//like the draw function except cuts out a drawn area from a layer
module cut(
    input [9:0] x1, y1, x2, y2, X, Y, Layer,
    output [9:0] RGBt
    );
    wire X_IsBetween, Y_IsBetween;
    IsBetween a1 (.lower(x1), .X(X), .upper(x2), .out(X_IsBetween));
    IsBetween b1 (.lower(y1), .X(Y), .upper(y2), .out(Y_IsBetween));
    assign RGBt[9:0] = {~{9{X_IsBetween&Y_IsBetween}}&Layer[9:1], ~(X_IsBetween&Y_IsBetween)};
endmodule
