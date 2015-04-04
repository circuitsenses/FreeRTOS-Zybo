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

`timescale 1ns/100ps

module cf_jesd_align_2 (

  // jesd interface

  rx_clk,
  rx_sof,
  rx_eof,
  rx_ferr,
  rx_fdata,

  // aligned data

  rx_err,
  rx_data);

  // jesd interface

  input           rx_clk;
  input   [ 3:0]  rx_sof;
  input   [ 3:0]  rx_eof;
  input   [ 3:0]  rx_ferr;
  input   [31:0]  rx_fdata;

  // aligned data

  output          rx_err;
  output  [31:0]  rx_data;

  reg     [ 7:0]  rx_fdata_d = 'd0;
  reg             rx_err = 'd0;
  reg     [31:0]  rx_data = 'd0;
 
  wire    [ 3:0]  rx_eof_s;
  wire            rx_err_s;

  // error conditions- sof & eof are mutually exclusive - xor should always be 4'b1111.
  // if there are frame errors - the xor will result in values other than 4'hf.

  assign rx_eof_s = ~rx_eof;
  assign rx_err_s = ((rx_sof == rx_eof_s) && (rx_ferr == 4'd0)) ? 1'b0 : 1'b1;

  // 2 bytes per frame - so only 2 combinations

  always @(posedge rx_clk) begin
    rx_fdata_d <= rx_fdata[31:24];
    case (rx_sof)
      4'b0101: begin
        rx_err <= rx_err_s;
        rx_data <= rx_fdata;
      end
      4'b1010: begin
        rx_err <= rx_err_s;
        rx_data <= {rx_fdata[23:0], rx_fdata_d};
      end
      default: begin
        rx_err <= 1'b1;
        rx_data <= 32'hffff;
      end
    endcase
  end

endmodule

// ***************************************************************************
// ***************************************************************************
