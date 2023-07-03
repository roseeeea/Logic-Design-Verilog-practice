`timescale 1ns/1ps
module find_MAX(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire valid,
    input wire [7:0] Data_A,
    input wire [7:0] Data_B,
    input wire one_left,
    input wire [2:0] instruction,
    output reg [7:0] maximum,
    output reg finish
);
    wire [7:0] result;

    // Functional_Unit instantiation
    Functional_Unit fu(
        .instruction(instruction), 
        .A(Data_A),
        .B(Data_B),
        .F(result)
    );

    //TODO: write your design below
    //You cannot modify anything above
    
    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    

    reg [1:0] state, next_state;

     
    always @(valid or state or result )begin
        if(state==S0) maximum<=0;
        else if(valid==1) 
        begin
            if(maximum<result) maximum<=result;
        end
    end

    always @(posedge clk) begin
        if(~rst_n)
            state <= S0;
        else 
            state <=next_state;
    end

    always @(*) begin
        case(state)
            S0: begin
                finish=0;
                if(start==1)begin
                     next_state=S1;
                end
                else begin
                    next_state=S0;
                end
            end
            S1: begin
                finish=0;
                if(one_left) begin
                    next_state=S2;
                end
                else 
                begin
                    next_state=S1; 
                end
            end
            S2: begin
                finish=0;
                if(valid==1) begin
                    next_state=S3; 
                end
                else begin
                    next_state=S2;
                end
            end
            S3: begin
                finish=1;
                if(valid==1) begin
                    next_state=S3; 
                end
                else begin
                    next_state=S0;
                end
            end
            default: next_state=S0;
        endcase
    end

    

endmodule