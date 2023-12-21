module seven_seg(
    input [4:0] input_bits,
    output [6:0] disp
);

    reg [6:0] ans = 7'b1111111;
 
    always @*
    begin
        if (input_bits == 5'b10000) begin //a
            ans = 7'b0001000;
        end else if(input_bits == 5'b01000) begin //b
                ans = 7'b0000011;
          end else if(input_bits == 5'b11000) begin //c
                ans = 7'b1000110;
          end else if(input_bits == 5'b00100) begin //d
                ans = 7'b0100001;
          end else if(input_bits == 5'b10100) begin //e
                ans = 7'b0000110;
          end else if(input_bits == 5'b01100) begin //f
                ans = 7'b0001110;
          end else if(input_bits == 5'b11100) begin //g
                ans = 7'b1000010;
          end else if(input_bits == 5'b00010) begin //h
                ans = 7'b0001011;
          end else if(input_bits == 5'b10010) begin //i
                ans = 7'b1001111;
          end else if(input_bits == 5'b01010) begin //j
                ans = 7'b1100001;
          end else if(input_bits == 5'b11010) begin //k
                ans = 7'b0001010;
          end else if(input_bits == 5'b00110) begin //l
                ans = 7'b1000111;
          end else if(input_bits == 5'b10110) begin //m
                ans = 7'b1101010;
          end else if(input_bits == 5'b01110) begin //n
                ans = 7'b1001000;
          end else if(input_bits == 5'b11110) begin //o
                ans = 7'b1000000;
          end else if(input_bits == 5'b00001) begin //p
                ans = 7'b0001100;
          end else if(input_bits == 5'b10001) begin //q
                ans = 7'b0011000;
          end else if(input_bits == 5'b01001) begin //r
                ans = 7'b1001100;
          end else if(input_bits == 5'b11001) begin //s
                ans = 7'b0010010;
          end else if(input_bits == 5'b00101) begin //t
                ans = 7'b0000111;
          end else if(input_bits == 5'b10101) begin //u
                ans = 7'b1100011;
          end else if(input_bits == 5'b01101) begin //v
                ans = 7'b1000001;
          end else if(input_bits == 5'b11101) begin //w
                ans = 7'b1010101;
          end else if(input_bits == 5'b00011) begin //x
                ans = 7'b0001001;
          end else if(input_bits == 5'b10011) begin //y
                ans = 7'b0010001;
          end else if(input_bits == 5'b01011) begin //z
                ans = 7'b0100100;
          end else begin
					ans = 7'b1111111;
			 end
    end

    assign disp = ans;
	
endmodule