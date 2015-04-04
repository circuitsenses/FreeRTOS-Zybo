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

module up_dac_common (

  // mmcm reset

  mmcm_rst,

  // dac interface

  dac_clk,
  dac_rst,
  dac_enable,
  dac_frame,
  dac_par_type,
  dac_par_enb,
  dac_r1_mode,
  dac_datafmt,
  dac_datasel,
  dac_datarate,
  dac_status,
  dac_clk_ratio,

  // drp interface

  drp_clk,
  drp_rst,
  drp_sel,
  drp_wr,
  drp_addr,
  drp_wdata,
  drp_rdata,
  drp_ack_t,

  // vdma interface

  vdma_clk,
  vdma_rst,
  vdma_frmcnt,
  vdma_ovf,
  vdma_unf,

  // user channel control

  up_usr_chanmax,
  dac_usr_chanmax,

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

  // mmcm reset

  output          mmcm_rst;

  // dac interface

  input           dac_clk;
  output          dac_rst;
  output          dac_enable;
  output          dac_frame;
  output          dac_par_type;
  output          dac_par_enb;
  output          dac_r1_mode;
  output          dac_datafmt;
  output  [ 3:0]  dac_datasel;
  output  [ 7:0]  dac_datarate;
  input           dac_status;
  input   [31:0]  dac_clk_ratio;

  // drp interface

  input           drp_clk;
  output          drp_rst;
  output          drp_sel;
  output          drp_wr;
  output  [11:0]  drp_addr;
  output  [15:0]  drp_wdata;
  input   [15:0]  drp_rdata;
  input           drp_ack_t;

  // vdma interface

  input           vdma_clk;
  output          vdma_rst;
  output  [31:0]  vdma_frmcnt;
  input           vdma_ovf;
  input           vdma_unf;

  // user channel control

  output  [ 7:0]  up_usr_chanmax;
  input   [ 7:0]  dac_usr_chanmax;

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
  reg             up_mmcm_resetn = 'd0;
  reg             up_resetn = 'd0;
  reg             up_dac_enable = 'd0;
  reg             up_dac_par_type = 'd0;
  reg             up_dac_par_enb = 'd0;
  reg             up_dac_r1_mode = 'd0;
  reg             up_dac_datafmt = 'd0;
  reg     [ 3:0]  up_dac_datasel = 'd0;
  reg     [ 7:0]  up_dac_datarate = 'd0;
  reg             up_dac_frame = 'd0;
  reg             up_drp_sel_t = 'd0;
  reg             up_drp_rwn = 'd0;
  reg     [11:0]  up_drp_addr = 'd0;
  reg     [15:0]  up_drp_wdata = 'd0;
  reg     [31:0]  up_vdma_frmcnt = 'd0;
  reg     [ 7:0]  up_usr_chanmax = 'd0;
  reg             up_ack = 'd0;
  reg     [31:0]  up_rdata = 'd0;
  reg             up_xfer_toggle = 'd0;
  reg             dac_up_xfer_toggle_m1 = 'd0;
  reg             dac_up_xfer_toggle_m2 = 'd0;
  reg             dac_up_xfer_toggle_m3 = 'd0;
  reg             dac_enable_m1 = 'd0;
  reg             dac_enable_m2 = 'd0;
  reg             dac_enable_m3 = 'd0;
  reg             dac_frame_m1 = 'd0;
  reg             dac_frame_m2 = 'd0;
  reg             dac_frame_m3 = 'd0;
  reg             dac_enable = 'd0;
  reg             dac_frame = 'd0;
  reg             dac_par_type = 'd0;
  reg             dac_par_enb = 'd0;
  reg             dac_r1_mode = 'd0;
  reg             dac_datafmt = 'd0;
  reg     [ 3:0]  dac_datasel = 'd0;
  reg     [ 7:0]  dac_datarate = 'd0;
  reg             up_dac_status_m1 = 'd0;
  reg             up_dac_status = 'd0;
  reg             up_count_toggle_m1 = 'd0;
  reg             up_count_toggle_m2 = 'd0;
  reg             up_count_toggle_m3 = 'd0;
  reg             up_count_toggle = 'd0;
  reg     [15:0]  up_count = 'd0;
  reg     [31:0]  up_dac_clk_count = 'd0;
  reg             dac_clk_count_toggle_m1 = 'd0;
  reg             dac_clk_count_toggle_m2 = 'd0;
  reg             dac_clk_count_toggle_m3 = 'd0;
  reg             dac_clk_count_toggle = 'd0;
  reg     [31:0]  dac_clk_count_hold = 'd0;
  reg     [32:0]  dac_clk_count = 'd0;
  reg             drp_sel_t_m1 = 'd0;
  reg             drp_sel_t_m2 = 'd0;
  reg             drp_sel_t_m3 = 'd0;
  reg             drp_sel = 'd0;
  reg             drp_wr = 'd0;
  reg     [11:0]  drp_addr = 'd0;
  reg     [15:0]  drp_wdata = 'd0;
  reg             up_drp_ack_t_m1 = 'd0;
  reg             up_drp_ack_t_m2 = 'd0;
  reg             up_drp_ack_t_m3 = 'd0;
  reg             up_drp_sel_t_d = 'd0;
  reg             up_drp_status = 'd0;
  reg     [15:0]  up_drp_rdata = 'd0;
  reg             vdma_up_xfer_toggle_m1 = 'd0;
  reg             vdma_up_xfer_toggle_m2 = 'd0;
  reg             vdma_up_xfer_toggle_m3 = 'd0;
  reg     [31:0]  vdma_frmcnt = 'd0;
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

  // internal signals

  wire            up_sel_s;
  wire            up_wr_s;
  wire            up_preset_s;
  wire            up_mmcm_preset_s;
  wire            up_count_toggle_s;
  wire            dac_up_xfer_toggle_s;
  wire            dac_clk_count_toggle_s;
  wire            drp_sel_t_s;
  wire            up_drp_ack_t_s;
  wire            up_drp_sel_t_s;
  wire            vdma_up_xfer_toggle_s;
  wire            up_vdma_xfer_toggle_s;

  // decode block select

  assign up_sel_s = (up_addr[13:8] == 6'h10) ? up_sel : 1'b0;
  assign up_wr_s = up_sel_s & up_wr;
  assign up_preset_s = ~up_resetn;
  assign up_mmcm_preset_s = ~up_mmcm_resetn;

  // processor write interface

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_scratch <= 'd0;
      up_mmcm_resetn <= 'd0;
      up_resetn <= 'd0;
      up_dac_enable <= 'd0;
      up_dac_par_type <= 'd0;
      up_dac_par_enb <= 'd0;
      up_dac_r1_mode <= 'd0;
      up_dac_datafmt <= 'd0;
      up_dac_datasel <= 'd0;
      up_dac_datarate <= 'd0;
      up_dac_frame <= 'd0;
      up_drp_sel_t <= 'd0;
      up_drp_rwn <= 'd0;
      up_drp_addr <= 'd0;
      up_drp_wdata <= 'd0;
      up_vdma_frmcnt <= 'd0;
      up_usr_chanmax <= 'd0;
    end else begin
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h02)) begin
        up_scratch <= up_wdata;
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h10)) begin
        up_mmcm_resetn <= up_wdata[1];
        up_resetn <= up_wdata[0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h11)) begin
        up_dac_enable <= up_wdata[0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h12)) begin
        up_dac_par_type <= up_wdata[7];
        up_dac_par_enb <= up_wdata[6];
        up_dac_r1_mode <= up_wdata[5];
        up_dac_datafmt <= up_wdata[4];
        up_dac_datasel <= up_wdata[3:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h13)) begin
        up_dac_datarate <= up_wdata[7:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h14)) begin
        up_dac_frame <= up_wdata[0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h1c)) begin
        up_drp_sel_t <= ~up_drp_sel_t;
        up_drp_rwn <= up_wdata[28];
        up_drp_addr <= up_wdata[27:16];
        up_drp_wdata <= up_wdata[15:0];
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h21)) begin
        up_vdma_frmcnt <= up_wdata;
      end
      if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h28)) begin
        up_usr_chanmax <= up_wdata[7:0];
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
        case (up_addr[7:0])
          8'h00: up_rdata <= PCORE_VERSION;
          8'h01: up_rdata <= PCORE_ID;
          8'h02: up_rdata <= up_scratch;
          8'h10: up_rdata <= {30'd0, up_mmcm_resetn, up_resetn};
          8'h11: up_rdata <= {31'd0, up_dac_enable};
          8'h12: up_rdata <= {24'd0, up_dac_par_type, up_dac_par_enb, up_dac_r1_mode,
                              up_dac_datafmt, up_dac_datasel};
          8'h13: up_rdata <= {24'd0, up_dac_datarate};
          8'h14: up_rdata <= {31'd0, up_dac_frame};
          8'h15: up_rdata <= up_dac_clk_count;
          8'h16: up_rdata <= dac_clk_ratio;
          8'h17: up_rdata <= {31'd0, up_dac_status};
          8'h1c: up_rdata <= {3'd0, up_drp_rwn, up_drp_addr, up_drp_wdata};
          8'h1d: up_rdata <= {15'd0, up_drp_status, up_drp_rdata};
          8'h21: up_rdata <= up_vdma_frmcnt;
          8'h22: up_rdata <= {30'd0, up_vdma_ovf, up_vdma_unf};
          8'h28: up_rdata <= {24'd0, dac_usr_chanmax};
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
      if (up_wr_s == 1'b1) begin
        up_xfer_toggle <= ~up_xfer_toggle;
      end
    end
  end

  // MMCM CONTROL

  FDPE #(.INIT(1'b1)) i_mmcm_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_mmcm_preset_s),
    .C (drp_clk),
    .Q (mmcm_rst));

  // DAC CONTROL

  FDPE #(.INIT(1'b1)) i_dac_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_preset_s),
    .C (dac_clk),
    .Q (dac_rst));

  // dac control transfer

  assign dac_up_xfer_toggle_s = dac_up_xfer_toggle_m3 ^ dac_up_xfer_toggle_m2;

  always @(posedge dac_clk) begin
    if (dac_rst == 1'b1) begin
      dac_up_xfer_toggle_m1 <= 'd0;
      dac_up_xfer_toggle_m2 <= 'd0;
      dac_up_xfer_toggle_m3 <= 'd0;
      dac_enable_m1 <= 'd0;
      dac_enable_m2 <= 'd0;
      dac_enable_m3 <= 'd0;
      dac_frame_m1 <= 'd0;
      dac_frame_m2 <= 'd0;
      dac_frame_m3 <= 'd0;
    end else begin
      dac_up_xfer_toggle_m1 <= up_xfer_toggle;
      dac_up_xfer_toggle_m2 <= dac_up_xfer_toggle_m1;
      dac_up_xfer_toggle_m3 <= dac_up_xfer_toggle_m2;
      dac_enable_m1 <= up_dac_enable;
      dac_enable_m2 <= dac_enable_m1;
      dac_enable_m3 <= dac_enable_m2;
      dac_frame_m1 <= up_dac_frame;
      dac_frame_m2 <= dac_frame_m1;
      dac_frame_m3 <= dac_frame_m2;
    end
    dac_enable <= dac_enable_m3;
    dac_frame <= dac_frame_m2 & ~dac_frame_m3;
    if (dac_up_xfer_toggle_s == 1'b1) begin
      dac_par_type <= up_dac_par_type;
      dac_par_enb <= up_dac_par_enb;
      dac_r1_mode <= up_dac_r1_mode;
      dac_datafmt <= up_dac_datafmt;
      dac_datasel <= up_dac_datasel;
      dac_datarate <= up_dac_datarate;
    end
  end

  // dac status transfer

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_dac_status_m1 <= 'd0;
      up_dac_status <= 'd0;
    end else begin
      up_dac_status_m1 <= dac_status;
      up_dac_status <= up_dac_status_m1;
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
      up_dac_clk_count <= 'd0;
    end else begin
      up_count_toggle_m1 <= dac_clk_count_toggle;
      up_count_toggle_m2 <= up_count_toggle_m1;
      up_count_toggle_m3 <= up_count_toggle_m2;
      if (up_count == 16'd0) begin
        up_count_toggle <= ~up_count_toggle;
      end
      up_count <= up_count + 1'b1;
      if (up_count_toggle_s == 1'b1) begin
        up_dac_clk_count <= dac_clk_count_hold;
      end
    end
  end

  // measuring clock

  assign dac_clk_count_toggle_s = dac_clk_count_toggle_m3 ^ dac_clk_count_toggle_m2;

  always @(posedge dac_clk) begin
    if (dac_rst == 1'b1) begin
      dac_clk_count_toggle_m1 <= 'd0;
      dac_clk_count_toggle_m2 <= 'd0;
      dac_clk_count_toggle_m3 <= 'd0;
    end else begin
      dac_clk_count_toggle_m1 <= up_count_toggle;
      dac_clk_count_toggle_m2 <= dac_clk_count_toggle_m1;
      dac_clk_count_toggle_m3 <= dac_clk_count_toggle_m2;
    end
    if (dac_clk_count_toggle_s == 1'b1) begin
      dac_clk_count_toggle <= ~dac_clk_count_toggle;
      dac_clk_count_hold <= dac_clk_count[31:0];
    end
    if (dac_clk_count_toggle_s == 1'b1) begin
      dac_clk_count <= 33'd1;
    end else if (dac_clk_count[32] == 1'b0) begin
      dac_clk_count <= dac_clk_count + 1'b1;
    end else begin
      dac_clk_count <= {33{1'b1}};
    end
  end

  // DRP CONTROL

  FDPE #(.INIT(1'b1)) i_drp_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_preset_s),
    .C (drp_clk),
    .Q (drp_rst));

  // drp control transfer

  assign drp_sel_t_s = drp_sel_t_m2 ^ drp_sel_t_m3;

  always @(posedge drp_clk) begin
    if (drp_rst == 1'b1) begin
      drp_sel_t_m1 <= 'd0;
      drp_sel_t_m2 <= 'd0;
      drp_sel_t_m3 <= 'd0;
    end else begin
      drp_sel_t_m1 <= up_drp_sel_t;
      drp_sel_t_m2 <= drp_sel_t_m1;
      drp_sel_t_m3 <= drp_sel_t_m2;
    end
    if (drp_sel_t_s == 1'b1) begin
      drp_sel <= 1'b1;
      drp_wr <= ~up_drp_rwn;
      drp_addr <= up_drp_addr;
      drp_wdata <= up_drp_wdata;
    end else begin
      drp_sel <= 1'b0;
      drp_wr <= 1'b0;
      drp_addr <= 12'd0;
      drp_wdata <= 16'd0;
    end
  end

  // drp status transfer

  assign up_drp_ack_t_s = up_drp_ack_t_m3 ^ up_drp_ack_t_m2;
  assign up_drp_sel_t_s = up_drp_sel_t ^ up_drp_sel_t_d;

  always @(negedge up_rstn or posedge up_clk) begin
    if (up_rstn == 0) begin
      up_drp_ack_t_m1 <= 'd0;
      up_drp_ack_t_m2 <= 'd0;
      up_drp_ack_t_m3 <= 'd0;
      up_drp_sel_t_d <= 'd0;
      up_drp_status <= 'd0;
      up_drp_rdata <= 'd0;
    end else begin
      up_drp_ack_t_m1 <= drp_ack_t;
      up_drp_ack_t_m2 <= up_drp_ack_t_m1;
      up_drp_ack_t_m3 <= up_drp_ack_t_m2;
      up_drp_sel_t_d <= up_drp_sel_t;
      if (up_drp_ack_t_s == 1'b1) begin
        up_drp_status <= 1'b0;
      end else if (up_drp_sel_t_s == 1'b1) begin
        up_drp_status <= 1'b1;
      end
      if (up_drp_ack_t_s == 1'b1) begin
        up_drp_rdata <= drp_rdata;
      end
    end
  end

  // VDMA CONTROL

  FDPE #(.INIT(1'b1)) i_dma_rst_reg (
    .CE (1'b1),
    .D (1'b0),
    .PRE (up_preset_s),
    .C (vdma_clk),
    .Q (vdma_rst));

  // vdma control transfer

  assign vdma_up_xfer_toggle_s = vdma_up_xfer_toggle_m3 ^ vdma_up_xfer_toggle_m2;

  always @(posedge vdma_clk) begin
    if (vdma_rst == 1'b1) begin
      vdma_up_xfer_toggle_m1 <= 'd0;
      vdma_up_xfer_toggle_m2 <= 'd0;
      vdma_up_xfer_toggle_m3 <= 'd0;
    end else begin
      vdma_up_xfer_toggle_m1 <= up_xfer_toggle;
      vdma_up_xfer_toggle_m2 <= vdma_up_xfer_toggle_m1;
      vdma_up_xfer_toggle_m3 <= vdma_up_xfer_toggle_m2;
    end
    if (vdma_up_xfer_toggle_s == 1'b1) begin
      vdma_frmcnt <= up_vdma_frmcnt;
    end
  end

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
      end else if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h22)) begin
        up_vdma_ovf <= up_vdma_ovf & ~up_wdata[1];
      end
      if (up_vdma_xfer_unf == 1'b1) begin
        up_vdma_unf <= 1'b1;
      end else if ((up_wr_s == 1'b1) && (up_addr[7:0] == 8'h22)) begin
        up_vdma_unf <= up_vdma_unf & ~up_wdata[0];
      end
    end
  end

endmodule

// ***************************************************************************
// ***************************************************************************
