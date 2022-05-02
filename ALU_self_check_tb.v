`define WIDTH 32
//Self-checking ALU Testbench
module ALU_tb();
  
  //port direction
  reg  [`WIDTH - 1 : 0] a,b;
  reg  [4 : 0] 		  sel;
  wire [`WIDTH - 1 : 0] f; 
  
  //DUT port intantiation
  ALU DUT (.a(a),
		     .b(b),
		     .sel(sel),
		     .f(f));
		   
  //refernece model
  reg [`WIDTH - 1 : 0] f_exp;
  integer i_a, i_s, i_l; 
  
  //simulation run
  initial begin
  arithmetic_check({$random},{$random});
  logical_check({$random},{$random});
  shift_check({$random});
  #5 $finish;
  end
  
  //task for arithmetic checks
  task arithmetic_check (input [`WIDTH - 1 : 0] A_a, input [`WIDTH - 1 : 0] B_a);
  begin
   a = A_a;
	b = B_a; 
	sel[3] = 1'b0;
	sel[4] = 1'b0;
	
	//loop thorugh control signals	
	for (i_a=0; i_a<8; i_a=i_a+1) begin
	
		//set control signals
		{sel[0],sel[1],sel[2]} = i_a;
		f_exp = arithmetic_ref({sel[0],sel[1],sel[2]},A_a,B_a);
		#1;
		if (f_exp == f)
		$display("SUCCESS ; ALU output : %d , Reference output : %d, at %t",f,f_exp,$time);
		else
		$display("FAIL ; ALU output : %d , Reference output : %d, at %t",f,f_exp,$time);
		#5;		
	end//for end
	end//begin end
	
  endtask
  
  //function to run arithmetic operations
  function [`WIDTH-1:0] arithmetic_ref (input [2:0] a_ref, input [`WIDTH - 1 : 0] A_ra, input [`WIDTH - 1 : 0] B_ra);
  begin
	case(a_ref)
	3'b000  : arithmetic_ref = A_ra + B_ra;
	3'b001  : arithmetic_ref = A_ra + B_ra + 1;
	3'b010  : arithmetic_ref = A_ra - B_ra;
	3'b011  : arithmetic_ref = A_ra - B_ra - 1;
	3'b100  : arithmetic_ref = A_ra + 1;
	3'b101  : arithmetic_ref = A_ra - 1;
	3'b110  : arithmetic_ref = A_ra;
	default : arithmetic_ref = `WIDTH'd0;
	endcase
  end
  endfunction
    
  //task for logical check
  task logical_check (input [`WIDTH - 1 : 0] A_l, input [`WIDTH - 1 : 0] B_l);
  begin
   a = A_l;
	b = B_l;
	sel[3] = 1'b0;
	sel[4] = 1'b1;
	
	//loop thorugh control signals
	for (i_l=0; i_l<4; i_l=i_l+1) begin
	
		//set control signals
		{sel[0],sel[1]} = i_l;
		f_exp = logical_ref({sel[0],sel[1]},A_l,B_l);
		#1;
		if (f_exp == f)
		$display("SUCCESS; ALU output : %d , Reference output : %d, at %t",f,f_exp,$time);
		else
		$display("FAIL; ALU output : %d , Reference output : %d, at $t",f,f_exp,$time);
		#5;		
	end//for end
	end//begin end
	
  endtask
  
  //function to run logical operation
  function [`WIDTH-1:0] logical_ref (input [1:0] l_ref, input [`WIDTH - 1 : 0] A_rl, input [`WIDTH - 1 : 0] B_rl);
  begin
	case(l_ref)
	2'b00 : logical_ref = A_rl & B_rl;
	2'b01 : logical_ref = A_rl | B_rl;
	2'b10 : logical_ref = A_rl ^ B_rl;
	2'b11 : logical_ref = ~A_rl;
	endcase
	end
  endfunction
  
  //task for shift check
  task shift_check (input [`WIDTH - 1 : 0] A_s);
  begin
  
   a = A_s;
	sel[3] = 1'b1;
	sel[4] = 1'b0;
	
	//loop thorugh control signals
	for (i_s=0; i_s<4; i_s=i_s+1) begin
	
		//set control signals
		{sel[0],sel[1]} = i_s;
		f_exp = shift_ref({sel[0],sel[1]},A_s);
		#1;
		if (f_exp == f)
		$display("SUCCESS; ALU output : %d , Reference output : %d, at %t",f,f_exp,$time);
		else
		$display("FAIL; ALU output : %d , Reference output : %d, at %t",f,f_exp,$time);
		#5;		
	end//for end
	end//begin end
	
  endtask
  
  //function to run shift operation
  function [`WIDTH-1:0] shift_ref (input [1:0] s_ref, input [`WIDTH - 1 : 0] A_rs);
  begin
	case(s_ref)
	2'b00 : shift_ref = A_rs<<2;
	2'b01 : shift_ref = A_rs>>2;
	2'b10 : shift_ref = A_rs<<<2;
	2'b11 : shift_ref = A_rs>>>2;
	endcase
  end
  endfunction

endmodule
  