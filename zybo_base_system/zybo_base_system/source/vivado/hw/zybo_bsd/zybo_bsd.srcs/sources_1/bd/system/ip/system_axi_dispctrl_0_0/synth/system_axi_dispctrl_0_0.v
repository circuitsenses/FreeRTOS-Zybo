// (c) Copyright 1995-2015 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: Digilent:digilent:axi_dispctrl:1.0
// IP Revision: 9

(* X_CORE_INFO = "axi_dispctrl_v1_0,Vivado 2014.2" *)
(* CHECK_LICENSE_TYPE = "system_axi_dispctrl_0_0,axi_dispctrl_v1_0,{}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module system_axi_dispctrl_0_0 (
  REF_CLK_I,
  PXL_CLK_O,
  PXL_CLK_5X_O,
  LOCKED_O,
  FSYNC_O,
  HSYNC_O,
  VSYNC_O,
  DE_O,
  RED_O,
  GREEN_O,
  BLUE_O,
  DEBUG_O,
  s_axi_aclk,
  s_axi_aresetn,
  s_axi_awaddr,
  s_axi_awprot,
  s_axi_awvalid,
  s_axi_awready,
  s_axi_wdata,
  s_axi_wstrb,
  s_axi_wvalid,
  s_axi_wready,
  s_axi_bresp,
  s_axi_bvalid,
  s_axi_bready,
  s_axi_araddr,
  s_axi_arprot,
  s_axi_arvalid,
  s_axi_arready,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rvalid,
  s_axi_rready,
  s_axis_mm2s_aclk,
  s_axis_mm2s_aresetn,
  s_axis_mm2s_tready,
  s_axis_mm2s_tdata,
  s_axis_mm2s_tstrb,
  s_axis_mm2s_tlast,
  s_axis_mm2s_tvalid
);

(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 REF_CLK_I CLK" *)
input wire REF_CLK_I;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PXL_CLK_O CLK" *)
output wire PXL_CLK_O;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PXL_CLK_5X_O CLK" *)
output wire PXL_CLK_5X_O;
output wire LOCKED_O;
output wire FSYNC_O;
output wire HSYNC_O;
output wire VSYNC_O;
output wire DE_O;
output wire [4 : 0] RED_O;
output wire [5 : 0] GREEN_O;
output wire [4 : 0] BLUE_O;
output wire [31 : 0] DEBUG_O;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_AXI_CLK CLK" *)
input wire s_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_AXI_RST RST" *)
input wire s_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWADDR" *)
input wire [5 : 0] s_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWPROT" *)
input wire [2 : 0] s_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWVALID" *)
input wire s_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI AWREADY" *)
output wire s_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WDATA" *)
input wire [31 : 0] s_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WSTRB" *)
input wire [3 : 0] s_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WVALID" *)
input wire s_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI WREADY" *)
output wire s_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BRESP" *)
output wire [1 : 0] s_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BVALID" *)
output wire s_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI BREADY" *)
input wire s_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARADDR" *)
input wire [5 : 0] s_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARPROT" *)
input wire [2 : 0] s_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARVALID" *)
input wire s_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI ARREADY" *)
output wire s_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RDATA" *)
output wire [31 : 0] s_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RRESP" *)
output wire [1 : 0] s_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RVALID" *)
output wire s_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S_AXI RREADY" *)
input wire s_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S_AXIS_MM2S_CLK CLK" *)
input wire s_axis_mm2s_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S_AXIS_MM2S_RST RST" *)
input wire s_axis_mm2s_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S TREADY" *)
output wire s_axis_mm2s_tready;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S TDATA" *)
input wire [31 : 0] s_axis_mm2s_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S TSTRB" *)
input wire [3 : 0] s_axis_mm2s_tstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S TLAST" *)
input wire s_axis_mm2s_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S_AXIS_MM2S TVALID" *)
input wire s_axis_mm2s_tvalid;

  axi_dispctrl_v1_0 #(
    .C_USE_BUFR_DIV5(0),
    .C_RED_WIDTH(5),
    .C_GREEN_WIDTH(6),
    .C_BLUE_WIDTH(5),
    .C_S_AXI_DATA_WIDTH(32),
    .C_S_AXI_ADDR_WIDTH(6),
    .C_S_AXIS_MM2S_TDATA_WIDTH(32)
  ) inst (
    .REF_CLK_I(REF_CLK_I),
    .PXL_CLK_O(PXL_CLK_O),
    .PXL_CLK_5X_O(PXL_CLK_5X_O),
    .LOCKED_O(LOCKED_O),
    .FSYNC_O(FSYNC_O),
    .HSYNC_O(HSYNC_O),
    .VSYNC_O(VSYNC_O),
    .DE_O(DE_O),
    .RED_O(RED_O),
    .GREEN_O(GREEN_O),
    .BLUE_O(BLUE_O),
    .DEBUG_O(DEBUG_O),
    .s_axi_aclk(s_axi_aclk),
    .s_axi_aresetn(s_axi_aresetn),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awprot(s_axi_awprot),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .s_axis_mm2s_aclk(s_axis_mm2s_aclk),
    .s_axis_mm2s_aresetn(s_axis_mm2s_aresetn),
    .s_axis_mm2s_tready(s_axis_mm2s_tready),
    .s_axis_mm2s_tdata(s_axis_mm2s_tdata),
    .s_axis_mm2s_tstrb(s_axis_mm2s_tstrb),
    .s_axis_mm2s_tlast(s_axis_mm2s_tlast),
    .s_axis_mm2s_tvalid(s_axis_mm2s_tvalid)
  );
endmodule
