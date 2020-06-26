`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:07:28 06/20/2020 
// Design Name: 
// Module Name:    ALU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ALU(
           input signed [31:0] A,B,                   
           input [2:0] ALU_Sel,
           output [31:0] ALU_Out, 
			  output zero,
			  output negative,
			  output overflow,
           output CarryOut 
    );
	 wire notzero; 
    reg [31:0]ALU_Result;
    wire [32:0] tmp;
    assign ALU_Out = ALU_Result;
    assign tmp = {1'b0,A} + {1'b0,B};
    assign CarryOut = tmp[32]; 
	 
	 
	 //flags*************************************
	 assign zero = ~(A && B) ;//Zero flag    
	 assign overflow = tmp[32];//overflow flag
	 assign negative = ALU_Result[31];//negative flag
	 //******************************************
    always @(*)
    begin
        case(ALU_Sel)
        4'b000: // Suma
           ALU_Result = A + B ; 
        4'b001: // Resta
           ALU_Result = A - B ;
        /*4'b0010: // Multiplicación
           ALU_Result = A * B;
        4'b0011: // Division
           ALU_Result = A/B;*/
        4'b011: // Logical shift left
           ALU_Result = A<<1;
         4'b010: // Logical shift right
           ALU_Result = A>>1;
         /*'b0110: // Rotate left
           ALU_Result = {A[6:0],A[7]};
         4'b0111: // Rotate right
           ALU_Result = {A[0],A[7:1]};*/
          4'b101://  Logical and 
           ALU_Result = A & B;
          4'b110: //  Logical or
           ALU_Result = A | B;
          4'b111: //  Logical xor 
           ALU_Result = A ^ B;
			 4'b100: //  Arithmetic shift 
           ALU_Result = A >>> B;

          default: ALU_Result = A + B ; 
        endcase
		  
		  
		  
    end

endmodule
    



