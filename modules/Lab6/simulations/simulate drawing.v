`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2022 02:54:11 PM
// Design Name: 
// Module Name: simulate drawing
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


module simulate_drawing();
reg [10:0] PixelX, PixelY;

//three layers
wire [9:0] RGBt0, RGBt1, RGBt2;

//Define colors
wire [8:0] light_red;
assign light_red = 9'b111001001;
wire [8:0] green;
assign green = 9'b000111000;
wire [8:0] blue;
assign blue = 9'b000000111;
wire [8:0] cyan;
assign cyan = 9'b000110110;

//draw to layer 0
draw sim_draw0 (.X(PixelX), .Y(PixelY), .x1(10'h000), .x2(10'h003), .y1(10'h000), .y2(10'h003), .color(light_red), .RGBt(RGBt0));

//draw to layer 1
draw sim_draw1 (.X(PixelX), .Y(PixelY), .x1(10'h003), .x2(10'h007), .y1(10'h003), .y2(10'h007), .color(cyan), .RGBt(RGBt1));

//draw to layer 2
draw sim_draw2 (.X(PixelX), .Y(PixelY), .x1(10'h002), .x2(10'h004), .y1(10'h002), .y2(10'h004), .color(blue), .RGBt(RGBt2));

//description:
// a blue 4x4 square in the upper left with a 4x4 red square overlapping on its bottom corner and a green 3x3 square overlapping both of them in the middle

//get transparency
wire [2:0] t;
assign t[0] = RGBt0[0];
assign t[1] = RGBt1[0];
assign t[2] = RGBt2[0];

//select top layer
wire [2:0] selector_t;
get_first_1 get_first_t (.A({13'h0000,t}), .sel(selector_t));
wire [8:0] RGB; //actual rgb value of current pixel
select_layer sel_layer (.sel({9'h000,selector_t}), .out(RGB), .in0(RGBt0[9:1]), .in1(RGBt1[9:1]), .in2(RGBt2[9:1]));

initial begin
//first layer
PixelX = 10'h000;
PixelY = 10'h000;
#50;
PixelX = 10'h001;
PixelY = 10'h000;
#50;
PixelX = 10'h002;
PixelY = 10'h000;
#50;
PixelX = 10'h003;
PixelY = 10'h000;
#50;
PixelX = 10'h004;
PixelY = 10'h000;
#50;
PixelX = 10'h005;
PixelY = 10'h000;
#50;
PixelX = 10'h006;
PixelY = 10'h000;
#50;
//second layer
PixelX = 10'h000;
PixelY = 10'h001;
#50;
PixelX = 10'h001;
PixelY = 10'h001;
#50;
PixelX = 10'h002;
PixelY = 10'h001;
#50;
PixelX = 10'h003;
PixelY = 10'h001;
#50;
PixelX = 10'h004;
PixelY = 10'h001;
#50;
PixelX = 10'h005;
PixelY = 10'h001;
#50;
PixelX = 10'h006;
PixelY = 10'h001;
#50;
//third layer
PixelX = 10'h000;
PixelY = 10'h002;
#50;
PixelX = 10'h001;
PixelY = 10'h002;
#50;
PixelX = 10'h002;
PixelY = 10'h002;
#50;
PixelX = 10'h003;
PixelY = 10'h002;
#50;
PixelX = 10'h004;
PixelY = 10'h002;
#50;
PixelX = 10'h005;
PixelY = 10'h002;
#50;
PixelX = 10'h006;
PixelY = 10'h002;
#50;
//fourth layer
PixelX = 10'h000;
PixelY = 10'h003;
#50;
PixelX = 10'h001;
PixelY = 10'h003;
#50;
PixelX = 10'h002;
PixelY = 10'h003;
#50;
PixelX = 10'h003;
PixelY = 10'h003;
#50;
PixelX = 10'h004;
PixelY = 10'h003;
#50;
PixelX = 10'h005;
PixelY = 10'h003;
#50;
PixelX = 10'h006;
PixelY = 10'h003;
#50;
//fifth layer
PixelX = 10'h000;//
PixelY =     10'h004;
#50;//             4
PixelX = 10'h001;//4
PixelY =     10'h004;
#50;//             4
PixelX = 10'h002;//4
PixelY =     10'h004;
#50;//             4
PixelX = 10'h003;//4
PixelY =     10'h004;
#50;//             4
PixelX = 10'h004;//4
PixelY =     10'h004;
#50;//             4
PixelX = 10'h005;//4
PixelY =     10'h004;
#50;//             4
PixelX = 10'h006;//4
PixelY =     10'h004;
#50;
//6th layer
PixelX = 10'h000;//
PixelY =     10'h005;
#50;//             5
PixelX = 10'h001;//5
PixelY =     10'h005;
#50;//             5
PixelX = 10'h002;//5
PixelY =     10'h005;
#50;//             5
PixelX = 10'h003;//5
PixelY =     10'h005;
#50;//             5
PixelX = 10'h004;//5
PixelY =     10'h005;
#50;//             5
PixelX = 10'h005;//5
PixelY =     10'h005;
#50;//             5
PixelX = 10'h006;//5
PixelY =     10'h005;
#50;
//7th layer
PixelX = 10'h000;//
PixelY =     10'h006;
#50;//             6
PixelX = 10'h001;//6
PixelY =     10'h006;
#50;//             6
PixelX = 10'h002;//6
PixelY =     10'h006;
#50;//             6
PixelX = 10'h003;//6
PixelY =     10'h006;
#50;//             6
PixelX = 10'h004;//6
PixelY =     10'h006;
#50;//             6
PixelX = 10'h005;//6
PixelY =     10'h006;
#50;//             6
PixelX = 10'h006;//6
PixelY =     10'h006;
#50;
end
endmodule