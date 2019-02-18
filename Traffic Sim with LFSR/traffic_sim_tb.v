module traffic_tb;
    reg rst;
    reg clk;
    wire  RA;
    wire  RB;
    wire  YA;
    wire  YB;
    wire  GA;
    wire  GB;
    wire TA;
    wire TB;

LFSR utu(
        .clock(clk),
        .reset(rst),
        .outputA(TA),
        .outputB(TB)
        );
traffic_sim uut(
        .clk(clk),
        .rst(rst),
        .RA(RA),
        .RB(RB),
        .YA(YA),
        .YB(YB),
        .GA(GA),
        .GB(GB)
        );
    initial begin
        $dumpfile("traffic_sim.vcd");
        $dumpvars(0,traffic_tb);
        clk = 0;
        rst = 1;
        #50
        rst = 0;
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
        #50
        clk = 1;
        #50
        clk = 0;
    end
always@(clk == 1)
    if($time > 100) // First two clocks for resetting the module
        if($time%100 != 0 && $time%50 == 0)
            $display("time=%d:TA = %b,TB = %b,clk = %b,rst = %b, A: (%b,%b,%b), B: (%b,%b,%b)\n",$time-100,TA,TB,clk,rst,RA,YA,GA,RB,YB,GB);
endmodule
