// VerilogA for project_main_shared, testgen_PROJECT, veriloga
`include "constants.vams"
`include "disciplines.vams"

module testgen_PROJECT(spi_clk, spi_in, spi_clk_out, spi_en, spi_out, led);
input wire sys_clk, spi_out;
output wire spi_in, spi_clk_out, spi_en, led;


integer t = 0; //time keeping
integer d = 1;
integer clk = 0;
integer enable = 1;
integer clk_count = 0;
//																A																				B					            							   C		                             Corr
integer data[0:255] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,			0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,		 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
								       0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,1,			0,0,0,1,0,0,0,1,0,0,1,0,0,0,1,1,			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,		 0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,
								       1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,			0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1, 		 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
								       0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,			0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,		 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};

integer corr[0:67] = 	{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,			0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,			0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,		 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
integer output_data[0:67];


integer count_bits = 0, count_words = 0, count_adds = 0;

// generate spi_clk
always @(sys_clk) begin
	clk_count++;
	if (clk_count >= 100) begin
		spi_clk = !spi_clk;
		clk_count = 0;
	end
end

always @(posedge spi_clk) begin //   @ (cross(V(spi_clk) - vtrans, 1)) begin
  t = t + 1;
  
  if (enable == 0) begin
     
  	if (count_bits == 15) begin
   		count_bits = 0;	     

   		if (count_words == 3) begin
   	  	count_words = 0;
   
   			if (count_adds == 3) begin
      		count_adds = 0;
   			end else begin
       		count_adds = count_adds + 1;
   			end
   		end else begin
    		count_words = count_words + 1;
			end
  	end else begin
     	count_bits = count_bits + 1; 
    end
  end
end


always @(negedge spi_clk) begin //@ (cross(V(spi_clk) - vtrans, -1)) begin
  if (t <= 4) begin
     d = 0;
  end else begin
     d = data[count_adds*16*4 + count_words*16 + count_bits];
  end

  if (t == 5) enable = 0;
  if (t == 261) enable = 1;
  if (t == 271) enable = 0;

  if (t > 271 && t < 340) begin
  	output_data[67-i] = spi_out;
  	i++;
  end else if(t >= 340) begin
  	if (output_data = corr) led = 0'b1;	//{data[47:63], data[111:127], data[175:191], data[239:255]});
  end
end
  
	  

// update outputs
assign spi_in = d;
assign spi_clk_out = !enable && spi_clk;
assign spi_en = enable;

	//V(spi_in) <+ V(vdd) * transition(d, tdel, trise, tfall);
	//V(spi_clk_out) <+ V(vdd) * transition(!enable && clk, tdel, trise, tfall);
	//V(spi_en) <+ V(vdd) * transition(enable, tdel, trise, tfall);	
	


endmodule