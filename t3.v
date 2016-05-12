module sign(
	input [10:0]p1x,
	input [10:0]p1y,
	input [10:0]p2x,
	input [10:0]p2y,
	input [10:0]p3x,
	input [10:0]p3y,
	output ver
	);
	
	wire signed [11:0]c1,
	wire signed [11:0]c2,
	wire signed [11:0]c3,
	wire signed [11:0]c4,
	wire signed [23:0]m1,
	wire signed [23:0]m2;

	assign c1 = p1x - p3x;
	assign c2 = p2x - p3x;
	assign c3 = p2y - p3y;
	assign c4 = p1y - p3y;

	assign m1 = c1 * c2;
	assign m2 = c3 * c4;

	assign ver = m1 - m2;

endmodule

module triangle(
	input [10:0]px,
	input [10:0]py,
	input [10:0]p1x,
	input [10:0]p1y,
	input [10:0]p2x,
	input [10:0]p2y,
	input [10:0]p3x,
	input [10:0]p3y,
	output saida
	);

	reg [23:0]det;
	reg [23:0]detA;
	reg [23:0]detB;
	reg [23:0]detC;
	
	sign D(p1x, p1y, p2x, p2y, p3x, p3y, det);
	sign DA(px, py, p1x, p1y, p2x, p2y, detA);
	sign DB(px, py, p2x, p2y, p3x, p3y, detB);
	sign DC(px, py, p3x, p3y, p1x, p1y, detC);

	saida = (det == (detA+detB+detC));

endmodule

module execucao
	
	integer pontos;
	integer results;
	integer valor;
	
	reg [10:0]px;
	reg [10:0]py;
	reg [10:0]p1x;
	reg [10:0]p1y;
	reg [10:0]p2x;
	reg [10:0]p2y;
	reg [10:0]p3x;
	reg [10:0]p3y;
	wire saida;
	reg state=0;

	triangle T(px, py, p1x, p1y, p2x, p2y, p3x, p3y, saida);

	initial begin
		pontos = $fopen("entradas.txt","r");
		result = $fopen("saida_V.txt", "w");
		if (pontos == 0) begin
			$display("Erro na leitura do arquivo!");
      			$finish;
   		end
    		if (result == 0) begin
        		$display("Erro na escrita do arquivo!");
        		$finish;
    		end
	end

	always #2 begin
		if (!$feof(pontos)) begin
	  		if (state != 0)begin
	    			$fdisplay(result, "%d %d %d %d %d %d %d %d = %d", px, py, p1x, p1y, p2x, p2y, p3x, p3y, saida);
				valor = $fscanf(pontos, "%d %d %d %d %d %d %d %d\n", px, py, p1x, p1y, p2x, p2y, p3x, p3y);
	  		end else begin
				valor = $fscanf(pontos, "%d %d %d %d %d %d %d %d\n", px, py, p1x, p1y, p2x, p2y, p3x, p3y);
				state = 1;
  			end
 		end else begin
    			$finish;
  		end
	end
	
endmodule
