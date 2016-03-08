module pisca(input clock, output led);
	assign clock = led;
endmodule

module teste;
	reg clock; //clock como registrador
	wire led; //led como saida

	valor TESTE(clock, led);
	always #1 clock = ~clock;

	initial begin 
		$dumpvars(0,TESTE);
		#10;
		clock <= 0;
		#150;
		$finish;
	end;
endmodule;


