`timescale 1ns/1ps

module Functional_Unit(instruction, A, B, F);
    input wire [2:0] instruction;
    input wire [7:0] A;
    input wire [7:0] B;
    output [7:0] F;
    reg [7:0] F;

    always@(A or B or instruction)
        begin 
            case(instruction)
            3'b000: F=A+B;
            3'b001: F=A+~B;
            3'b010: F=A&B;
            3'b011: F=A|B;
            3'b100: F=A^B;
            3'b101: F=(A>>1)+B;
            3'b110: F= ((A>>1)|(A<<7))+B;
            3'b111: F = ((A<<1)|(A>>7))+B;
            endcase
        end

    //TODO: write your design below
    //You can define F as 'reg' or 'wire'

endmodule