`timescale 1ns/1ps
/*******************************************************************************
 * File Name:		VerilogCSP.v - renamed to macros.v by Mallika Prakash
 * Written by:		Arash Saifhashemi, saifhash[at]usc[dot]edu
 * Last update:		March 22, 2006 - Rev. 1.1, added Probe [pab] 
 *				April 01, 2006 - Rev. 1.2, added SEND_REQ and RECEIVE_REQ (mallika)
 *
 * 		USC Asynchronous CAD/VLSI group: http://jungfrau.usc.edu/
 ******************************************************************************/

`ifdef __CHAN_DEF__
`else
 //Change the values of the following macros to set the delay of Send and Receive
   `define DEF_SEND_DEL      1
   `define DEF_RECEIVE_DEL   1

	`define __CHAN_DEF__
	
	`define SEND(_prt_,_value_)    begin\
	   #`DEF_SEND_DEL;\
		force _prt_={_value_,_prt_[1],1'b1};\
		wait (_prt_[1]==1'b1);\
		force _prt_={_value_,_prt_[1],1'b0};\
		wait (_prt_[1]==1'b0);\
		#0;\
	end
 
	`define RECEIVE(_prt_,_value_)    begin\
      #`DEF_RECEIVE_DEL;\
		wait (_prt_[0]==1'b1);\
		{_value_,dummy}=_prt_;\
		force _prt_[1]=1'b1;\
		wait (_prt_[0]==1'b0);\
		force _prt_[1]=1'b0;\
		#0;\
	end

	`define SEND_REQ(_prt_)    begin\
	#`DEF_SEND_DEL;\
		force _prt_[0]=1'b1;\
		wait (_prt_[1]==1'b1);\
		force _prt_[0]=1'b0;\
		wait (_prt_[1]==1'b0);\
		#0;\
	end
 
	`define RECEIVE_REQ(_prt_)    begin\
      #`DEF_RECEIVE_DEL;\
		wait (_prt_[0]==1'b1);\
		force _prt_[1]=1'b1;\
		wait (_prt_[0]==1'b0);\
		force _prt_[1]=1'b0;\
		#0;\
	end	

	`define PROBE(_prt_)   ( (_prt_[0]===1'bz)?1'b0:(_prt_[0]===1'bx)?1'b0:_prt_[0] )

	`define OUTPORT(_prt_,_lenght_) output[_lenght_+1:0] _prt_;
	
	`define INPORT(_prt_,_lenght_) input[_lenght_+1:0] _prt_;
  
	`define CHANNEL(_ch_,_lenght_) wire [_lenght_+1:0] _ch_;
	
	`define USES_CHANNEL reg [1:0] dummy; 
	
	`define INPUT(_mod_,_modPrt_,_actPrt_, _width_, _slack_, _BL_, _FL_)	input[_width_+1:0] _modPrt_;\
		wire [_width_+1:0] _actPrt_;\
		port	 #(_width_, _slack_, _BL_, _FL_) _mod_ (_modPrt_, _actPrt_);
		
	`define OUTPUT(_mod_,_modPrt_,_actPrt_, _width_, _slack_, _BL_, _FL_)	output[_width_+1:0] _modPrt_;\
		wire [_width_+1:0] _actPrt_;\
		port	 #(_width_,_slack_, _BL_, _FL_) _mod_ (_actPrt_, _modPrt_);
	
`endif