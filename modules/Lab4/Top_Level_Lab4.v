`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/26/2022 03:27:41 PM
// Design Name: 
// Module Name: Top_Level_Lab4
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


module Top_Level_Lab4(
    input clkin,
    input btnR,
    input btnU,
    input btnC,
    input [15:0] sw,
    output dp,
    output [15:0] led,
    output [3:0] an,
    output [6:0] seg
    );
    //establish clock
    wire clk, digsel, qsec;
    lab4_clks slowit (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel), .qsec(qsec));
    
    //establish time counter
    wire [5:0] time_count; //number of quarter seconds in binary
    wire reset_timer; //when the state machine tells us to reset
    Time_Counter tc (.clk(clk), .inc(qsec), .R(reset_timer), .Q(time_count));
    
    //determine when 4s and 2s
    wire FourSecs, TwoSecs;
    assign FourSecs = time_count[4];   //4 seconds is 16 quarter seconds
    assign TwoSecs  = time_count[3];   //2 seconds is 8 quarter seconds
    
    //Take rising edge from inputs
    wire G, S;
    edge_detector edgerG (.clock(clk), .X(btnC), .Y(G)); //btnC = GO!
    edge_detector edgerS (.clock(clk), .X(btnU), .Y(S)); //btnU = STOP!
    
    //get random 8-bit number
    wire [7:0] rnd;
    LFSR8 random (.clk(clk), .rnd(rnd));
    
    //Shift leds
    wire SHL, SHR;
    LED_Shifter led_sh (.in(SHL), .SHR(SHR), .SHL(SHL), .led(led), .clk(clk));//when shifting left, in=1, when shifting right, in=0
    
    //Load Target or Numbers from rnd into display
    wire Load_Numbers, Load_Target; // //
    wire [3:0] target;  //
    wire [7:0] nums;    //
    Numbers num (.clk(clk), .Q(nums), .CE(Load_Numbers), .D(rnd));//load nums int two rightmost digits
    Target tart (.clk(clk), .Q(target), .CE(Load_Target), .D(rnd[3:0])); //load target into leftmost digit
    
    //Determine match
    wire Match;
    wire [3:0] sum; //
    Add4 addNums (.A(nums[3:0]), .B(nums[7:4]), .S(sum), .Cin(1'b0));
    assign Match = ~|(sum^target); //sum == target
    
    //display target and nums and sum
    wire [15:0] disp_num; //
    assign disp_num[15:12] = target;
    assign disp_num[7:0] = nums;
    assign disp_num[11:8] = sum;
    
    //State Machine
    State_Machine sm (.clk(clk), .Go(G), .Stop(S), .FourSecs(FourSecs), .TwoSecs(TwoSecs),
                    .Match(Match), .LoadTarget(Load_Target), .ResetTimer(reset_timer),
                    .LoadNumbers(Load_Numbers), .SHR(SHR), .SHL(SHL), .FlashBoth(FB), .FlashAlt(FA));
    
    //output 16 bit bus into hex on display
    wire [3:0] ring, n; // //
    ring_counter4 ring_counter (.advance(digsel), .clk(clk), .ring(ring));
    
    //turn off decimal point
    assign dp = 1'b1;
    
    //control flash
    assign an[0] = ~ring[0]|(FB&time_count[0] | FA&~time_count[0]); //num1
    assign an[1] = ~ring[1]|(FB&time_count[0]| FA&~time_count[0]); //num2
    assign an[2] = ~ring[2]|~sw[15]; //never flashes
    assign an[3] = ~ring[3]|(FB&time_count[0]| FA&time_count[0]); //target
    
    //select digit and output 7seg
    selector sel (.sel(ring), .N(disp_num), .H(n));
    hex7seg h7s (.n(n), .seg(seg));
    
endmodule
