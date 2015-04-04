// ***************************************************************************
// ***************************************************************************
// Copyright 2011(c) Analog Devices, Inc.
// 
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//    
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF 
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module up_hdmi_tx (

  // hdmi interface

  hdmi_clk,
  hdmi_rst,
  hdmi_full_range,
  hdmi_csc_bypass,
  hdmi_srcsel,
  hdmi_const_rgb,
  hdmi_hl_active,
  hdmi_hl_width,
  hdmi_hs_width,
  hdmi_he_max,
  hdmi_he_min,
  hdmi_vf_active,
  hdmi_vf_width,
  hdmi_vs_width,
  hdmi_ve_max,
  hdmi_ve_min,
  hdmi_status,
  hdmi_tpm_oos,
  hdmi_clk_ratio,

  // vdma interface

  vdma_clk,
  vdma_rst,
  vdma_ovf,
  vdma_unf,
  vdma_tpm_oos,

  // bus interface

  up_rstn,
  up_clk,
  up_sel,
  up_wr,
  up_addr,
  up_wdata,
  up_rdata,
  up_ack);

  // parameters

  parameter   PCORE_VERSION = 32'h00040062;
  parameter   PCORE_ID = 0;

  // hdmi interface

  input           hdmi_clk;
  output          hdmi_rst;
  output          hdmi_full_range;
  output          hdmi_csc_bypass;
  output  [ 1:0]  hdmi_srcsel;
  output  [23:0]  hdmi_const_rgb;
  output  [15:0]  hdmi_hl_active;
  output  [15:0]  hdmi_hl_width;
  output  [15:0]  hdmi_hs_width;
  output  [15:0]  hdmi_he_max;
  output  [15:0]  hdmi_he_min;
  output  [15:0]  hdmi_vf_active;
  output  [15:0]  hdmi_vf_width;
  output  [15:0]  hdmi_vs_width;
  output  [15:0]  hdmi_ve_max;
  output  [15:0]  hdmi_ve_min;
  input           hdmi_status;
  input           hdmi_tpm_oos;
  input   [31:0]  hdmi_clk_ratio;

  // vdma interface

  input           vdma_clk;
  output          vdma_rst;
  input           vdma_ovf;
  input           vdma_unf;
  input           vdma_tpm_oos;

  // bus interface

  input           up_rstn;
  input           up_clk;
  input           up_sel;
  input           up_wr;
  input   [13:0]  up_addr;
  input   [31:0]  up_wdata;
  output  [31:0]  up_rdata;
  output          up_ack;

  // internal registers

  reg     [31:0]  up_scratch = 'd0;
  reg             up_resetn = 'd0;
  reg             up_full_range = 'd0;
  reg             up_csc_bypass = 'd0;
  reg     [ 1:0]  up_srcsel = 'd1;
  reg     [23:0]  up_const_rgb = 'd0;
  reg     [15:0]  up_hl_active = 'd0;
  reg     [15:0]  up_hl_width = 'd0;
  reg     [15:0]  up_hs_width = 'd0;
  reg     [15:0]  up_he_max = 'd0;
  reg     [15:0]  up_he_min = 'd0;
  reg     [15:0]  up_vf_active = 'd0;
  reg     [15:0]  up_vf_width = 'd0;
  reg     [15:0]  up_vs_width = 'd0;
  reg     [15:0]  up_ve_max = 'd0;
  reg     [15:0]  up_ve_min = 'd0;
  reg             up_ack = 'd0;
  reg     [31:0]  up_rdata = 'd0;
  reg             up_xfer_toggle = 'd0;
  reg             hdmi_up_xfer_toggle_m1 = 'd0;
  reg             hdmi_up_xfer_toggle_m2 = 'd0;
  reg             hdmi_up_xfer_toggle_m3 = 'd0;
  reg             hdmi_full_range = 'd0;
  reg             hdmi_csc_bypass = 'd0;
  reg     [ 1:0]  hdmi_srcsel = 'd1;
  reg     [23:0]  hdmi_const_rgb = 'd0;
  reg     [15:0]  hdmi_hl_active = 'd0;
  reg     [15:0]  hdmi_hl_width = 'd0;
  reg     [15:0]  hdmi_hs_width = 'd0;
  reg     [15:0]  hdmi_he_max = 'd0;
  reg     [15:0]  hdmi_he_min = 'd0;
  reg     [15:0]  hdmi_vf_active = 'd0;
  reg     [15:0]  hdmi_vf_width = 'd0;
  reg     [15:0]  hdmi_vs_width = 'd0;
  reg     [15:0]  hdmi_ve_max = 'd0;
  reg     [15:0]  hdmi_ve_min = 'd0;
  reg             up_hdmi_status_m1 = 'd0;
  reg             up_hdmi_status = 'd0;
  reg             up_hdmi_tpm_oos_m1 = 'd0;
  reg             up_hdmi_tpm_oos_m2 = 'd0;
  reg             up_hdmi_tpm_oos = 'd0;
  reg             up_count_toggle_m1 = 'd0;
  reg             up_count_toggle_m2 = 'd0;
  reg             up_count_toggle_m3 = 'd0;
  reg             up_count_toggle = 'd0;
  reg     [15:0]  up_count = 'd0;
  reg     [31:0]  up_hdmi_clk_count = 'd0;
  reg             hdmi_clk_count_toggle_m1 = 'd0;
  reg             hdmi_clk_count_toggle_m2 = 'd0;
  reg             hdmi_clk_count_toggle_m3 = 'd0;
  reg             hdmi_clk_count_toggle = 'd0;
  reg     [31:0]  hdmi_clk_count_hold = 'd0;
  reg     [32:0]  hdmi_clk_count = 'd0;
  reg     [ 5:0]  vdma_xfer_cnt = 'd0;
  reg             vdma_xfer_toggle = 'd0;
  reg             vdma_xfer_ovf = 'd0;
  reg             vdma_xfer_unf = 'd0;
  reg             vdma_acc_ovf = 'd0;
  reg             vdma_acc_unf = 'd0;
  reg             up_vdma_xfer_toggle_m1 = 'd0;
  reg             up_vdma_xfer_toggle_m2 = 'd0;
  reg             up_vdma_xfer_toggle_m3 = 'd0;
  reg             up_vdma_xfer_ovf = 'd0;
  reg             up_vdma_xfer_unf = 'd0;
  reg             up_vdma_ovf = 'd0;
  reg             up_vdma_unf = 'd0;
  reg             up_vdma_tpm_oos_m1 = 'd0;
  reg             up_vdma_tpm_oos_m2 = 'd0;
  reg             up_vdma_tpm_oos = 'd0;

  // internal signals

  wire            up_sel_s;
  wire            up_wr_s;
  wire            up_preset_s;
  wire            hdmi_up_xfer_toggle_s;
  wire            up_count_toggle_s;
  wire            hdmi_clk_count_toggle_s;
  wire            up_vdma_xfer_toggle_s;

  // decode block select

  assign up_sel_s = (up_addr[13:12] == 2'd0) ? up_sel : 1'b0;
  assign up_wr_s = up_sel_s & up_wr;
  assign up_preset_s = ~up_resetn;

  // processor write interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_scratch <= 'd0;
      up_resetn <= 'd0;
      up_full_range <= 'd0;
      up_csc_bypass <= 'd0;
      up_srcsel <= 'd1;
      up_const_rgb <= 'd0;
      up_hl_active <= 'd0;
      up_hl_width <= 'd0;
      up_hs_width <= 'd0;
      up_he_max <= 'd0;
      up_he_min <= 'd0;
      up_vf_active <= 'd0;
      up_vf_width <= 'd0;
      up_vs_width <= 'd0;
      up_ve_max <= 'd0;
      up_ve_min <= 'd0;
    end else begin
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h002)) begin
        up_scratch <= up_wdata;
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h010)) begin
        up_resetn <= up_wdata[0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h011)) begin
        up_full_range <= up_wdata[1];
        up_csc_bypass <= up_wdata[0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h012)) begin
        up_srcsel <= up_wdata[1:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h013)) begin
        up_const_rgb <= up_wdata[23:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h100)) begin
        up_hl_active <= up_wdata[31:16];
        up_hl_width <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h101)) begin
        up_hs_width <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h102)) begin
        up_he_max <= up_wdata[31:16];
        up_he_min <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h110)) begin
        up_vf_active <= up_wdata[31:16];
        up_vf_width <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h111)) begin
        up_vs_width <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h112)) begin
        up_ve_max <= up_wdata[31:16];
        up_ve_min <= up_wdata[15:0];
      end
    end
  end

  // processor read interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_ack <= 'd0;
      up_rdata <= 'd0;
    end else begin
      up_ack <= up_sel_s;
      if (up_sel_s == 1'b1) begin
        case (up_addr[11:0])
          12'h000: up_rdata <= PCORE_VERSION;
          12'h001: up_rdata <= PCORE_ID;
          12'h002: up_rdata <= up_scratch;
          12'h010: up_rdata <= {31'd0, up_resetn};
          12'h011: up_rdata <= {30'd0, up_full_range, up_csc_bypass};
          12'h012: up_rdata <= {30'd0, up_srcsel};
          12'h013: up_rdata <= {8'd0, up_const_rgb};
          12'h015: up_rdata <= up_hdmi_clk_count;
          12'h016: up_rdata <= hdmi_clk_ratio;
          12'h017: up_rdata <= {31'd0, up_hdmi_status};
          12'h018: up_rdata <= {30'd0, up_vdma_ovf, up_vdma_unf};
          12'h019: up_rdata <= {30'd0, up_hdmi_tpm_oos, up_vdma_tpm_oos};
          12'h100: up_rdata <= {up_hl_active, up_hl_width};
          12'h101: up_rdata <= {16'd0, up_hs_width};
          12'h102: up_rdata <= {up_he_max, up_he_min};
          12'h110: up_rdata <= {up_vf_active, up_vf_width};
          12'h111: up_rdata <= {16'd0, up_vs_width};
          12'h112: up_rdata <= {up_ve_max, up_ve_min};
          default: up_rdata <= 0;
        endcase
      end else begin
        up_rdata <= 32'd0;
      end
    end
  end

  // common xfer toggle (where no enable or start is available)

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_xfer_toggle <= 'd0;
    end else begin
      if (up_count[5:0] == 6'd0) begin
        up_xfer_toggle <= ~up_xfer_toggle;
      end
    end
  end

  // HDMI CONTROL

  FDPE #(.INIT(1'b1)) i_hdmi_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_preset_s),
    .C (hdmi_clk),
    .Q (hdmi_rst));

  // hdmi control transfer

  assign hdmi_up_xfer_toggle_s = hdmi_up_xfer_toggle_m3 ^ hdmi_up_xfer_toggle_m2;

  always @(posedge hdmi_clk) begin
    if (hdmi_rst == 1'b1) begin
      hdmi_up_xfer_toggle_m1 <= 'd0;
      hdmi_up_xfer_toggle_m2 <= 'd0;
      hdmi_up_xfer_toggle_m3 <= 'd0;
    end else begin
      hdmi_up_xfer_toggle_m1 <= up_xfer_toggle;
      hdmi_up_xfer_toggle_m2 <= hdmi_up_xfer_toggle_m1;
      hdmi_up_xfer_toggle_m3 <= hdmi_up_xfer_toggle_m2;
    end
    if (hdmi_up_xfer_toggle_s == 1'b1) begin
      hdmi_full_range <= up_full_range;
      hdmi_csc_bypass <= up_csc_bypass;
      hdmi_srcsel <= up_srcsel;
      hdmi_const_rgb <= up_const_rgb;
      hdmi_hl_active <= up_hl_active;
      hdmi_hl_width <= up_hl_width;
      hdmi_hs_width <= up_hs_width;
      hdmi_he_max <= up_he_max;
      hdmi_he_min <= up_he_min;
      hdmi_vf_active <= up_vf_active;
      hdmi_vf_width <= up_vf_width;
      hdmi_vs_width <= up_vs_width;
      hdmi_ve_max <= up_ve_max;
      hdmi_ve_min <= up_ve_min;
    end
  end

  // hdmi status transfer

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_hdmi_status_m1 <= 'd0;
      up_hdmi_status <= 'd0;
      up_hdmi_tpm_oos_m1 <= 'd0;
      up_hdmi_tpm_oos_m2 <= 'd0;
      up_hdmi_tpm_oos <= 1'b0;
    end else begin
      up_hdmi_status_m1 <= hdmi_status;
      up_hdmi_status <= up_hdmi_status_m1;
      up_hdmi_tpm_oos_m1 <= hdmi_tpm_oos;
      up_hdmi_tpm_oos_m2 <= up_hdmi_tpm_oos_m1;
      if (up_hdmi_tpm_oos_m2 == 1'b1) begin
        up_hdmi_tpm_oos <= 1'b1;
      end else if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h019)) begin
        up_hdmi_tpm_oos <= up_hdmi_tpm_oos & ~up_wdata[1];
      end
    end
  end

  // processor base reference

  assign up_count_toggle_s = up_count_toggle_m3 ^ up_count_toggle_m2;

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_count_toggle_m1 <= 'd0;
      up_count_toggle_m2 <= 'd0;
      up_count_toggle_m3 <= 'd0;
      up_count_toggle <= 'd0;
      up_count <= 'd0;
      up_hdmi_clk_count <= 'd0;
    end else begin
      up_count_toggle_m1 <= hdmi_clk_count_toggle;
      up_count_toggle_m2 <= up_count_toggle_m1;
      up_count_toggle_m3 <= up_count_toggle_m2;
      if (up_count == 16'd0) begin
        up_count_toggle <= ~up_count_toggle;
      end
      up_count <= up_count + 1'b1;
      if (up_count_toggle_s == 1'b1) begin
        up_hdmi_clk_count <= hdmi_clk_count_hold;
      end
    end
  end

  // measuring clock

  assign hdmi_clk_count_toggle_s = hdmi_clk_count_toggle_m3 ^ hdmi_clk_count_toggle_m2;

  always @(posedge hdmi_clk) begin
    if (hdmi_rst == 1'b1) begin
      hdmi_clk_count_toggle_m1 <= 'd0;
      hdmi_clk_count_toggle_m2 <= 'd0;
      hdmi_clk_count_toggle_m3 <= 'd0;
    end else begin
      hdmi_clk_count_toggle_m1 <= up_count_toggle;
      hdmi_clk_count_toggle_m2 <= hdmi_clk_count_toggle_m1;
      hdmi_clk_count_toggle_m3 <= hdmi_clk_count_toggle_m2;
    end
    if (hdmi_clk_count_toggle_s == 1'b1) begin
      hdmi_clk_count_toggle <= ~hdmi_clk_count_toggle;
      hdmi_clk_count_hold <= hdmi_clk_count[31:0];
    end
    if (hdmi_clk_count_toggle_s == 1'b1) begin
      hdmi_clk_count <= 33'd1;
    end else if (hdmi_clk_count[32] == 1'b0) begin
      hdmi_clk_count <= hdmi_clk_count + 1'b1;
    end else begin
      hdmi_clk_count <= {33{1'b1}};
    end
  end

  // VDMA CONTROL

  FDPE #(.INIT(1'b1)) i_vdma_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_preset_s),
    .C (vdma_clk),
    .Q (vdma_rst));

  // vdma status transfer

  always @(posedge vdma_clk) begin
    vdma_xfer_cnt <= vdma_xfer_cnt + 1'b1;
    if (vdma_xfer_cnt == 6'd0) begin
      vdma_xfer_toggle <= ~vdma_xfer_toggle;
      vdma_xfer_ovf <= vdma_acc_ovf;
      vdma_xfer_unf <= vdma_acc_unf;
    end
    if (vdma_xfer_cnt == 6'd0) begin
      vdma_acc_ovf <= vdma_ovf;
      vdma_acc_unf <= vdma_unf;
    end else begin
      vdma_acc_ovf <= vdma_acc_ovf | vdma_ovf;
      vdma_acc_unf <= vdma_acc_unf | vdma_unf;
    end
  end

  assign up_vdma_xfer_toggle_s = up_vdma_xfer_toggle_m2 ^ up_vdma_xfer_toggle_m3;

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_vdma_xfer_toggle_m1 <= 'd0;
      up_vdma_xfer_toggle_m2 <= 'd0;
      up_vdma_xfer_toggle_m3 <= 'd0;
      up_vdma_xfer_ovf <= 'd0;
      up_vdma_xfer_unf <= 'd0;
      up_vdma_ovf <= 'd0;
      up_vdma_unf <= 'd0;
    end else begin
      up_vdma_xfer_toggle_m1 <= vdma_xfer_toggle;
      up_vdma_xfer_toggle_m2 <= up_vdma_xfer_toggle_m1;
      up_vdma_xfer_toggle_m3 <= up_vdma_xfer_toggle_m2;
      if (up_vdma_xfer_toggle_s == 1'b1) begin
        up_vdma_xfer_ovf <= vdma_xfer_ovf;
        up_vdma_xfer_unf <= vdma_xfer_unf;
      end
      if (up_vdma_xfer_ovf == 1'b1) begin
        up_vdma_ovf <= 1'b1;
      end else if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h018)) begin
        up_vdma_ovf <= up_vdma_ovf & ~up_wdata[1];
      end
      if (up_vdma_xfer_unf == 1'b1) begin
        up_vdma_unf <= 1'b1;
      end else if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h018)) begin
        up_vdma_unf <= up_vdma_unf & ~up_wdata[0];
      end
    end
  end

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_vdma_tpm_oos_m1 <= 'd0;
      up_vdma_tpm_oos_m2 <= 'd0;
      up_vdma_tpm_oos <= 1'b0;
    end else begin
      up_vdma_tpm_oos_m1 <= vdma_tpm_oos;
      up_vdma_tpm_oos_m2 <= up_vdma_tpm_oos_m1;
      if (up_vdma_tpm_oos_m2 == 1'b1) begin
        up_vdma_tpm_oos <= 1'b1;
      end else if ((up_wr_s == 1'b1) && (up_addr[11:0] == 12'h019)) begin
        up_vdma_tpm_oos <= up_vdma_tpm_oos & ~up_wdata[0];
      end
    end
  end

endmodule

// ***************************************************************************
// ***************************************************************************
