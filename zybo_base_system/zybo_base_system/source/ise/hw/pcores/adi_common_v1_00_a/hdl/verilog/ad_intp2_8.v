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
// all inputs are 2's complement

`timescale 1ps/1ps

module ad_intp2_8 (

  clk,
  data,

  // outputs

  intp2_0,
  intp2_1,
  intp2_2,
  intp2_3,
  intp2_4,
  intp2_5,
  intp2_6,
  intp2_7);

  input           clk;
  input   [15:0]  data;
  
  // outputs

  output  [15:0]  intp2_0;
  output  [15:0]  intp2_1;
  output  [15:0]  intp2_2;
  output  [15:0]  intp2_3;
  output  [15:0]  intp2_4;
  output  [15:0]  intp2_5;
  output  [15:0]  intp2_6;
  output  [15:0]  intp2_7;

  // internal registers

  reg     [15:0]  data_s0 = 'd0;
  reg     [15:0]  data_s1 = 'd0;
  reg     [15:0]  data_s2 = 'd0;
  reg     [15:0]  data_s3 = 'd0;
  reg     [15:0]  data_s4 = 'd0;
  reg     [15:0]  data_s5 = 'd0;
  reg     [15:0]  data_s6 = 'd0;
  reg     [15:0]  data_s7 = 'd0;
  reg     [15:0]  data_s8 = 'd0;
  reg     [15:0]  data_s9 = 'd0;

  // internal signals

  wire    [15:0]  intp2_0_s;
  wire    [15:0]  intp2_1_s;
  wire    [15:0]  intp2_2_s;
  wire    [15:0]  intp2_3_s;

  // delay registers

  always @(posedge clk) begin
    data_s0 <= data_s4;
    data_s1 <= data_s5;
    data_s2 <= data_s6;
    data_s3 <= data_s7;
    data_s4 <= data_s8;
    data_s5 <= data_s9;
    data_s6 <= intp2_0_s;
    data_s7 <= intp2_1_s;
    data_s8 <= intp2_2_s;
    data_s9 <= intp2_3_s;
  end

  // interpolators (stage-2)

  ad_mac_1 i_mac_1_0 (
    .clk (clk),
    .data_s0 (data_s0),
    .data_s1 (data_s1),
    .data_s2 (data_s2),
    .data_s3 (data_s3),
    .data_s4 (data_s4),
    .data_s5 (data_s5),
    .mac_data_0 (intp2_0),
    .mac_data_1 (intp2_1));

  // interpolators (stage-2)

  ad_mac_1 i_mac_1_1 (
    .clk (clk),
    .data_s0 (data_s1),
    .data_s1 (data_s2),
    .data_s2 (data_s3),
    .data_s3 (data_s4),
    .data_s4 (data_s5),
    .data_s5 (data_s6),
    .mac_data_0 (intp2_2),
    .mac_data_1 (intp2_3));

  // interpolators (stage-2)

  ad_mac_1 i_mac_1_2 (
    .clk (clk),
    .data_s0 (data_s2),
    .data_s1 (data_s3),
    .data_s2 (data_s4),
    .data_s3 (data_s5),
    .data_s4 (data_s6),
    .data_s5 (data_s7),
    .mac_data_0 (intp2_4),
    .mac_data_1 (intp2_5));

  // interpolators (stage-2)

  ad_mac_1 i_mac_1_3 (
    .clk (clk),
    .data_s0 (data_s3),
    .data_s1 (data_s4),
    .data_s2 (data_s5),
    .data_s3 (data_s6),
    .data_s4 (data_s7),
    .data_s5 (data_s8),
    .mac_data_0 (intp2_6),
    .mac_data_1 (intp2_7));

  // interpolators (stage-1)

  ad_intp2_4 i_intp2_4 (
    .clk (clk),
    .data (data),
    .intp2_0 (intp2_0_s),
    .intp2_1 (intp2_1_s),
    .intp2_2 (intp2_2_s),
    .intp2_3 (intp2_3_s));

endmodule

// ***************************************************************************
// ***************************************************************************
