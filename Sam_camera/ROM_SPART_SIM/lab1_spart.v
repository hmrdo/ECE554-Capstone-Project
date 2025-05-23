
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module lab1_spart(

 //////////// CLOCK //////////
    input               CLOCK_50,
    input               CLOCK2_50,
    input               CLOCK3_50,
    input               CLOCK4_50,

 //////////// SEG7 //////////
    output reg   [6:0]  HEX0,
    output reg   [6:0]  HEX1,
    output reg   [6:0]  HEX2,
    output reg   [6:0]  HEX3,
    output reg   [6:0]  HEX4,
    output reg   [6:0]  HEX5,

//////////// KEY //////////
    input        [3:0]  KEY,

 //////////// LED //////////
    output		   [9:0]		LEDR,

 //////////// SW //////////
    input        [9:0]  SW,

 //////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
    inout       [35:0]  GPIO
);

wire txd;
wire rxd;
wire iocs;
wire iorw;
wire rda;
wire tbr;
wire [1:0] ioaddr;
wire [7:0] databus;
wire [1:0] br_cfg;

// press button[0] to generate a low active reset signal
wire rst = KEY[0];

// LED[9] : indicator for RX signal
// LED[8] : indicator for TX signal
// LED[0] : indicator for rst signal 
assign LEDR = {~rxd,~txd,7'b0,~rst};

// GPIO[3] as TX output, GPIO[5] as RX input
assign GPIO[3] = txd;
assign rxd = GPIO[5];

// slide switch [9:8] as baudrate config
assign br_cfg = SW[9:8];

// Instantiate your spart here
spart spart0(   .clk(CLOCK_50),
                .rst(rst),
                .iocs(iocs),
                .iorw(iorw),
                .rda(rda),
                .tbr(tbr),
                .ioaddr(ioaddr),
                .databus(databus),
                .txd(txd),
                .rxd(rxd)
            );

// Instantiate your driver here
driver driver0( .clk(CLOCK_50),
                .rst(rst),
                .br_cfg(br_cfg),
                .iocs(iocs),
                .iorw(iorw),
                .rda(rda),
                .tbr(tbr),
                .ioaddr(ioaddr),
                .databus(databus)
            );

			
// Don't change the code below
// display the baudrate on 7-seg display
always@(*) begin
	case (br_cfg)
        2'b00 : begin // 4800
            HEX5 = 7'b1111111;
            HEX4 = 7'b1111111;
            HEX3 = 7'b0011001; // 4
            HEX2 = 7'b0000000; // 8
            HEX1 = 7'b1000000; // 0
            HEX0 = 7'b1000000; // 0
        end

		2'b01 : begin // 9600
            HEX5 = 7'b1111111;
            HEX4 = 7'b1111111;
            HEX3 = 7'b0010000; // 9
            HEX2 = 7'b0000010; // 6
            HEX1 = 7'b1000000; // 0
            HEX0 = 7'b1000000; // 0
        end

        2'b10 : begin // 19200
            HEX5 = 7'b1111111;
            HEX4 = 7'b1111001; // 1
            HEX3 = 7'b0010000; // 9
            HEX2 = 7'b0100100; // 2
            HEX1 = 7'b1000000; // 0
            HEX0 = 7'b1000000; // 0
        end

        2'b11 : begin // 38400
            HEX5 = 7'b1111111;
            HEX4 = 7'b0110000; // 3
            HEX3 = 7'b0000000; // 8
            HEX2 = 7'b0011001; // 4
            HEX1 = 7'b1000000; // 0
            HEX0 = 7'b1000000; // 0
        end

        default : begin
            HEX5 = 7'b1111111;
            HEX4 = 7'b1111111;
            HEX3 = 7'b1111111;
            HEX2 = 7'b1111111;
            HEX1 = 7'b1111111;
            HEX0 = 7'b1111111;
        end

    endcase
end

endmodule
