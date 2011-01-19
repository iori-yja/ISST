module transmittr (
	input Srialclk,
	input Wrtcmplt,
	input [11:0]data,
	output SrialData
);
reg [11:0]Datareg;
reg Endflg;
wire Endtoken;
assign Endtoken = Endflg & ~Srialclk;
assign SrialData = Endtoken ? ~Datareg[0] : Datareg[0];
reg  [3:0]ShftCount = 0;
	always@( posedge Srialclk )begin
			Datareg[11:0] <= { 1'b0, Datareg[11:1] };
			ShftCount <= ShftCount + 4'h1;
			if ( ShftCount == 4'hB )begin
				Endflg <= 1'b1;
				if( Wrtcmplt )begin
					ShftCount <= 0;
					end
				end
			else if ( ShftCount == 4'h0 )begin
				Endflg <= 0;
				Datareg[11:0] <= data[11:0];
				end
			end

endmodule
