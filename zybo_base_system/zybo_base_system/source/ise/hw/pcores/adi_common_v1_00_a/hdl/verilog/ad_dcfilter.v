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
// dc filter- y(n) = c*x(n) + (1-c)*y(n-1)

`timescale 1ps/1ps

module ad_dcfilter (

  // data interface

  clk,
  valid,
  data,
  valid_out,
  data_out,

  // control interface

  dcfilt_enb,
  dcfilt_coeff,
  dcfilt_offset);

  // data interface

  input           clk;
  input           valid;
  input   [15:0]  data;
  output          valid_out;
  output  [15:0]  data_out;

  // control interface

  input           dcfilt_enb;
  input   [15:0]  dcfilt_coeff;
  input   [15:0]  dcfilt_offset;

  // internal registers

  reg     [15:0]  dc_offset = 'd0;
  reg     [32:0]  dc_offset_33 = 'd0;
  reg             valid_d = 'd0;
  reg     [15:0]  data_d = 'd0;
  reg             valid_out = 'd0;
  reg     [15:0]  data_out = 'd0;

  // internal signals

  wire    [32:0]  dc_offset_33_s;

  // cancelling the dc offset

  always @(posedge clk) begin
    dc_offset <= dc_offset_33_s[32:17];
    dc_offset_33 <= dc_offset_33_s;
    valid_d <= valid;
    if (valid == 1'b1) begin
      data_d <= data + dcfilt_offset;
    end
    if (dcfilt_enb == 1'b1) begin
      valid_out <= valid_d;
      data_out <= data_d - dc_offset;
    end else begin
      valid_out <= valid_d;
      data_out <= data_d;
    end
  end

  ad_dcfilter_1 i_dcfilter_1 (
    .clk (clk),
    .d (data_d),
    .b (dcfilt_coeff),
    .a (dc_offset_33[32:17]),
    .c (dc_offset_33[32:17]),
    .p (dc_offset_33_s));

endmodule

// ***************************************************************************
// ***************************************************************************
