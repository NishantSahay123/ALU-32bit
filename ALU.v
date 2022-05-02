`define WIDTH 32
//ARITHMETIC AND LOGICAL UNIT

//MODULE ADDITION
module add(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //addition operation
  assign f = a + b;
endmodule
	
//MODULE ADDITION WITH CARRY
module add_with_carry(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //addtion operation with carry
  assign f = a + b + 1;
endmodule
	
//MODULE SUBTRACTION
module subtract(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //subtraction operation
  assign f = a - b;
endmodule
	
//MODULE SUBTRACTION WITH BORROW
module sub_with_borrow(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //subtracition operation with borrow
  assign f = a - b - 1;
endmodule
	
//MODULE INCREMENTATION
module increment(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //increment operation
  assign f = a + 1;
endmodule
	
//MODULE DECREMENTATION
module decrement(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //decrement operation
  assign f = a - 1;
endmodule
	
//MODULE TRANSFER
module transfer(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //tranfer operation
  assign f = a;
endmodule
	
//MODULE ARITHMETIC UNIT
module arithmetic_unit(
  input      [`WIDTH - 1:0]  a,b,
  input      [2:0]           sel,
  output reg [`WIDTH - 1:0]  f);
  
  wire       [`WIDTH - 1:0]  w1,w2,w3,w4,w5,w6,w7;
	
  //module port instantiation
  add             A1(a,b,w1);
  add_with_carry  A2(a,b,w2);
  subtract        A3(a,b,w3);
  sub_with_borrow A4(a,b,w4);
  increment       A5(a,w5);
  decrement       A6(a,w6);
  transfer        A7(a,w7);

  //output selection based on control signal	
  always @ (*) begin
  case(sel)
	3'b000  : f <= w1;
	3'b001  : f <= w2;
	3'b010  : f <= w3;
	3'b011  : f <= w4;
	3'b100  : f <= w5;
	3'b101  : f <= w6;
	3'b110  : f <= w7;
	default : f <=  0;
  endcase
  end
  
endmodule

////////////////////LOGIC UNIT////////////////////////////////

//AND MODULE
module and_4(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //lgical AND operation
  assign f = a & b;
endmodule

//OR MODULE
module or_4(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //logical OR operation
  assign f = a | b;
endmodule

//XOR MODULE	
module xor_4(
  input  [`WIDTH - 1:0] a,b,
  output [`WIDTH - 1:0] f);
  
  //logical XOR operation
  assign f = a ^ b;
endmodule

//NOT MODULE
module not_4(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //logical NOT operation
  assign f = ~a;
endmodule

//LOGIC UNIT MODULE 
module logic_unit(
  input      [`WIDTH - 1:0] a,b,
  input      [1:0]          sel,
  output reg [`WIDTH - 1:0] f);
  wire       [`WIDTH - 1:0] w1,w2,w3,w4;
	
  //module port instantiation
  and_4 A1 (a,b,w1);
  or_4  O1 (a,b,w2);
  xor_4 X1 (a,b,w3);  
  not_4 N1 (a,w4);

  //output selection based on control signal	
  always @ (*) begin
  case (sel)
	2'b00   : f <= w1;
	2'b01   : f <= w2;
	2'b10   : f <= w3;
	2'b11   : f <= w4;
	default : f <= 0;
  endcase
  end
  
endmodule
	
////////////////////SHIFT UNIT////////////////////////////////

//MODULE LEFT SHIFT
module left_shift(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //left shift operation
  assign f = a<<2;
endmodule
	
//MODULE RIGHT SHIFT
module right_shift(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //right shift operation
  assign f = a>>2;
endmodule
	
//MODULE LEFT ARITHMETIC SHIFT
module left_arth_shift(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //arithmetic left shift operation
  assign f = a<<<2;
endmodule
	
//MODULE RIGHT ARITHMETIC SHIFT
module right_arth_shift(
  input  [`WIDTH - 1:0] a,
  output [`WIDTH - 1:0] f);
  
  //arithemtic right shift operation
  assign f = a>>>2;
endmodule
	
//MODULE SHIFT UNIT
module shift_unit(
  input      [`WIDTH - 1:0] a,
  input      [1:0]          sel,
  output reg [`WIDTH - 1:0] f);
  wire       [`WIDTH - 1:0] w1,w2,w3,w4;
	
  //module port instantiation
  left_shift       L1(a,w1);
  right_shift      R1(a,w2);
  left_arth_shift  L2(a,w3);
  right_arth_shift R2(a,w4);

  //output selection based on control signal
  always @ (*) begin
  case(sel)
	2'b00 : f <= w1;
	2'b01 : f <= w2;
	2'b10 : f <= w3;
	2'b11 : f <= w4;
  endcase
  end
  
endmodule
	
////////////////////ARITHMETIC & LOGICAL UNIT////////////////////////////////

module ALU(
  input      [`WIDTH - 1:0] a,b,
  input      [4:0]          sel,
  output reg [`WIDTH - 1:0] f);
  wire       [`WIDTH - 1:0] w1,w2,w3;

  //module port instantion	
  arithmetic_unit A1(a,b,{sel[0],sel[1],sel[2]},w1);
  logic_unit      A2(a,b,{sel[0],sel[1]},w2);
  shift_unit      A3(a,{sel[0],sel[1]},w3);

  //utput selection based on control signal
  always @ (*) begin
  case({sel[3],sel[4]})
	2'b00   : f <= w1;
	2'b01   : f <= w2;
	2'b10   : f <= w3;
	default : f <= 0;
  endcase
  end
  
endmodule
	