`timescale 1ns/1ps

module traffic_light_tb;

    reg clk = 1'b0;
    reg reset = 1'b1;
    reg emergency = 1'b0;
    wire red, yellow, green;

    // Small timer values make the simulation finish quickly.
    traffic_light_controller #(
        .RED_CYCLES(4),
        .GREEN_CYCLES(4),
        .YELLOW_CYCLES(2)
    ) dut (
        .clk(clk),
        .reset(reset),
        .emergency(emergency),
        .red(red),
        .yellow(yellow),
        .green(green)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_tb);
        $display("time reset emergency | red yellow green");
        $monitor("%4t   %b      %b      |  %b    %b     %b",
                 $time, reset, emergency, red, yellow, green);

        #12 reset = 1'b0;
        #100 emergency = 1'b1;
        #20 emergency = 1'b0;
        #100;
        $finish;
    end

endmodule
