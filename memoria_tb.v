`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:02:59 06/20/2020
// Design Name:   memoria
// Module Name:   D:/Instituto Tecnologico de Costa Rica/2020 1 semestre/Microsprocesadores y microcontroladores/Proyecto/RiscV_Proyecto/memoria_tb.v
// Project Name:  RiscV_Proyecto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: memoria
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module memoria_tb;

	// Inputs
	reg [31:0] A;
	reg L;
	reg WE;
	reg [31:0] WD;
	reg CLK = 0;

	// Outputs
	wire [31:0] RD;

	// Instantiate the Unit Under Test (UUT)
	memoria uut (
		.A(A), 
		.L(L), 
		.WE(WE), 
		.RD(RD), 
		.WD(WD), 
		.CLK(CLK)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		L = 0;
		WE = 0;
		WD = 0;

		// Wait 100 ns for global reset to finish
		#10;
        
        A = 8'd0;
        WD = 32'hFF11931F;
        WE = 1'b1;
        
        #10;
        WE = 1'b0;
        
        #10;
        L = 1'b1;
        
        #10;
        A = 32'd2;
        
        #10;
        WD = 32'h13;
        WE = 1'b1;
       
        
        #10;
        WE = 0'b0;
        L = 1'b0;
        A = 32'b0;
        
        #10
        A = 32'd8;
        
        #10;
        $finish;
        
		// Add stimulus here

	end
      
    always begin
    #5 CLK = ~CLK;
    end
endmodule

