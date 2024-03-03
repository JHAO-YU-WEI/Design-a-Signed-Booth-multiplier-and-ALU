//------------------------------------------------------//
//- Digital IC Design 2021                              //
//-                                                     //
//- Lab03b: Verilog Gate Level                          //
//------------------------------------------------------//
`timescale 1ns/10ps

module add4(out, cout, in1, in2, cin); 
	input  	[3:0] 	in1, in2;
	input        	cin;
	output 	[3:0] 	out;
	output		 	cout;
	wire 			c0;
	wire 			c1;
	wire 			c2;

	ADDFX1 U1(.S(out[0]),   .CO(c0), .A(in1[0]), .B(in2[0]), .CI(cin));
	ADDFX1 U2(.S(out[1]),   .CO(c1), .A(in1[1]), .B(in2[1]), .CI(c0));
	ADDFX1 U3(.S(out[2]),   .CO(c2), .A(in1[2]), .B(in2[2]), .CI(c1));
	ADDFX1 U4(.S(out[3]), .CO(cout), .A(in1[3]), .B(in2[3]), .CI(c2));

endmodule

module add8(out8, cout8, in18, in28);
	input  	[7:0] 	in18, in28;
	output 	[7:0] 	out8;
	output			cout8;
	wire 			c0;

	add4	A81(.out(out8[3:0]), .cout(c0), .in1(in18[3:0]), .in2(in28[3:0]), .cin(1'b0));
	add4	A82(.out(out8[7:4]),   .cout(), .in1(in18[7:4]), .in2(in28[7:4]), .cin(c0));

endmodule

module Concat(out0, ina0, inb0);
	input	[3:0]	ina0, inb0;
	output	[7:0]	out0;

	BUFX1 addcon1(.Y(out0[0]), .A(inb0[0]));
	BUFX1 addcon2(.Y(out0[1]), .A(inb0[1]));
	BUFX1 addcon3(.Y(out0[2]), .A(inb0[2]));
	BUFX1 addcon4(.Y(out0[3]), .A(inb0[3]));
	BUFX1 addcon5(.Y(out0[4]), .A(ina0[0]));
	BUFX1 addcon6(.Y(out0[5]), .A(ina0[1]));
	BUFX1 addcon7(.Y(out0[6]), .A(ina0[2]));
	BUFX1 addcon8(.Y(out0[7]), .A(ina0[3]));
endmodule

module Leftb(out2, inb2);
	input	[3:0]	inb2;
	output	[7:0]	out2;
	
	BUFX1	W1(.Y(out2[0]), .A(1'b0));
	BUFX1	W2(.Y(out2[1]), .A(inb2[0]));
	BUFX1	W3(.Y(out2[2]), .A(inb2[1]));
	BUFX1	W4(.Y(out2[3]), .A(inb2[2]));
	BUFX1	W5(.Y(out2[4]), .A(1'b0));
	BUFX1	W6(.Y(out2[5]), .A(1'b0));
	BUFX1 	W7(.Y(out2[6]), .A(1'b0));
	BUFX1	W8(.Y(out2[7]), .A(inb2[3]));
endmodule

module Rightb(out3, inb3);
	input	[3:0]	inb3;
	output	[7:0]	out3;
	
	BUFX1	X1(.Y(out3[0]), .A(inb3[1]));
	BUFX1	X2(.Y(out3[1]), .A(inb3[2]));
	BUFX1	X3(.Y(out3[2]), .A(1'b0));
	BUFX1	X4(.Y(out3[3]), .A(1'b0));
	BUFX1	X5(.Y(out3[4]), .A(1'b0));
	BUFX1	X6(.Y(out3[5]), .A(1'b0));
	BUFX1 	X7(.Y(out3[6]), .A(1'b0));
	BUFX1	X8(.Y(out3[7]), .A(inb3[3]));

endmodule



module Bit4t8(out8b, in4b);  //in4bit to outbit8
	input	[3:0]		in4b;
	output	[7:0]		out8b;

	BUFX1 B1(.Y(out8b[0]), .A(in4b[0]));
	BUFX1 B2(.Y(out8b[1]), .A(in4b[1]));
	BUFX1 B3(.Y(out8b[2]), .A(in4b[2]));
	BUFX1 B4(.Y(out8b[3]), .A(1'b0));
	BUFX1 B5(.Y(out8b[4]), .A(1'b0));
	BUFX1 B6(.Y(out8b[5]), .A(1'b0));
	BUFX1 B7(.Y(out8b[6]), .A(1'b0));
	BUFX1 B8(.Y(out8b[7]), .A(in4b[3]));

endmodule


module	Comple2(outcom8b, in8b);   //to 2 comple
	input	[7:0]		in8b;
	output 	[7:0]		outcom8b;
	wire				cm0,cm1,cm2,cm3,cm4,cm5,cm6;
	wire				c0,c1,c2,c3,c4,c5,c6,c7,c8;

	INVX1		Com1(cm0, in8b[0]);
	INVX1		Com2(cm1, in8b[1]);
	INVX1		Com3(cm2, in8b[2]);
	INVX1		Com4(cm3, in8b[3]);
	INVX1		Com5(cm4, in8b[4]);
	INVX1		Com6(cm5, in8b[5]);
	INVX1		Com7(cm6, in8b[6]);
	BUFX1		Com8(cm7, in8b[7]);
	ADDFX1 		Com9 (.S(outcom8b[0]), .CO(c0), .A(cm0), .B(1'b1), .CI(1'b0));
	ADDFX1 		Com10(.S(outcom8b[1]), .CO(c1), .A(cm1), .B(1'b0), .CI(c0));
	ADDFX1		Com11(.S(outcom8b[2]), .CO(c2), .A(cm2), .B(1'b0), .CI(c1));
	ADDFX1 		Com12(.S(outcom8b[3]), .CO(c3), .A(cm3), .B(1'b0), .CI(c2));
	ADDFX1 		Com13(.S(outcom8b[4]), .CO(c4), .A(cm4), .B(1'b0), .CI(c3));
	ADDFX1 		Com14(.S(outcom8b[5]), .CO(c5), .A(cm5), .B(1'b0), .CI(c4));
	ADDFX1 		Com15(.S(outcom8b[6]), .CO(c6), .A(cm6), .B(1'b0), .CI(c5));
	ADDFX1 		Com16(.S(c8), .CO(c7), .A(cm7), .B(1'b0), .CI(c6));
	OR2X1		Com17(outcom8b[7],c7,c8);

endmodule 


module Xorsign8b(outs, ins);
	input	[7:0]	ins;
	output	[7:0]	outs;

	BUFX1		S1(outs[0],ins[0]);  
	BUFX1		S2(outs[1],ins[1]);
	BUFX1		S3(outs[2],ins[2]); 	
	BUFX1		S4(outs[3],ins[3]);
	BUFX1		S5(outs[4],ins[4]);
	BUFX1		S6(outs[5],ins[5]);
	BUFX1		S7(outs[6],ins[6]);
	INVX1		S8(outs[7],ins[7]);

endmodule

module Leftb1(outlx1, inlx1);
	input	[7:0]	inlx1;
	output	[7:0]	outlx1;
	
	BUFX1 LB11(.Y(outlx1[0]), .A(1'b0));
	BUFX1 LB12(.Y(outlx1[1]), .A(inlx1[0]));
	BUFX1 LB13(.Y(outlx1[2]), .A(inlx1[1]));
	BUFX1 LB14(.Y(outlx1[3]), .A(inlx1[2]));
	BUFX1 LB15(.Y(outlx1[4]), .A(inlx1[3]));
	BUFX1 LB16(.Y(outlx1[5]), .A(inlx1[4]));
	BUFX1 LB17(.Y(outlx1[6]), .A(inlx1[5]));
	BUFX1 LB18(.Y(outlx1[7]), .A(inlx1[7]));

endmodule


module Leftb2(outlx2, inlx2);
	input	[7:0]	inlx2;
	output	[7:0]	outlx2;

	
	BUFX1 LB21(.Y(outlx2[0]), .A(1'b0));
	BUFX1 LB22(.Y(outlx2[1]), .A(1'b0));
	BUFX1 LB23(.Y(outlx2[2]), .A(inlx2[0]));
	BUFX1 LB24(.Y(outlx2[3]), .A(inlx2[1]));
	BUFX1 LB25(.Y(outlx2[4]), .A(inlx2[2]));
	BUFX1 LB26(.Y(outlx2[5]), .A(inlx2[3]));
	BUFX1 LB27(.Y(outlx2[6]), .A(inlx2[4]));
	BUFX1 LB28(.Y(outlx2[7]), .A(inlx2[7]));


endmodule



module Encoder(outcor, outtwo, outone, iny3, iny2, iny1);
	input			iny3, iny2, iny1;
	output			outcor,outtwo, outone;
	wire			iny3n, iny2n, iny1n;
	wire			two1,two2;
	wire			one12;
	wire			cor1;
	
	INVX1		H1(iny3n, iny3);
	INVX1		H2(iny2n, iny2);
	INVX1		H3(iny1n, iny1);
	AND3X1  	H4(two1, iny3n, iny2, iny1);
	AND3X1  	H5(two2, iny3, iny2n, iny1n);
	OR2X1		H6(outtwo, two1, two2);
	XOR2X1 		H7(outone, iny2, iny1);
	OR2X1		H8(cor1, iny1n, iny2n);
	AND2X1		H9(outcor, cor1, iny3);
endmodule 


module Detercom8(outde, inde);
	input	[7:0]	inde;
	output	[7:0]	outde;
	wire	[7:0]	comde;

	Comple2     CDe(.outcom8b(comde), .in8b(inde));
	MX2X1	    De1(.Y(outde[0]), .A(inde[0]), .B(comde[0]), .S0(inde[7]));
	MX2X1	 	De2(.Y(outde[1]), .A(inde[1]), .B(comde[1]), .S0(inde[7]));
	MX2X1	 	De3(.Y(outde[2]), .A(inde[2]), .B(comde[2]), .S0(inde[7]));
	MX2X1	 	De4(.Y(outde[3]), .A(inde[3]), .B(comde[3]), .S0(inde[7]));
	MX2X1	    De5(.Y(outde[4]), .A(inde[4]), .B(comde[4]), .S0(inde[7]));
	MX2X1	 	De6(.Y(outde[5]), .A(inde[5]), .B(comde[5]), .S0(inde[7]));
	MX2X1	 	De7(.Y(outde[6]), .A(inde[6]), .B(comde[6]), .S0(inde[7]));
	MX2X1	 	De8(.Y(outde[7]), .A(inde[7]), .B(comde[7]), .S0(inde[7]));
	
	
endmodule


module MUX21t8b(outmux2t8, inmux2t8a,  inmux2t8b, sel2t1);
	input	[7:0]	inmux2t8a,inmux2t8b;
	input			sel2t1;
	output	[7:0]	outmux2t8;

	MX2X1    	MUX2T1(.Y(outmux2t8[0]), .A(inmux2t8a[0]), .B(inmux2t8b[0]), .S0(sel2t1));	
	MX2X1    	MUX2T2(.Y(outmux2t8[1]), .A(inmux2t8a[1]), .B(inmux2t8b[1]), .S0(sel2t1));	
	MX2X1    	MUX2T3(.Y(outmux2t8[2]), .A(inmux2t8a[2]), .B(inmux2t8b[2]), .S0(sel2t1));	
	MX2X1    	MUX2T4(.Y(outmux2t8[3]), .A(inmux2t8a[3]), .B(inmux2t8b[3]), .S0(sel2t1));	
	MX2X1    	MUX2T5(.Y(outmux2t8[4]), .A(inmux2t8a[4]), .B(inmux2t8b[4]), .S0(sel2t1));	
	MX2X1    	MUX2T6(.Y(outmux2t8[5]), .A(inmux2t8a[5]), .B(inmux2t8b[5]), .S0(sel2t1));	
	MX2X1    	MUX2T7(.Y(outmux2t8[6]), .A(inmux2t8a[6]), .B(inmux2t8b[6]), .S0(sel2t1));	
	MX2X1    	MUX2T8(.Y(outmux2t8[7]), .A(inmux2t8a[7]), .B(inmux2t8b[7]), .S0(sel2t1));	

endmodule


module MUX41t8b(outmux4t8, inmux4t8a,  inmux4t8b,  inmux4t8c,  inmux4t8d, sel4t1, sel4t2);
	input	[7:0]	inmux4t8a,inmux4t8b,inmux4t8c,inmux4t8d;
	input			sel4t1,sel4t2;
	output	[7:0]	outmux4t8;

	MX4X1    	MUX4T1(.Y(outmux4t8[0]), .A(inmux4t8a[0]), .B(inmux4t8b[0]), .C(inmux4t8c[0]), .D(inmux4t8d[0]), 
						.S0(sel4t1), .S1(sel4t2));	
	MX4X1       MUX4T2(.Y(outmux4t8[1]), .A(inmux4t8a[1]), .B(inmux4t8b[1]), .C(inmux4t8c[1]), .D(inmux4t8d[1]), 
						.S0(sel4t1), .S1(sel4t2));		
 	MX4X1    	MUX4T3(.Y(outmux4t8[2]), .A(inmux4t8a[2]), .B(inmux4t8b[2]), .C(inmux4t8c[2]), .D(inmux4t8d[2]), 
						.S0(sel4t1), .S1(sel4t2));	
	MX4X1    	MUX4T4(.Y(outmux4t8[3]), .A(inmux4t8a[3]), .B(inmux4t8b[3]), .C(inmux4t8c[3]), .D(inmux4t8d[3]), 
						.S0(sel4t1), .S1(sel4t2));	
	MX4X1    	MUX4T5(.Y(outmux4t8[4]), .A(inmux4t8a[4]), .B(inmux4t8b[4]), .C(inmux4t8c[4]), .D(inmux4t8d[4]), 
						.S0(sel4t1), .S1(sel4t2));		
	MX4X1    	MUX4T6(.Y(outmux4t8[5]), .A(inmux4t8a[5]), .B(inmux4t8b[5]), .C(inmux4t8c[5]), .D(inmux4t8d[5]), 
						.S0(sel4t1), .S1(sel4t2));		
 	MX4X1   	MUX4T7(.Y(outmux4t8[6]), .A(inmux4t8a[6]), .B(inmux4t8b[6]), .C(inmux4t8c[6]), .D(inmux4t8d[6]), 
						.S0(sel4t1), .S1(sel4t2));	
	MX4X1    	MUX4T8(.Y(outmux4t8[7]), .A(inmux4t8a[7]), .B(inmux4t8b[7]), .C(inmux4t8c[7]), .D(inmux4t8d[7]), 
						.S0(sel4t1), .S1(sel4t2));	

endmodule


module Table(outta, inta, selta1, selta2, selta3);
	input	[7:0]	inta;
	input			selta1,selta2,selta3;
	output	[7:0]	outta;
	wire	[7:0]	intasl2;
	wire	[7:0]	out41ta;
	wire	[7:0]	Comple2x;
	wire	[7:0]	Xorsignx;
	wire	[7:0]	outta;
	
	Leftb1 		Ta1(.outlx1(intasl2), .inlx1(inta));
	MUX41t8b	Ta2(.outmux4t8(out41ta), .inmux4t8a(8'b0),  .inmux4t8b(inta),  .inmux4t8c(intasl2),  .inmux4t8d(8'b0), 
					.sel4t1(selta1), .sel4t2(selta2));
	Xorsign8b   Ta3(.outs(Xorsignx), .ins(out41ta));							//Comple2	  Ta3(.outcom8b(Comple2x), .in8b(out41ta));  -0 problem
	Comple2		Ta4(.outcom8b(Comple2x), .in8b(Xorsignx));						//Xorsign8b   Ta4(.outs(Xorsignx), .ins(Comple2x));  	 -0 problem
	MUX21t8b	Ta5(.outmux2t8(outta), .inmux2t8a(out41ta),  .inmux2t8b(Comple2x), .sel2t1(selta3));

endmodule


module Radix4MUL(out1, ina10, inb10);
	input	[3:0]	ina10;
	input	[3:0]	inb10;
	output	[7:0]	out1;
	wire	[7:0]	a4t8,b4t8;
	wire	[7:0]	ina1,inb1;
	wire			seltwo1,seltwo2;
	wire			selone1,selone2;
	wire			selneg1,selneg2;
	wire			sel0neg1,sel0neg2;
	wire	[7:0]	outxy1,outxy2,xy2;
	wire			coutab;
	wire	[7:0]	outab;


	Bit4t8		RX1(     .out8b(a4t8), .in4b(ina10));
	Bit4t8		RX2(     .out8b(b4t8), .in4b(inb10));
	Detercom8	RX3(     .outde(ina1), .inde(a4t8));
	Detercom8	RX4(     .outde(inb1), .inde(b4t8));
	Encoder 	RX5( .outcor(selcor1), .outtwo(seltwo1), .outone(selone1), .iny3(inb1[1]), .iny2(inb1[0]), .iny1(1'b0));
	Encoder  	RX6( .outcor(selcor2), .outtwo(seltwo2), .outone(selone2), .iny3(inb1[3]), .iny2(inb1[2]), .iny1(inb1[1]));
	Table		RX7(   .outta(outxy1), .inta(ina1), .selta1(selone1), .selta2(seltwo1), .selta3(selcor1));
	Table		RX8(   .outta(outxy2), .inta(ina1), .selta1(selone2), .selta2(seltwo2), .selta3(selcor2));
	Leftb2		RX9(     .outlx2(xy2), .inlx2(outxy2));
	add8		RX10(	 .out8(outab), .cout8(coutab), .in18(outxy1), .in28(xy2));
	Detercom8	RX11(    .outde(out1), .inde(outab));

	
endmodule



module lab03b(a, b, out, sel);

	input  	[3:0] 	a, b;
	input  	[1:0] 	sel;
	output 	[7:0] 	out;
	
	wire	[7:0]	in0,in1,in2,in3;	

//Examples to instantiate the cells from cell library
//AND2X1 u1(out1,a,b);
  
//** Add your code below this line **//

	Concat      Lb1(.out0(in0), .ina0(a), .inb0(b));
	Radix4MUL	Lb2(.out1(in1), .ina10(a), .inb10(b));
	Leftb       Lb3(.out2(in2), .inb2(b));
	Rightb      Lb4(.out3(in3), .inb3(b));
	MUX41t8b	Lb5(.outmux4t8(out), .inmux4t8a(in0),  .inmux4t8b(in1),  .inmux4t8c(in2),  .inmux4t8d(in3), 
						.sel4t1(sel[0]), .sel4t2(sel[1]));


endmodule