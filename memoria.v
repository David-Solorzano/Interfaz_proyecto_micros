`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:06 06/19/2020 
// Design Name: 
// Module Name:    memoria 
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


module memoria #( parameter AL = 8, parameter MEM_TOT = 64) 
    (input [31:0] A,
    input L,
    input WE,
    output reg [31:0] RD,
    input [31:0] WD,
    input CLK
    );
	 
	
	
	wire [AL - 1: 0] Adress;
	assign Adress = A[AL-1:2];	
	
	// Declaración de Memoria
	reg [31:0] ram [MEM_TOT-1:0];					   	// -3 ya que hace falta quitar los de acceso de 8 bits 
	 
	wire [4:0] AdressLow, AdressLow_Compl;								// Dirección para acceso de 1 byte							
	wire [7:0] LB;										// Byte extraido
	wire [31:0] Val_Memoria, Mask;						// Valor de memoria, mascara
	wire [31:0] Val_Memoria_Mask, Val_Memoria_Rot;
	wire [31:0] WD_Rot,	WD_Mask;								// WD_Rot
	
	assign AdressLow = A[1:0]<<3'd3;				    // Calculo de rotacion
	assign AdressLow_Compl = 5'd24 - AdressLow;
	assign Val_Memoria = ram[Adress];					// Valor leido
	assign Mask = 32'hFF000000 >>  AdressLow;	    // Mascara
	assign Val_Memoria_Mask = Val_Memoria & ~Mask; 	    // Valor de memoria con ceros donde se quiere hacer escritura
	assign Val_Memoria_Rot = Val_Memoria >> AdressLow_Compl;  // Valor de memoria rotado para lectura
	assign WD_Mask = WD & 8'hff;
	assign WD_Rot = WD_Mask << AdressLow_Compl;
	
	always @(*)begin
		if(~L)
			RD <= Val_Memoria;
		else
			RD <= Val_Memoria_Rot & 32'hFF;
	end
	
		
	always @(posedge(CLK)) begin
		if(WE)begin
			if(L)
				ram[Adress] <= Val_Memoria_Mask | WD_Rot ;
			else
				ram[Adress] <= WD;
		end
	end
	
	initial begin
	   $readmemh("Contenido.mem.txt", ram);
	end
	

endmodule
