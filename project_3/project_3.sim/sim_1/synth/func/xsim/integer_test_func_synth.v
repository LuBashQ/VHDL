// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Mon Sep 27 14:07:39 2021
// Host        : DESKTOP-THO084J running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               C:/Users/Veronica/VHDL/project_3/project_3.sim/sim_1/synth/func/xsim/integer_test_func_synth.v
// Design      : integer_test
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* NotValidForBitStream *)
module integer_test
   (sysclk,
    ja,
    jb);
  input sysclk;
  output [7:0]ja;
  output [7:0]jb;

  wire \int_a[0]_i_2_n_0 ;
  wire \int_a_reg[0]_i_1_n_0 ;
  wire \int_a_reg[0]_i_1_n_1 ;
  wire \int_a_reg[0]_i_1_n_2 ;
  wire \int_a_reg[0]_i_1_n_3 ;
  wire \int_a_reg[0]_i_1_n_4 ;
  wire \int_a_reg[0]_i_1_n_5 ;
  wire \int_a_reg[0]_i_1_n_6 ;
  wire \int_a_reg[0]_i_1_n_7 ;
  wire \int_a_reg[4]_i_1_n_1 ;
  wire \int_a_reg[4]_i_1_n_2 ;
  wire \int_a_reg[4]_i_1_n_3 ;
  wire \int_a_reg[4]_i_1_n_4 ;
  wire \int_a_reg[4]_i_1_n_5 ;
  wire \int_a_reg[4]_i_1_n_6 ;
  wire \int_a_reg[4]_i_1_n_7 ;
  wire [7:0]ja;
  wire [7:0]ja_OBUF;
  wire [7:0]jb;
  wire [4:0]jb_OBUF;
  wire [4:0]p_0_in;
  wire sysclk;
  wire sysclk_IBUF;
  wire sysclk_IBUF_BUFG;
  wire [3:3]\NLW_int_a_reg[4]_i_1_CO_UNCONNECTED ;

  LUT1 #(
    .INIT(2'h1)) 
    \int_a[0]_i_2 
       (.I0(ja_OBUF[0]),
        .O(\int_a[0]_i_2_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[0] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[0]_i_1_n_7 ),
        .Q(ja_OBUF[0]),
        .R(1'b0));
  CARRY4 \int_a_reg[0]_i_1 
       (.CI(1'b0),
        .CO({\int_a_reg[0]_i_1_n_0 ,\int_a_reg[0]_i_1_n_1 ,\int_a_reg[0]_i_1_n_2 ,\int_a_reg[0]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b1}),
        .O({\int_a_reg[0]_i_1_n_4 ,\int_a_reg[0]_i_1_n_5 ,\int_a_reg[0]_i_1_n_6 ,\int_a_reg[0]_i_1_n_7 }),
        .S({ja_OBUF[3:1],\int_a[0]_i_2_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[1] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[0]_i_1_n_6 ),
        .Q(ja_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[2] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[0]_i_1_n_5 ),
        .Q(ja_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[3] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[0]_i_1_n_4 ),
        .Q(ja_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[4] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[4]_i_1_n_7 ),
        .Q(ja_OBUF[4]),
        .R(1'b0));
  CARRY4 \int_a_reg[4]_i_1 
       (.CI(\int_a_reg[0]_i_1_n_0 ),
        .CO({\NLW_int_a_reg[4]_i_1_CO_UNCONNECTED [3],\int_a_reg[4]_i_1_n_1 ,\int_a_reg[4]_i_1_n_2 ,\int_a_reg[4]_i_1_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({\int_a_reg[4]_i_1_n_4 ,\int_a_reg[4]_i_1_n_5 ,\int_a_reg[4]_i_1_n_6 ,\int_a_reg[4]_i_1_n_7 }),
        .S(ja_OBUF[7:4]));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[5] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[4]_i_1_n_6 ),
        .Q(ja_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[6] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[4]_i_1_n_5 ),
        .Q(ja_OBUF[6]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_a_reg[7] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(\int_a_reg[4]_i_1_n_4 ),
        .Q(ja_OBUF[7]),
        .R(1'b0));
  LUT1 #(
    .INIT(2'h1)) 
    \int_b[0]_i_1 
       (.I0(jb_OBUF[0]),
        .O(p_0_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \int_b[1]_i_1 
       (.I0(jb_OBUF[0]),
        .I1(jb_OBUF[1]),
        .O(p_0_in[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \int_b[2]_i_1 
       (.I0(jb_OBUF[0]),
        .I1(jb_OBUF[1]),
        .I2(jb_OBUF[2]),
        .O(p_0_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \int_b[3]_i_1 
       (.I0(jb_OBUF[1]),
        .I1(jb_OBUF[0]),
        .I2(jb_OBUF[2]),
        .I3(jb_OBUF[3]),
        .O(p_0_in[3]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \int_b[4]_i_1 
       (.I0(jb_OBUF[2]),
        .I1(jb_OBUF[0]),
        .I2(jb_OBUF[1]),
        .I3(jb_OBUF[3]),
        .I4(jb_OBUF[4]),
        .O(p_0_in[4]));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[0] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[0]),
        .Q(jb_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[1] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[1]),
        .Q(jb_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[2] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[2]),
        .Q(jb_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[3] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[3]),
        .Q(jb_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \int_b_reg[4] 
       (.C(sysclk_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in[4]),
        .Q(jb_OBUF[4]),
        .R(1'b0));
  OBUF \ja_OBUF[0]_inst 
       (.I(ja_OBUF[0]),
        .O(ja[0]));
  OBUF \ja_OBUF[1]_inst 
       (.I(ja_OBUF[1]),
        .O(ja[1]));
  OBUF \ja_OBUF[2]_inst 
       (.I(ja_OBUF[2]),
        .O(ja[2]));
  OBUF \ja_OBUF[3]_inst 
       (.I(ja_OBUF[3]),
        .O(ja[3]));
  OBUF \ja_OBUF[4]_inst 
       (.I(ja_OBUF[4]),
        .O(ja[4]));
  OBUF \ja_OBUF[5]_inst 
       (.I(ja_OBUF[5]),
        .O(ja[5]));
  OBUF \ja_OBUF[6]_inst 
       (.I(ja_OBUF[6]),
        .O(ja[6]));
  OBUF \ja_OBUF[7]_inst 
       (.I(ja_OBUF[7]),
        .O(ja[7]));
  OBUF \jb_OBUF[0]_inst 
       (.I(jb_OBUF[0]),
        .O(jb[0]));
  OBUF \jb_OBUF[1]_inst 
       (.I(jb_OBUF[1]),
        .O(jb[1]));
  OBUF \jb_OBUF[2]_inst 
       (.I(jb_OBUF[2]),
        .O(jb[2]));
  OBUF \jb_OBUF[3]_inst 
       (.I(jb_OBUF[3]),
        .O(jb[3]));
  OBUF \jb_OBUF[4]_inst 
       (.I(jb_OBUF[4]),
        .O(jb[4]));
  OBUF \jb_OBUF[5]_inst 
       (.I(1'b0),
        .O(jb[5]));
  OBUF \jb_OBUF[6]_inst 
       (.I(1'b0),
        .O(jb[6]));
  OBUF \jb_OBUF[7]_inst 
       (.I(1'b0),
        .O(jb[7]));
  BUFG sysclk_IBUF_BUFG_inst
       (.I(sysclk_IBUF),
        .O(sysclk_IBUF_BUFG));
  IBUF sysclk_IBUF_inst
       (.I(sysclk),
        .O(sysclk_IBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
