module trianguloarea(input clk,
	             input signed [10:0] p1x, p1y, p2x, p2y, p3x, p3y,
		     output reg signed [23:0] s,
		     output reg valid);

   	reg [2:0]state = 1;
   	reg signed [10:0]a, b, c;
   	reg signed [20:0] t1, t2, t3;
   	wire signed [20:0] ts;
   	wire signed [21:0] t4;
   
   	assign ts = (a - b) * c;
   	assign t4 = t1 + t2;
 
   	always @(negedge clk) begin
      		case (state)
			0: begin
		 	   	state <= 1;
			  	valid = 0;
			   	a <= p2y;
			   	b <= p3y;
			   	c <= p1x; 
			end
			1: begin
		 	    state <= 2;
			    t1 <= ts;
			    a <= p3y;
			    b <= p1y;
			    c <= p2x;
			end
			2: begin
		 	   	state <= 3;
			   	t2 <= ts;
			   	a <= p1y;
			   	b <= p2y;
			   	c <= p3x;
			end
			3:begin
			   	t3 <= ts;
			   	state <= 4;
			end
			4:begin
			   	s <= t4 + t3;
			   	state <= 5;
			end
			5:begin
			   	s = (s < 0) ? ~s + 1 : s;
			   	state <= 0;
			   	valid <= 1;
			end
      		endcase
   	end
endmodule