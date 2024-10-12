`timescale 1ns / 1ps

module collision(
    input [9:0] Layer1, Layer2,
    output out
    );
    wire [1:0] t; //take the t out of the RGBt
    assign t[0] = Layer1[0];
    assign t[1] = Layer2[0];
    assign out = &t[1:0]; //if both t's are high, they overlap.
endmodule
