// Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2021.1 (win64) Build 3247384 Thu Jun 10 19:36:33 MDT 2021
// Date        : Mon Sep  6 15:49:56 2021
// Host        : DESKTOP-THO084J running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               C:/Users/Veronica/VHDL/project_1/project_1.sim/sim_1/impl/timing/xsim/logic_gates_time_impl.v
// Design      : logic_gates
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* ECO_CHECKSUM = "9edb0465" *) 
(* NotValidForBitStream *)
module logic_gates
   (btn,
    sw,
    led,
    led4_r,
    led4_g,
    led4_b,
    led5_r,
    led5_g,
    led5_b);
  input [1:0]btn;
  input [1:0]sw;
  output [3:0]led;
  output led4_r;
  output led4_g;
  output led4_b;
  output led5_r;
  output led5_g;
  output led5_b;

  wire [1:0]btn;
  wire [1:0]btn_IBUF;
  wire [3:0]led;
  wire led4_b;
  wire led4_b_OBUF;
  wire led4_g;
  wire led4_g_OBUF;
  wire led4_r;
  wire led4_r_OBUF;
  wire led5_b;
  wire led5_b_OBUF;
  wire led5_g;
  wire led5_g_OBUF;
  wire led5_r;
  wire led5_r_OBUF;
  wire [3:0]led_OBUF;
  wire [1:0]sw;
  wire [1:0]sw_IBUF;

initial begin
 $sdf_annotate("logic_gates_time_impl.sdf",,,,"tool_control");
end
  IBUF \btn_IBUF[0]_inst 
       (.I(btn[0]),
        .O(btn_IBUF[0]));
  IBUF \btn_IBUF[1]_inst 
       (.I(btn[1]),
        .O(btn_IBUF[1]));
  OBUF led4_b_OBUF_inst
       (.I(led4_b_OBUF),
        .O(led4_b));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h8)) 
    led4_b_OBUF_inst_i_1
       (.I0(btn_IBUF[1]),
        .I1(btn_IBUF[0]),
        .O(led4_b_OBUF));
  OBUF led4_g_OBUF_inst
       (.I(led4_g_OBUF),
        .O(led4_g));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    led4_g_OBUF_inst_i_1
       (.I0(btn_IBUF[1]),
        .I1(btn_IBUF[0]),
        .O(led4_g_OBUF));
  OBUF led4_r_OBUF_inst
       (.I(led4_r_OBUF),
        .O(led4_r));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    led4_r_OBUF_inst_i_1
       (.I0(btn_IBUF[0]),
        .I1(btn_IBUF[1]),
        .O(led4_r_OBUF));
  OBUF led5_b_OBUF_inst
       (.I(led5_b_OBUF),
        .O(led5_b));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hEAAA)) 
    led5_b_OBUF_inst_i_1
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[1]),
        .I2(btn_IBUF[0]),
        .I3(sw_IBUF[0]),
        .O(led5_b_OBUF));
  OBUF led5_g_OBUF_inst
       (.I(led5_g_OBUF),
        .O(led5_g));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT4 #(
    .INIT(16'hAEAA)) 
    led5_g_OBUF_inst_i_1
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[1]),
        .I2(btn_IBUF[0]),
        .I3(sw_IBUF[0]),
        .O(led5_g_OBUF));
  OBUF led5_r_OBUF_inst
       (.I(led5_r_OBUF),
        .O(led5_r));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'hAEAA)) 
    led5_r_OBUF_inst_i_1
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[0]),
        .I2(btn_IBUF[1]),
        .I3(sw_IBUF[0]),
        .O(led5_r_OBUF));
  OBUF \led_OBUF[0]_inst 
       (.I(led_OBUF[0]),
        .O(led[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h81)) 
    \led_OBUF[0]_inst_i_1 
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[1]),
        .I2(btn_IBUF[0]),
        .O(led_OBUF[0]));
  OBUF \led_OBUF[1]_inst 
       (.I(led_OBUF[1]),
        .O(led[1]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h2C)) 
    \led_OBUF[1]_inst_i_1 
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[0]),
        .I2(btn_IBUF[1]),
        .O(led_OBUF[1]));
  OBUF \led_OBUF[2]_inst 
       (.I(led_OBUF[2]),
        .O(led[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hAC)) 
    \led_OBUF[2]_inst_i_1 
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[1]),
        .I2(btn_IBUF[0]),
        .O(led_OBUF[2]));
  OBUF \led_OBUF[3]_inst 
       (.I(led_OBUF[3]),
        .O(led[3]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    \led_OBUF[3]_inst_i_1 
       (.I0(sw_IBUF[1]),
        .I1(btn_IBUF[0]),
        .I2(btn_IBUF[1]),
        .O(led_OBUF[3]));
  IBUF \sw_IBUF[0]_inst 
       (.I(sw[0]),
        .O(sw_IBUF[0]));
  IBUF \sw_IBUF[1]_inst 
       (.I(sw[1]),
        .O(sw_IBUF[1]));
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
