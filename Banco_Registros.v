`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/21/2020 12:54:30 AM
// Design Name: 
// Module Name: Banco_Registros
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


module Banco_Registros(
    input [4:0] A1, A2, A3, 
    input [31:0] WD3,
    input WE3, CLK, reset,
    output [31:0] RD1, RD2
    );
    
    
    reg [31:0] registros [31:0];
    
    //Lectura
    assign RD1 = registros[A1];
    assign RD2 = registros[A2];
    
    // Escritura y reset
    integer i;
    
    always @(posedge(CLK))begin
        if(reset)begin
            for(i = 0; i < 32; i = i + 1)begin
            if(i==5)
                registros[i] = 32'hfffaf;
            else
                registros[i]= 32'b0;
            end
        end
        else begin
            if(WE3)
                registros[A3] <= WD3;
        end
    end

endmodule
