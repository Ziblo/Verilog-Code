`timescale 1ns / 1ps

module test_numbers10new();
//generate a fake clock signal
    reg clk;
    parameter PERIOD = 10;
    parameter real DUTY_CYCLE = 0.5;
    parameter OFFSET = 2;
    initial    // Clock process for clkin
    begin
        #OFFSET
		  clk = 1'b1;
        forever
        begin
            #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = ~clk;
        end
    end

reg [9:0] D, init;
reg CE, R;
wire [9:0] Q;
Numbers10 test_num10 (.D(D), .init(init), .CE(CE), .Q(Q), .clk(clk), .R(R));
initial begin
D = 10'h000;
init = 10'h420;
CE = 1'b0;
R = 1'b0;
#100;
D = 10'h888;
#100;
CE = 1'b1;
#100;
CE = 1'b0;
#100;
R = 1'b1;
#100;
R = 1'b0;
#100;
D = 10'h777;
#100;
CE = 1'b1;
#100;
CE = 1'b0;
end
endmodule
