`timescale 1ns / 1ps

module Top_Level_Lab6(
    input btnU,
    input btnD,
    input btnC,
    input btnR,
    input btnL,
    input [15:0] sw,
    input clkin,
    output [6:0] seg,
    output dp,
    output [3:0] an,
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Vsync,
    output Hsync,
    output [15:0] led
    );
    
    //get the clock and digsel
    wire clk, digsel;
    labVGA_clks not_so_slow (.clkin(clkin), .greset(btnR), .clk(clk), .digsel(digsel));
    
    //VGA controller
    wire [19:0] PixelAddress;
    wire [9:0] PixelX, PixelY;
    wire indicator;
    VGAcontroller VGActrl (.clk(clk), .Vsync(Vsync), .Hsync(Hsync), .PixelAddress(PixelAddress), .indicator(indicator));
    assign PixelX = PixelAddress[19:10];
    assign PixelY = PixelAddress[9:0];
    
    //Frame signal
    wire frame;
    edge_detector ed_frame (.X(Vsync), .Y(frame), .clock(clk));

    //Debug color playground
    /*
      assign vgaBlue = sw[8:6]&{3{indicator}};
      assign vgaRed = sw[2:0]&{3{indicator}};
      assign vgaGreen = sw[5:3]&{3{indicator}};
    */

    //Define colors
    wire [8:0] red;
    assign red = 9'b111000000;
    wire [8:0] black;
    assign black = 9'b000000000;
    wire [8:0] light_red;
    assign light_red = 9'b111001001;
    wire [8:0] green;
    assign green = 9'b000111000;
    wire [8:0] blue;
    assign blue = 9'b000000111;
    wire [8:0] cyan;
    assign cyan = 9'b000111111;
    wire [8:0] magenta;
    assign magenta = 9'b111000111;
    wire [8:0] yellow;
    assign yellow = 9'b111111000;
    //color of specific objects
    wire [8:0] c_platform;
    assign c_platform = 9'b011011011;
    wire [8:0] c_platform_bot;
    assign c_platform_bot = 9'b111111111;
    wire [8:0] c_player;
    assign c_player = magenta;
    wire [8:0] c_power_bar;
    assign c_power_bar = green;
    wire [8:0] c_ball;
    assign c_ball = yellow;
    
    //2sec (for flash)
    wire [9:0] frame_count;
    wire SM_two_secs, qsec;
    counter10 frame_counter (.inc(frame), .R(sm_reset_timer), .clk(clk), .Q(frame_count));
    assign SM_two_secs = frame_count[7];  //   2 seconds is about 128 frames = 2^(7) frames
    assign qsec        = frame_count[4];  //0.25 seconds is about  16 frames = 2^(4) frames

    //state machine
    wire sm_reset_timer, sm_player_rise, sm_player_fall, sm_charge_power_bar, sm_player_flash, sm_player_dead, sm_walk_on_water;
    wire sm_rand_hole, sm_rand_ball, sm_ball_moving, sm_hole_moving, sm_reset_ball, sm_reset_hole, sm_add_point,  sm_ball_flash;
    wire btnStart;
    
    //cheats
    assign sm_walk_on_water = sw[15];

    //conditions
    wire SM_inhole, SM_on_plat, SM_on_border, SM_hit_ball, SM_power, SM_ball_off, SM_hole_off;
    edge_detector edge_btnC (.X(btnC), .Y(btnStart), .clock(clk));
    StateMachineGame StateMachineGame (.clk(clk), .start(btnStart), .dead(sm_player_dead), .two_secs(SM_two_secs), .ball_off(SM_ball_off), .hole_off(SM_hole_off), .collision(SM_hit_ball), .rand_hole(sm_rand_hole), .rand_ball(sm_rand_ball), .ball_moving(sm_ball_moving), .hole_moving(sm_hole_moving), .reset_ball(sm_reset_ball), .reset_hole(sm_reset_hole), .add_point(sm_add_point), .ball_flash(sm_ball_flash), .reset_timer(sm_reset_timer));

    //Jump
    wire btnJump;
    FDRE #(.INIT(1'b0)) btnUsync (.C(clk), .CE(digsel), .D(btnU), .Q(btnJump));
    StateMachineJump StateMachineJump (.clk(clk), .jump(btnJump), .onplat(SM_on_plat), .onborder(SM_on_border), .haspower(SM_power), .onhole(SM_inhole), .powerup(sm_charge_power_bar), .fall(sm_player_fall), .rise(sm_player_rise), .flash(sm_player_flash), .dead(sm_player_dead), .walkonwater(sm_walk_on_water));

    //flash timers
    wire player_off, ball_off;
    assign player_off = qsec & sm_player_flash; //on for a quarter second and off for a quarter second (as long as the frame counter doesn't get reset)
    assign ball_off   = qsec & sm_ball_flash;

    //score counter
    wire [15:0] disp_score;
    counter16 score_counter (.inc(sm_add_point), .clk(clk), .Q(disp_score));

    assign led = disp_score;

    //generate a random (for hole width and ball height)
    wire [7:0] random8;
    LFSR8 gen_random (.rnd(random8), .clk(clk));

    //define layers
    //wire [9:0] RGBt0, RGBt1, RGBt2, RGBt3, RGBt4, RGBt5, RGBt6, RGBt7, RGBt8, RGBt9, RGBt10, RGBt11, RGBt12, RGBt13, RGBt14, RGBt15; //16 possible layers
    wire [9:0] RGBt_red, RGBt_plat_below, RGBt_plat_above, RGBt_plat, RGBt_plat_with_hole, RGBt_ball, RGBt_bar, RGBt_player, RGBt_frame;

    //Draw border
    wire [9:0] left_border, right_border, top_border, bottom_border;
    assign left_border = 10'h008;   //8
    assign right_border = 10'h278;  //632
    assign top_border = 10'h008;    //8
    assign bottom_border = 10'h1D8; //472
    //layer0: color entire screen in red
    draw draw0_red_borders (.x1(10'h000), .x2(10'h280), .y1(10'h000), .y2(10'h1E0), .color(red), .RGBt(RGBt_red), .X(PixelX), .Y(PixelY));
    //layer1: black in the center except for the borders
    cut cut_background_from_red (.x1(left_border), .x2(right_border), .y1(top_border), .y2(bottom_border), .Layer(RGBt_red), .RGBt(RGBt_frame), .X(PixelX), .Y(PixelY));
    
    //Draw Platform
    //layer3: Platform is 20 pixels thick and top edge is in the 320-380 range. (10'h140 - 10'h127)
    wire [9:0] plat_top_edge, plat_bottom_edge;
    assign plat_top_edge = 10'h140; //320
    Add10 calc_plat_bottom_edge (.A(plat_top_edge), .B(10'h014), .S(plat_bottom_edge)); //plat_bottom_edge = plat_top_edge + 20
    //draw color below platfrom
    draw draw2_platform_below (.x1(left_border), .x2(right_border), .y1(plat_top_edge), .y2(bottom_border), .color(c_platform), .RGBt(RGBt_plat_below), .X(PixelX), .Y(PixelY));
    //draw actual platfrom
    draw draw3_platform (.x1(left_border), .x2(right_border), .y1(plat_top_edge), .y2(plat_bottom_edge), .color(c_platform_bot), .RGBt(RGBt_plat_above), .X(PixelX), .Y(PixelY));
    
    //Draw Player
    wire [9:0] player_top, player_bottom, player_left, player_right, jump_height, new_jump_height;
    //define constant xposition
    assign player_left = 10'hD0; //left side of player is at 208 (generally on left side of screen)
    Add10 calc_player_right (.A(player_left), .B(10'h010), .S(player_right)); //player_right = player_left + 16
    //calculate and store player yposition (jump_height)
    AddSub10 calc_player_bottom (.A(plat_top_edge), .sub(1'b1), .B(jump_height), .S(player_bottom)); //player_bottom = plat_top_edge - jump_height
    AddSub10 calc_new_jump_height (.A(jump_height), .sub(sm_player_fall), .B(10'h002), .S(new_jump_height)); //jump_height += 2*sm_player_rise
    Numbers10 store_jump_height (.D(new_jump_height), .CE(frame&(sm_player_rise ^ sm_player_fall)), .Q(jump_height), .clk(clk)); //will actually rise or lower the player depending on sm_player_rise/sm_player_fall
    //calculate player_top
    AddSub10 calc_player_top (.A(player_bottom), .sub(1'b1), .B(10'h010), .S(player_top)); //player_top = player_bottom - 16
    //draw actual player
    draw draw4_player (.x1(player_left), .x2(player_right), .y1(player_top), .y2(player_bottom), .off(player_off), .color(c_player), .RGBt(RGBt_player), .X(PixelX), .Y(PixelY));
    
    //Power Bar
    wire [6:0] power_bar_height;
    //calculate power_bar_height
    PowerBar power_bar_counter (.clk(clk), .charge(sm_charge_power_bar), .Q(power_bar_height), .CE(frame));
    wire [9:0] power_bar_left, power_bar_right, power_bar_top, power_bar_bottom;
    //define position
    assign power_bar_left = 10'h020;    //32
    assign power_bar_right = 10'h030;   //48 (32+16)
    assign power_bar_bottom = 10'h060;  //96
    //top depends on state machine
    AddSub10 calc_power_bar_top (.A(power_bar_bottom), .sub(1'b1), .B({3'h0,power_bar_height}), .S(power_bar_top)); //overflow shouldn't happen because maximum power_bar_height is 64
    //draw actual power bar
    draw draw5_power_bar (.x1(power_bar_left), .x2(power_bar_right), .y1(power_bar_top), .y2(power_bar_bottom), .color(c_power_bar), .RGBt(RGBt_bar), .X(PixelX), .Y(PixelY));

    //Hole
    wire [9:0] hole_left, hole_right, hole_width, rand_hole_width, new_hole_left; //hole width = 41-71
    //get a random 0 to 30
    wire rand_not_31;
    assign rand_not_31 = ~&random8[4:0];
    wire [4:0] random0_to_30;
    assign random0_to_30 = random8[4:0] & {5{rand_not_31}}; //take 5 bits and change 31 to 0 (0-30)
    //calculate and store hole with
    Add10 calc_hole_width (.A(10'h029), .B({5'h00, random0_to_30}), .S(rand_hole_width));
    Numbers10 store_hole_width (.D(rand_hole_width), .CE(sm_rand_hole), .Q(hole_width), .clk(clk), .init(10'h033));
    //calculate hole right
    Add10 calc_hole_right (.A(hole_left), .B(hole_width), .S(hole_right)); //hole_right = hole_left + hole_width
    //calculate and store hole_left
    AddSub10 calc_hole_left (.A(hole_left), .sub(1'b1), .B({10{sm_hole_moving}}&10'h001), .S(new_hole_left)); //hole_left- = 1
    Numbers10 store_hole_left (.D(new_hole_left), .CE(frame), .Q(hole_left), .clk(clk), .R(sm_reset_hole), .init(10'h278)); //init at right edge of the screen
    //account for negative hole_left
    wire clamp_hole;
    LessThan neg_left (.a(hole_right), .b(hole_left), .out(clamp_hole)); //clamp hole_left in drawing to 0 if hole_left is negative
    wire [9:0] clamped_hole_left;
    assign clamped_hole_left = hole_left & ~{10{clamp_hole}};
    //draw actual hole
    cut cut_hole_from_plat (.x1(clamped_hole_left), .x2(hole_right), .y1(plat_top_edge), .y2(plat_bottom_edge), .Layer(RGBt_plat), .RGBt(RGBt_plat_with_hole), .X(PixelX), .Y(PixelY));

    //balls
    //8x8 square
    wire [9:0] ball_left, ball_right, ball_bottom, ball_top, rand_ball_top, new_ball_left; // ball top = 192 to 252
    //get a random 0 to 60
    wire rand_not_61_to_63;
    assign rand_not_61_to_63 = ~&random8[5:2];
    wire [5:0] random_0_to_60;
    assign random_0_to_60 = (random8[5:0]&{6{rand_not_61_to_63}}) | {1'b0, random8[4:0]&{5{~rand_not_61_to_63}}}; //if above 60, take off first bit
    //calculate and store ball height
    Add10 calc_ball_top   (.A(10'h0C0), .B(random_0_to_60), .S(rand_ball_top));
    Numbers10 store_ball_top (.D(rand_ball_top), .CE(sm_rand_ball), .Q(ball_top), .clk(clk), .init(10'h0C0)); //init at height 192
    //calculate ball bottom
    Add10 cal_ball_bottom (.A(ball_top ), .B(10'h008), .S(ball_bottom));
    //calculate and store ball left
    AddSub10 calc_ball_left (.A(ball_left), .sub(1'b1), .B(({10{sm_ball_moving}}&10'h004)), .S(new_ball_left)); //4 pixels at a time
    Numbers10 store_ball_xpos (.D(new_ball_left), .CE(frame), .Q(ball_left), .clk(clk), .R(sm_reset_ball), .init(10'h278)); //init at right edge of the screen
    //calculate ball right
    Add10 cal_ball_right (.A(ball_left), .B(10'h008), .S(ball_right)); //ball_right = ball_left + 8
    //draw actual ball
    draw draw7_ball (.x1(ball_left), .x2(ball_right), .y1(ball_top), .y2(ball_bottom), .off(ball_off), .color(c_ball), .RGBt(RGBt_ball), .X(PixelX), .Y(PixelY));

    //Get state_machine conditions
    //is the player horizontally within the hole?
    wire [7:0] c;
    LessThan condition0 (.a(hole_left   ), .b(player_left), .out(c[0]));    //player_left is to the right of hole_left
    LessThan condition1 (.a(player_right), .b(hole_right ), .out(c[2]));    //player_right is to the left of hole_right
    assign c[1] = ~|(player_left ^hole_left );                              //player left lines up with hole_left
    assign c[3] = ~|(player_right^hole_right);                              //player right lines up with hole_right
    assign SM_inhole = |c[1:0] & |c[3:2];                                   //pl >= hl & pr <= hr
    //is the player resting on the platform?
    assign SM_on_plat = ~|(player_bottom^plat_top_edge);                    //player_bottom == plat_top_edge
    //is the player resting on the bottom border?
    assign SM_on_border = ~|(player_bottom^bottom_border);                  //player_bottom == bottom_border
    //is the ball colliding with the player?
    collision collision_player_ball (.Layer1(RGBt_player), .Layer2(RGBt_ball), .out(SM_hit_ball)); //player and ball are overlapping
    //does the power bar have power?
    LessThan condition2 (.a(10'h000), .b(power_bar_height), .out(SM_power)); //power_bar_height > 0
    //is the ball off the screen?
    LessThan condition3 (.a(ball_right), .b(left_border), .out(c[4]));      //ball_right < left_border
    assign c[5] = ~|(ball_right^left_border);                               //ball_right == left_border
    assign SM_ball_off = |c[5:4];                                           //ball <= left_border
    //is the hole off the screen?
    LessThan condition4 (.a(hole_right), .b(left_border), .out(c[6]));      //hole_right < left_border
    assign c[7] = ~|(hole_right^left_border);                               //hole_right == left_border
    assign SM_hole_off = |c[7:6];                                           //hole_right <= left_border



    //combine layers
    wire [9:0] RGBt_total_0, RGBt_total_1, RGBt_total_2, RGBt_final;
    MergeLayers merge_plat  (.LayerAbove(RGBt_plat_above), .LayerBelow(RGBt_plat_below    ), .RGBt(RGBt_plat)); //merge platform layers
    //RGBt_plat gets hole cut out of it. Becomes RGBt_plat_with_hole
    MergeLayers merge_ball  (.LayerAbove(RGBt_ball      ), .LayerBelow(RGBt_plat_with_hole), .RGBt(RGBt_total_0)); //merge platform with ball
    MergeLayers merge_bar   (.LayerAbove(RGBt_bar       ), .LayerBelow(RGBt_total_0       ), .RGBt(RGBt_total_1)); //merge bar on top
    MergeLayers merge_plyr  (.LayerAbove(RGBt_player    ), .LayerBelow(RGBt_total_1       ), .RGBt(RGBt_total_2)); //merge player on top
    //RGBt_red gets background cut out of it. Becomes RGBt_frame
    MergeLayers merge_frme  (.LayerAbove(RGBt_frame     ), .LayerBelow(RGBt_total_2       ), .RGBt(RGBt_final  )); //frame goes on top
    wire [8:0] RGB;
    assign RGB[8:0] = RGBt_final[9:1];

    //load colors
    assign vgaRed = RGB[8:6];
    assign vgaGreen = RGB[5:3];
    assign vgaBlue = RGB[2:0];

    //score count
    //output 16 bit bus into hex on display
    wire [3:0] ring, n;
    ring_counter4 ring_counter (.advance(digsel), .clk(clk), .ring(ring));
    assign dp = 1'b1; //decimal point is always off
    assign an[3:0] = ~ring[3:0];
  
    //select digit and output 7seg
    selector sel (.sel(ring), .N(disp_score), .H(n));
    hex7seg h7s (.n(n), .seg(seg));
endmodule
