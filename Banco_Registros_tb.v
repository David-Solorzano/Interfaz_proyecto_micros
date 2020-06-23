`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/21/2020 01:10:08 AM
// Design Name: 
// Module Name: Banco_Registros_tb
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


module Banco_Registros_tb(
    );
    
    reg [4:0] A1 = 0;
    reg [4:0] A2 = 0;
    reg [4:0] A3 = 0;
    reg [31:0] WD3 = 0;
    reg WE3 = 0;
    reg CLK = 0;
    reg reset = 0;
    
    wire [31:0] RD1;
    wire [31:0] RD2;
    
    Banco_Registros uut (
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .CLK(CLK),
        .WE3(WE3),
        .reset(reset),
        .RD1(RD1),
        .RD2(RD2)
    );
     
    initial begin
        A3 = 4'd10;
        WD3 = 32'hFF;
        WE3 = 1'b1;
        
        #10;
        A3 = 4'd5;
        WD3 = 32'h12F;
        
        #10;
        A1 = 4'd10;
        A2 = 4'd5;
        
        #10;
        reset = 1'b1;
        
        #10 $finish;
    end
    
    always begin
        #5 CLK = ~CLK;
    end
    
endmodule
