# FPGA Hardware Synthesizer & Visual Controller


## Overview
This project is a custom digital hardware system implemented on an FPGA. It functions as a zero-latency interactive synthesizer that generates specific musical notes and color outputs on an SPI display based on button presses. 


## System Architecture
![Block Diagram](https://github.com/koliazak/VerilogVideoAudioExample/blob/master/Block-Diagram.png?raw=true)


The system is built using a top-down modular approach:
1.  **Input Logic:** Inverts active-low button signals and passes them through a debounce module.
2.  **Audio Core:** Instantiates multiple PWM generators for different frequencies, multiplexed directly to the speaker output.
3.  **Video Core:** Controller writes color data to the Dual-Port BRAM. Concurrently, the LCD Driver reads from the BRAM and send pixels over the SPI bus.

## File Structure
* `top.v` - Top-level module
* `debounce.v` - Filter for physical buttons.
* `pwm.v` - Clock divider and PWM generator for audio output.
* `lcd_driver.v` - SPI protocol implementation and initialization sequence for the LCD.
* `fb_bram.v` - Simple Dual-Port Block RAM using synthesis attributes.
* `notes.vh` - Header file containing frequency definitions for musical notes.



## How to Run
1. Clone this repository.
2. Open the project in your FPGA design suite (e.g., Vivado, Quartus, or Yosys/NextPNR).
3. Assign the physical pins in your constraints file.
4. Synthesize, implement, and generate the bitstream.
5. Program the FPGA.

## [Video Demonstration](https://youtu.be/-vT_gBIwjEA?si=BuH9CcO8Iwv7MgyM)  
