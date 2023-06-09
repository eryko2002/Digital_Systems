
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module lab2(

	//////////// CLOCK //////////
	input 		          		CLOCK_50,

	//////////// LED //////////
	output		     [8:0]		LEDG,
	//output		    [17:0]		LEDR,
	output		    [7:0]		LEDR,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	//input 		    [17:0]		SW,
	input 		    [15:0]		SW,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,
	output		     [6:0]		HEX6,
	output		     [6:0]		HEX7
);
	localparam div_sel = 3'b101;

	wire localClock;

	wire [7:0] dataA;
	wire [7:0] dataB;
	wire [7:0] result;
	
	assign dataA = SW[15:8];
	assign dataB = SW[7:0];
	
	clock_divider b0(
		.rst		(~KEY[0]),
		.clk		(CLOCK_50),
		.ena		(1'b1),
		.div_sel	(div_sel),
		.div_clk	(localClock)
	);
	
	assign LEDG[8] = localClock;

	gcd_asmd
	#(
		.N (8)
	)
	b1
	(
		.rst		(~KEY[0]),
		.clk		(localClock),
		.ena		(1'b1),
		.start	(~KEY[3]),
		.dataA	(dataA),
		.dataB	(dataB),
		.res		(result),
		.rdy		(LEDG[0])
	);

	assign LEDR[7:0] = result;
	
	seven_seg b2(
		.data		(dataA[3:0]),
		.seg		(HEX6)
	);
	
	seven_seg b3(
		.data		(dataA[7:4]),
		.seg		(HEX7)
	);
	
	seven_seg b4(
		.data		(dataB[3:0]),
		.seg		(HEX4)
	);
	
	seven_seg b5(
		.data		(dataB[7:4]),
		.seg		(HEX5)
	);
	
	seven_seg b6(
		.data		(result[3:0]),
		.seg		(HEX2)
	);
	
	seven_seg b7(
		.data		(result[7:4]),
		.seg		(HEX3)
	);

	
	assign HEX0 = 7'b0111111;
	assign HEX1 = 7'b0111111;
endmodule
