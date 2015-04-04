--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.2 (win64) Build 932637 Wed Jun 11 13:33:10 MDT 2014
--Date        : Fri Apr 03 18:29:46 2015
--Host        : Admin-PC running 64-bit major release  (build 7600)
--Command     : generate_target system_wrapper.bd
--Design      : system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_wrapper is
  port (
    AC_BCLK : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_MCLK : out STD_LOGIC;
    AC_MUTE_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_PBLRC : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_RECLRC : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_SDATA_I : in STD_LOGIC;
    AC_SDATA_O : out STD_LOGIC_VECTOR ( 0 to 0 );
    BLUE_O : out STD_LOGIC_VECTOR ( 4 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    GREEN_O : out STD_LOGIC_VECTOR ( 5 downto 0 );
    HDMI_CLK_N : out STD_LOGIC;
    HDMI_CLK_P : out STD_LOGIC;
    HDMI_D0_N : out STD_LOGIC;
    HDMI_D0_P : out STD_LOGIC;
    HDMI_D1_N : out STD_LOGIC;
    HDMI_D1_P : out STD_LOGIC;
    HDMI_D2_N : out STD_LOGIC;
    HDMI_D2_P : out STD_LOGIC;
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
    HSYNC_O : out STD_LOGIC;
    RED_O : out STD_LOGIC_VECTOR ( 4 downto 0 );
    VSYNC_O : out STD_LOGIC;
    btns_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    iic_0_scl_io : inout STD_LOGIC;
    iic_0_sda_io : inout STD_LOGIC;
    rtosleds : out STD_LOGIC_VECTOR ( 3 downto 0 );
    sws_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
end system_wrapper;

architecture STRUCTURE of system_wrapper is
  component system is
  port (
    BTNs_4Bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    IIC_0_sda_i : in STD_LOGIC;
    IIC_0_sda_o : out STD_LOGIC;
    IIC_0_sda_t : out STD_LOGIC;
    IIC_0_scl_i : in STD_LOGIC;
    IIC_0_scl_o : out STD_LOGIC;
    IIC_0_scl_t : out STD_LOGIC;
    SWs_4Bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    AC_SDATA_I : in STD_LOGIC;
    BLUE_O : out STD_LOGIC_VECTOR ( 4 downto 0 );
    GREEN_O : out STD_LOGIC_VECTOR ( 5 downto 0 );
    HSYNC_O : out STD_LOGIC;
    RED_O : out STD_LOGIC_VECTOR ( 4 downto 0 );
    VSYNC_O : out STD_LOGIC;
    AC_BCLK : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_PBLRC : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_RECLRC : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_MUTE_N : out STD_LOGIC_VECTOR ( 0 to 0 );
    AC_SDATA_O : out STD_LOGIC_VECTOR ( 0 to 0 );
    HDMI_CLK_N : out STD_LOGIC;
    HDMI_CLK_P : out STD_LOGIC;
    HDMI_D0_N : out STD_LOGIC;
    HDMI_D0_P : out STD_LOGIC;
    HDMI_D1_N : out STD_LOGIC;
    HDMI_D1_P : out STD_LOGIC;
    HDMI_D2_N : out STD_LOGIC;
    HDMI_D2_P : out STD_LOGIC;
    AC_MCLK : out STD_LOGIC;
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
    rtosleds : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component system;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal iic_0_scl_i : STD_LOGIC;
  signal iic_0_scl_o : STD_LOGIC;
  signal iic_0_scl_t : STD_LOGIC;
  signal iic_0_sda_i : STD_LOGIC;
  signal iic_0_sda_o : STD_LOGIC;
  signal iic_0_sda_t : STD_LOGIC;
begin
iic_0_scl_iobuf: component IOBUF
    port map (
      I => iic_0_scl_o,
      IO => iic_0_scl_io,
      O => iic_0_scl_i,
      T => iic_0_scl_t
    );
iic_0_sda_iobuf: component IOBUF
    port map (
      I => iic_0_sda_o,
      IO => iic_0_sda_io,
      O => iic_0_sda_i,
      T => iic_0_sda_t
    );
system_i: component system
    port map (
      AC_BCLK(0) => AC_BCLK(0),
      AC_MCLK => AC_MCLK,
      AC_MUTE_N(0) => AC_MUTE_N(0),
      AC_PBLRC(0) => AC_PBLRC(0),
      AC_RECLRC(0) => AC_RECLRC(0),
      AC_SDATA_I => AC_SDATA_I,
      AC_SDATA_O(0) => AC_SDATA_O(0),
      BLUE_O(4 downto 0) => BLUE_O(4 downto 0),
      BTNs_4Bits_tri_i(3 downto 0) => btns_4bits_tri_i(3 downto 0),
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      GREEN_O(5 downto 0) => GREEN_O(5 downto 0),
      HDMI_CLK_N => HDMI_CLK_N,
      HDMI_CLK_P => HDMI_CLK_P,
      HDMI_D0_N => HDMI_D0_N,
      HDMI_D0_P => HDMI_D0_P,
      HDMI_D1_N => HDMI_D1_N,
      HDMI_D1_P => HDMI_D1_P,
      HDMI_D2_N => HDMI_D2_N,
      HDMI_D2_P => HDMI_D2_P,
      HDMI_OEN(0) => HDMI_OEN(0),
      HSYNC_O => HSYNC_O,
      IIC_0_scl_i => iic_0_scl_i,
      IIC_0_scl_o => iic_0_scl_o,
      IIC_0_scl_t => iic_0_scl_t,
      IIC_0_sda_i => iic_0_sda_i,
      IIC_0_sda_o => iic_0_sda_o,
      IIC_0_sda_t => iic_0_sda_t,
      RED_O(4 downto 0) => RED_O(4 downto 0),
      SWs_4Bits_tri_i(3 downto 0) => sws_4bits_tri_i(3 downto 0),
      VSYNC_O => VSYNC_O,
      rtosleds(3 downto 0) => rtosleds(3 downto 0)
    );
end STRUCTURE;
