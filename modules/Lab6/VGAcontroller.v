`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2022 02:28:51 PM
// Design Name: 
// Module Name: VGAcontroller
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


module VGAcontroller(
    input clk, //25MHz
    output Vsync, Hsync,
    output [19:0] PixelAddress,
    output indicator
    );
    wire [9:0] Hcount, Vcount;
    wire Hreset, Vreset;
    //count along horizontal axis
    FDRE #(.INIT(1'b0)) Hcount0 (.C(clk), .R(Hreset), .CE(1'b1), .D(~Hcount[0]), .Q(Hcount[0]));
    FDRE #(.INIT(1'b0)) Hcount1 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[1] ^ Hcount[0]), .Q(Hcount[1]));
    FDRE #(.INIT(1'b0)) Hcount2 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[2] ^ &Hcount[1:0]), .Q(Hcount[2]));
    FDRE #(.INIT(1'b0)) Hcount3 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[3] ^ &Hcount[2:0]), .Q(Hcount[3]));
    FDRE #(.INIT(1'b0)) Hcount4 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[4] ^ &Hcount[3:0]), .Q(Hcount[4]));
    FDRE #(.INIT(1'b0)) Hcount5 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[5] ^ &Hcount[4:0]), .Q(Hcount[5]));
    FDRE #(.INIT(1'b0)) Hcount6 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[6] ^ &Hcount[5:0]), .Q(Hcount[6]));
    FDRE #(.INIT(1'b0)) Hcount7 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[7] ^ &Hcount[6:0]), .Q(Hcount[7]));
    FDRE #(.INIT(1'b0)) Hcount8 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[8] ^ &Hcount[7:0]), .Q(Hcount[8]));
    FDRE #(.INIT(1'b0)) Hcount9 (.C(clk), .R(Hreset), .CE(1'b1), .D(Hcount[9] ^ &Hcount[8:0]), .Q(Hcount[9]));
    //count along vertical axis
    FDRE #(.INIT(1'b0)) Vcount0 (.C(clk), .R(Vreset), .CE(Hreset), .D(~Vcount[0]), .Q(Vcount[0]));
    FDRE #(.INIT(1'b0)) Vcount1 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[1] ^ Vcount[0]), .Q(Vcount[1]));
    FDRE #(.INIT(1'b0)) Vcount2 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[2] ^ &Vcount[1:0]), .Q(Vcount[2]));
    FDRE #(.INIT(1'b0)) Vcount3 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[3] ^ &Vcount[2:0]), .Q(Vcount[3]));
    FDRE #(.INIT(1'b0)) Vcount4 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[4] ^ &Vcount[3:0]), .Q(Vcount[4]));
    FDRE #(.INIT(1'b0)) Vcount5 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[5] ^ &Vcount[4:0]), .Q(Vcount[5]));
    FDRE #(.INIT(1'b0)) Vcount6 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[6] ^ &Vcount[5:0]), .Q(Vcount[6]));
    FDRE #(.INIT(1'b0)) Vcount7 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[7] ^ &Vcount[6:0]), .Q(Vcount[7]));
    FDRE #(.INIT(1'b0)) Vcount8 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[8] ^ &Vcount[7:0]), .Q(Vcount[8]));
    FDRE #(.INIT(1'b0)) Vcount9 (.C(clk), .R(Vreset), .CE(Hreset), .D(Vcount[9] ^ &Vcount[8:0]), .Q(Vcount[9]));
    assign PixelAddress = {Hcount, Vcount};
    //significant numbers
    wire H639, H654, H750, H799, V479, V488, V490, V524;
    assign H639 = ~|(Hcount^10'b1001111111);
    assign H654 = ~|(Hcount^10'b1010001110);
    assign H750 = ~|(Hcount^10'b1011101110);
    assign H799 = ~|(Hcount^10'b1100011111);
    assign V479 = ~|(Vcount^10'b0111011111);
    assign V488 = ~|(Vcount^10'b0111101000);
    assign V490 = ~|(Vcount^10'b0111101010);
    assign V524 = ~|(Vcount^10'b1000001100);
    assign Hreset = H799;
    assign Vreset = Hreset & V524;
    //Toggle Vsync and Hsync on and off with flip flops
    wire _Hsync, _Vsync; //initialize so sync starts high (using inverted in inverted out)
    FDRE #(.INIT(1'b0)) Toggle_Hsyn (.C(clk), .CE(H654 | H750), .D(~_Hsync), .Q(_Hsync)); //H654-H750
    FDRE #(.INIT(1'b0)) Toggle_Vsyn (.C(clk), .CE(Hreset&(V488 | V490)), .D(~_Vsync), .Q(_Vsync)); //V488-V490 (only toggle on Hreset, when Vcount increments)
    assign Hsync = ~_Hsync;
    assign Vsync = ~_Vsync;
    //Toggle indicator on and off with flip flops
    wire _Hindicator, _Vindicator; //initialize so that indicator starts high so that we don't miss pixel (0,0) (top left) //initialize so sync starts high (using inverted in inverted out)
    FDRE #(.INIT(1'b0)) Toggle_Hindc (.C(clk), .CE(H639 | H799), .D(~_Hindicator), .Q(_Hindicator)); //H639-H799
    FDRE #(.INIT(1'b0)) Toggle_Vindc (.C(clk), .CE(Hreset&(V479 | V524)), .D(~_Vindicator), .Q(_Vindicator)); //V479-V524
    assign indicator = ~_Hindicator&~_Vindicator; //indicator is on when we're in the Active Region both vertically and horizontally. (couldn't do this with just toggle)
    
endmodule
