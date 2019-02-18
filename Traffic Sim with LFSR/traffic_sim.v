module LFSR(
    input clock,
    input reset,
    output reg outputA,
    output reg outputB
    );
    reg [4:0] op1,op2;
    wire feedback1,feedback2;
    assign feedback1 = ~(op1[3] ^ op2[1]);
    assign feedback2 = ~(op2[2] | op1[0]);

    always @(posedge clock, posedge reset)
        begin
            if (reset)
                begin
                    op1 = 5'b01010;
                    op2 = 5'b10101;
                    outputA = op1[2];
                    outputB = op2[3];
                end
            else
                begin
                    op1 = {op1[3:0],feedback1};
                    op2 = {op2[3:0],feedback2};
                    outputA = op1[2];
                    outputB = op2[3];
                end
        end
endmodule

module traffic_sim(
    input clk,
    input rst,
    output reg RA,
    output reg RB,
    output reg YA,
    output reg YB,
    output reg GA,
    output reg GB
    );

wire TA,TB;
LFSR lfsr(
    .reset(rst),
    .clock(clk),
    .outputA(TA),
    .outputB(TB)
    );

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;
parameter S3 = 2'b11;

reg [1:0] curr_state;
reg [1:0] nxt_state;

always@(posedge rst,posedge clk)
begin
    begin
    if(rst)
        begin
        curr_state <= S0;
        RA <= 1'b0;
        RB <= 1'b1;
        YA <= 1'b0;
        YB <= 1'b0;
        GA <= 1'b1;
        GB <= 1'b0;
        end
    else
        curr_state <= nxt_state;
    end
end
always@(*)
    case(curr_state)
        S0:
            if(TA == 1'b1)
                nxt_state <= S0;
            else
                nxt_state <= S1;
        S1:
            nxt_state <= S2;
        S2:
            if(TB == 1'b1)
                nxt_state <= S2;
            else
                nxt_state <= S3;
        S3:
            nxt_state <= S0;
        default nxt_state <= S0;
    endcase

always@(*)
    case(curr_state)
        S0:
        begin
            RA = 1'b0;
            RB = 1'b1;
            YA = 1'b0;
            YB = 1'b0;
            GA = 1'b1;
            GB = 1'b0;
        end
        S1:
        begin
            RA = 1'b0;
            RB = 1'b1;
            YA = 1'b1;
            YB = 1'b0;
            GA = 1'b0;
            GB = 1'b0;
        end
        S2:
        begin
            RA = 1'b1;
            RB = 1'b0;
            YA = 1'b0;
            YB = 1'b0;
            GA = 1'b0;
            GB = 1'b1;
        end
        S3:
        begin
            RA = 1'b1;
            RB = 1'b0;
            YA = 1'b0;
            YB = 1'b1;
            GA = 1'b0;
            GB = 1'b0;
        end
    endcase
endmodule
