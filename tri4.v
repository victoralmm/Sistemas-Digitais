include "trianguloarea.v"

module trianguleMain  (output reg clk,
		       input [10:0] p1x, p1y, p2x, p2y, p3x, p3y, ptx, pty, 
		       output reg active, s);
   
   	reg  signed [10:0] a1x, a1y, a2x, a2y, a3x, a3y;
   	reg  signed  [4:0] state = 0, stage = 0;
   	reg  signed [23:0] A1, A2, A3, A4;
   	wire signed [23:0] area;
   	reg  signed [24:0] a, b, c;
   	wire signed [24:0] soma1;
   	wire write;

   	trianguleArea ta(clk,a1x, a1y, a2x, a2y, a3x, a3y, area, write);
   
   	assign soma1 = a + b;
   
   	always @(clk) begin
      		if(stage == 0 && write) begin
		 	case (state) 
			   	0: begin
				      	active <= 0;
				      	state = 1;
				      	a1x <= p1x;
				      	a1y <= p1y; 	 
				      	a2x <= p2x;
				      	a2y <= p2y;
				      	a3x <= p3x;
				      	a3y <= p3y;
			   	end
			   	1: begin
				      	state = 2;
				      	A1 <= area;
				      	a1x <= p1x;
				      	a1y <= p1y;
				      	a2x <= p2x;
				      	a2y <= p2y;
				      	a3x <= ptx;
				      	a3y <= pty;
			   	end
			   	2:begin
				      	state = 3;
				      	A2 <= area;
				      	a1x <= p2x;
				      	a1y <= p2y;
				      	a2x <= p3x;
				      	a2y <= p3y;
				      	a3x <= ptx;
				      	a3y <= pty;
			   	end
			   	3:begin
				      	A3 <= area;
				      	a1x <= p3x;
				      	a1y <= p3y;
				      	a2x <= p1x;
				      	a2y <= p1y;
				      	a3x <= ptx;
				      	a3y <= pty;
				      	state = 4;
			   	end 
			   	4:begin
				      	stage = 1;
				      	state = 0;
			  	end
		 	endcase
    		end 
    		else if(stage == 1) begin 
	 		case(state)
	   			0: begin
	 	      			state <= 1;
		      			A4 <= area;
	   			end
			   	1: begin
				      	state <= 2;
				     	a <= A2;
				      	b <= A3;
		 	   	end
		 	   	2: begin
			 	      	state <= 3;
			 	      	a <= soma1;
			 	      	b <= A4;
		 	   	end
		 	   	3: begin
			 	      	s = (soma1 == A1)? 1: 0;
				      	state <= 0;
				      	stage <= 0;
				      	active <= 1; 
			   	end
			endcase 
	    	end
   	end 
endmodule