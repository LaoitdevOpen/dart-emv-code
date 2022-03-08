import 'package:emvqrcode/src/crc16/crc_model.dart';

class CRC {
  get crc16Arc => Params(poly: 0x8005,init: 0x0000,refIn: true,refOut: true,xorOut: 0x0000,check: 0xBB3D,name: "CRC-16/ARC");
  get crc16AugCcitt => Params(poly: 0x1021,init: 0x1D0F,refIn: false,refOut: false,xorOut: 0x0000,check: 0xE5CC,name: "CRC-16/AUG-CCITT");
  get crc16Buypass => Params(poly: 0x8005,init: 0x0000,refIn: false,refOut: false,xorOut: 0x0000,check: 0xFEE8,name: "CRC-16/BUYPASS");
  get crc16CcittFalse => Params(poly: 0x1021,init: 0xFFFF,refIn: false,refOut: false,xorOut: 0x0000,check: 0x29B1,name: "CRC-16/CCITT-FALSE");
  get crc16Cdma2000 => Params(poly: 0xC867,init: 0xFFFF,refIn: false,refOut: false,xorOut: 0x0000,check: 0x4C06,name: "CRC-16/CDMA2000");
  get crc16Dds110 => Params(poly: 0x8005, init: 0x800D,refIn: false,refOut: false,xorOut: 0x0000,check: 0x9ECF, name: "CRC-16/DDS-110");
  get crc16DectR => Params(poly: 0x0589,init: 0x0000,refIn: false,refOut: false,xorOut: 0x0001,check: 0x007E,name: "CRC-16/DECT-R");
	get crc16DectX => Params(poly: 0x0589,init: 0x0000,refIn: false,refOut: false,xorOut: 0x0000,check:0x007F,name:  "CRC-16/DECT-X");
  get crc16Dnp => Params(poly: 0x3D65,init: 0x0000,refIn: true, refOut: true, xorOut: 0xFFFF,check: 0xEA82, name: "CRC-16/DNP");
	get crc15En13757 => Params(poly: 0x3D65,init: 0x0000,refIn: false,refOut: false,xorOut: 0xFFFF,check: 0xC2B7,name: "CRC-16/EN-13757");
	get crc16Genibus => Params(poly:0x1021,init:  0xFFFF,refIn: false, refOut: false,xorOut: 0xFFFF,check: 0xD64E,name: "CRC-16/GENIBUS");
  get crc16Maxim => Params(poly: 0x8005,init: 0x0000, refIn: true, refOut: true,xorOut: 0xFFFF,check: 0x44C2,name: "CRC-16/MAXIM");
	get crc16Mcrf4xx => Params(poly: 0x1021,init: 0xFFFF,refIn: true,refOut: true,xorOut: 0x0000,check: 0x6F91, name: "CRC-16/MCRF4XX");
  get crc16Riello => Params(poly: 0x1021,init: 0xB2AA,refIn: true,refOut: true,xorOut: 0x0000,check: 0x63D0,name:  "CRC-16/RIELLO");
	get crc16T10Dif => Params(poly:0x8BB7,init:  0x0000,refIn: false,refOut: false,xorOut:  0x0000,check: 0xD0DB,name: "CRC-16/T10-DIF");
	get crc16Teledisk => Params(poly: 0xA097,init: 0x0000,refIn: false, refOut: false,xorOut: 0x0000,check: 0x0FB3,name: "CRC-16/TELEDISK");
	get crc16Tms37157 => Params(poly: 0x1021, init: 0x89EC, refIn: true, refOut: true, xorOut: 0x0000,check: 0x26B1, name: "CRC-16/TMS37157");
	get crc16Usb => Params(poly :0x8005,init:  0xFFFF,refIn:  true,refOut:  true,xorOut:  0xFFFF,check:  0xB4C8,name:  "CRC-16/USB");
  get crc16CrcA => Params(poly:  0x1021,init:  0xC6C6,refIn:  true,refOut:  true,xorOut:  0x0000,check:  0xBF05,name:  "CRC-16/CRC-A");
	get crc16Kermit => Params(poly:  0x1021,init:  0x0000,refIn:  true,refOut:  true,xorOut:  0x0000,check:  0x2189,name:  "CRC-16/KERMIT");
	get crc16Modbus => Params(poly: 0x8005,init:  0xFFFF,refIn:  true,refOut:  true,xorOut:  0x0000,check:  0x4B37,name:  "CRC-16/MODBUS");
	get crc16X25 => Params(poly:  0x1021,init:  0xFFFF,refIn:  true,refOut:  true,xorOut:  0xFFFF,check:  0x906E,name:  "CRC-16/X-25");
	get crc16Xmodem => Params(poly:  0x1021,init:  0x0000,refIn:  false,refOut:  false,xorOut:  0x0000,check:  0x31C3,name:  "CRC-16/XMODEM");
	
}
