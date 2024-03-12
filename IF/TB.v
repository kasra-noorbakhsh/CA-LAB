`timescale 1ns/1ns

module TB ();
    
    reg clk = 1'b0;
    reg[17:0] rst;

    ARM arm1(.CLOCK_50(clk), .SW(rst));

    always #5 clk = ~clk;

    initial begin
        #17 rst = 18'b000000000000000001;
        #23 rst = 18'b0;
        #150 $stop;
    end

endmodule