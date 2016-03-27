module luz(input Clk_50, output [1:0]LEDR);

    reg [32:0] counter;
    reg state = 0;
    
    assign LEDR[0] = on;
    assign LEDR[1] = ~on;
    
    always @(posedge Clk_50) begin
        if (counter == 50000000) begin
            on = ~on;
            counter = 0;
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
