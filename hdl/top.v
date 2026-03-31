`timescale 1ns / 1ps
`include "notes.vh"

module top
(
    input clk,
    input rst_n,
    

    input btn1,
    input btn2,
    input btn3,
    

    output speaker_out,
    

    output DC,        
    output SCL,       
    output SDA,       
    output wire nRES  
);

// RGB565
localparam COLOR_BLACK = 16'h0000;
localparam COLOR_BLUE  = 16'h001F;
localparam COLOR_GREEN = 16'h07E0;
localparam COLOR_RED   = 16'hF800;


wire d_btn1, d_btn2, d_btn3;

debounce db1 (.clk(clk), .btn_in(~btn1), .btn_out(d_btn1));
debounce db2 (.clk(clk), .btn_in(~btn2), .btn_out(d_btn2));
debounce db3 (.clk(clk), .btn_in(~btn3), .btn_out(d_btn3));


wire pwm_note1, pwm_note2, pwm_note3;

pwm #(50000000, `NOTE_C1*10) note1 (.clk(clk), .rst_n(rst_n), .duty(512), .pwm_out(pwm_note1));
pwm #(50000000, `NOTE_E1*10) note2 (.clk(clk), .rst_n(rst_n), .duty(512), .pwm_out(pwm_note2));
pwm #(50000000, `NOTE_G1*10) note3 (.clk(clk), .rst_n(rst_n), .duty(512), .pwm_out(pwm_note3));

assign speaker_out = d_btn1 ? pwm_note1 :
                     d_btn2 ? pwm_note2 :
                     d_btn3 ? pwm_note3 : 1'b0;

reg we = 0;
reg [15:0] din;
reg [$clog2(240*240)-1:0] waddr;
wire [15:0] dout;
wire [$clog2(240*240)-1:0] raddr;

fb_bram fb (
    .clkw(clk),
    .clkr(clk),
    .we(we),
    .din(din),
    .waddr(waddr),
    .raddr(raddr),
    .dout(dout)
);

reg lcd_valid = 0;
wire lcd_ready;

lcd_driver lcd (
    .clk(clk),
    .rst(rst_n),
    .valid(lcd_valid),
    .ready(lcd_ready),
    .DC(DC),
    .SCL(SCL),
    .SDA(SDA),
    .nRES(nRES),
    .fb_dout(dout),
    .fb_raddr(raddr)
);


reg [15:0] target_color;
always @(*) begin
    if (d_btn1)      target_color = COLOR_BLUE;
    else if (d_btn2) target_color = COLOR_GREEN;
    else if (d_btn3) target_color = COLOR_RED;
    else             target_color = COLOR_BLACK;
end

localparam IDLE = 0;
localparam DRAW = 1;

reg state = IDLE;
reg [17:0] pixel_idx = 0; 

always @(posedge clk) begin
    if (!rst_n) begin
        state <= IDLE;
        pixel_idx <= 0;
        we <= 0;
        lcd_valid <= 0;
    end else begin
        case (state)
            IDLE: begin
                lcd_valid <= 0;
                if (lcd_ready) begin
                    state <= DRAW;
                    pixel_idx <= 0;
                end
            end
            DRAW: begin
                we <= 1'b1;
                waddr <= pixel_idx;
                din <= target_color;
                
                if (pixel_idx == (240*240 - 1)) begin
                    state <= IDLE;
                    we <= 1'b0;
                    lcd_valid <= 1'b1;
                end else begin
                    pixel_idx <= pixel_idx + 1;
                end
            end
        endcase
    end
end

endmodule
