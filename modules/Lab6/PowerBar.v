`timescale 1ns / 1ps

module PowerBar(
    input charge,
    input clk, CE,
    output [6:0] Q
    );
    wire [6:0] D;
    wire ne0, ne64;
    assign ne64 = |(Q^8'h40);   //Q != 64
    assign ne0  = |(Q^8'h00);   //Q != 0
    assign D[0] = Q[0] ^ ((charge           & ne64) | (~charge            & ne0));
    assign D[1] = Q[1] ^ ((charge & &Q[  0] & ne64) | (~charge & ~|Q[  0] & ne0));
    assign D[2] = Q[2] ^ ((charge & &Q[1:0] & ne64) | (~charge & ~|Q[1:0] & ne0));
    assign D[3] = Q[3] ^ ((charge & &Q[2:0] & ne64) | (~charge & ~|Q[2:0] & ne0));
    assign D[4] = Q[4] ^ ((charge & &Q[3:0] & ne64) | (~charge & ~|Q[3:0] & ne0));
    assign D[5] = Q[5] ^ ((charge & &Q[4:0] & ne64) | (~charge & ~|Q[4:0] & ne0));
    assign D[6] = Q[6] ^ ((charge & &Q[5:0] & ne64) | (~charge & ~|Q[5:0] & ne0));
    
    FDRE #(.INIT(1'b0) ) t_count0 (.C(clk), .CE(CE), .D(D[0]), .Q(Q[0]));
    FDRE #(.INIT(1'b0) ) t_count1 (.C(clk), .CE(CE), .D(D[1]), .Q(Q[1]));
    FDRE #(.INIT(1'b0) ) t_count2 (.C(clk), .CE(CE), .D(D[2]), .Q(Q[2]));
    FDRE #(.INIT(1'b0) ) t_count3 (.C(clk), .CE(CE), .D(D[3]), .Q(Q[3]));
    FDRE #(.INIT(1'b0) ) t_count4 (.C(clk), .CE(CE), .D(D[4]), .Q(Q[4]));
    FDRE #(.INIT(1'b0) ) t_count5 (.C(clk), .CE(CE), .D(D[5]), .Q(Q[5]));
    FDRE #(.INIT(1'b0) ) t_count6 (.C(clk), .CE(CE), .D(D[6]), .Q(Q[6]));
endmodule
