`timescale 1ns / 1ps


module pwm
    #(
    parameter integer CLK_FREQ = 50_000_000,
    parameter integer PWM_FREQ = 1_000
    )
    (
    input wire                clk,
    input wire                rst_n,
    input wire signed[9:0]    duty, // 0-1023
    
    output reg pwm_out
    );
    
    
    localparam integer PERIOD = CLK_FREQ / PWM_FREQ;
    
    reg[$clog2(PERIOD)-1:0] counter = 0;
    reg[$clog2(PERIOD)-1:0] duty_counter = 0;
    
    
    
    always @(*) begin
        duty_counter = PERIOD * duty / 10'h3FF; // PERIOD * duty/max_duty
    end 
    
    
    always @(posedge clk) begin
        if (!rst_n) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter == PERIOD - 1) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;     
            end
            pwm_out <= (counter < duty_counter) ? 1'b1 : 1'b0;
        end
    end
    

endmodule
