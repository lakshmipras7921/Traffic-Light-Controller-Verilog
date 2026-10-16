// FPGA-Based Traffic Light Controller with Emergency Priority
// Educational RTL design. Emergency input forces RED while asserted.
// Normal sequence: RED -> GREEN -> YELLOW -> RED.

module traffic_light_controller #(
    parameter integer RED_CYCLES    = 10,
    parameter integer GREEN_CYCLES  = 10,
    parameter integer YELLOW_CYCLES = 3
) (
    input  wire clk,
    input  wire reset,       // active-high synchronous reset
    input  wire emergency,   // active-high emergency priority request
    output reg  red,
    output reg  yellow,
    output reg  green
);

    localparam [1:0] ST_RED    = 2'b00;
    localparam [1:0] ST_GREEN  = 2'b01;
    localparam [1:0] ST_YELLOW = 2'b10;

    reg [1:0] state;
    integer count;

    // State and timer control
    always @(posedge clk) begin
        if (reset) begin
            state <= ST_RED;
            count <= 0;
        end else if (emergency) begin
            state <= ST_RED;
            count <= 0;
        end else begin
            case (state)
                ST_RED: begin
                    if (count >= RED_CYCLES - 1) begin
                        state <= ST_GREEN;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end

                ST_GREEN: begin
                    if (count >= GREEN_CYCLES - 1) begin
                        state <= ST_YELLOW;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end

                ST_YELLOW: begin
                    if (count >= YELLOW_CYCLES - 1) begin
                        state <= ST_RED;
                        count <= 0;
                    end else begin
                        count <= count + 1;
                    end
                end

                default: begin
                    state <= ST_RED;
                    count <= 0;
                end
            endcase
        end
    end

    // Output decode. Emergency immediately requests RED at the next clock edge.
    always @(*) begin
        red    = 1'b0;
        yellow = 1'b0;
        green  = 1'b0;

        if (emergency) begin
            red = 1'b1;
        end else begin
            case (state)
                ST_RED:    red    = 1'b1;
                ST_GREEN:  green  = 1'b1;
                ST_YELLOW: yellow = 1'b1;
                default:   red    = 1'b1;
            endcase
        end
    end

endmodule
