module FinalProject(
input [4:0] input_bits,
input key1, rst,
input sw9, clk,
output [6:0] d0,d1,d2,d3,d4,inputDisplay,
output [9:0] led
);


integer state,PREGAME,GAMESTART,GAMELOSS,GAMEWIN,POSTGAME,lives,count;

initial begin
	//states
	 state = 0;
	 PREGAME = 0;
	 GAMESTART = 1;
	 GAMELOSS = 2;

	 POSTGAME = 4;
	
	 lives = 6; // Player 2s Lives
	 count = 0; //  counter
	
end

reg [1:0] key_prev;
reg [31:0] timer; 

assign led[0] =0;
assign led[1] =0;
assign led[2] =0;
assign led[3] =0;

assign led[4] =life[5];
assign led[5] =life[4];
assign led[6] =life[3];
assign led[7] =life[2];
assign led[8] =life[1];
assign led[9] =life[0];


seven_seg displayInput(input_bits,inputDisplay);	

reg [5:0] life = 6'b111111; // tells the LEDs to be on or off

reg [4:0] letter0, letter1, letter2, letter3, letter4; // player 1 answers
reg [4:0] guess0, guess1, guess2, guess3, guess4; // displays the guesses
	

//GAME
always @(posedge clk)
begin

	case(state) 
	
	PREGAME: begin	
	
	if(~key1 && key_prev) begin

	if (count == 0 && input_bits != 0)
		begin
			letter0 <= input_bits;
			guess0 <= input_bits;
			count <= count+1;
		end
		if (count == 1 && input_bits != 0)
		begin
			letter1 <= input_bits;
			guess1 <= input_bits;
			count <= count+1;
		end
		if (count == 2 && input_bits != 0)
		begin
			letter2 <= input_bits;
			guess2 <= input_bits;
			count <= count+1;
		end
		if (count == 3 && input_bits != 0)
		begin
			letter3 <= input_bits;
			guess3 <= input_bits;
			count <= count+1;
		end
		if (count == 4 && input_bits != 0)
		begin
			letter4 <= input_bits;
			guess4 <= input_bits;
			count <= count+1;
		end
		if (count == 5) // game starts, turn off all segments;
		begin
			guess0 <= 0;
			guess1 <= 0;
			guess2 <= 0;
			guess3 <= 0;
			guess4 <= 0;
			count <= count + 1;
			state <= GAMESTART;
		end
	end
	end
	
	GAMESTART: begin
	
		// checks if player 2's guess is correct;
			if(~key1 && key_prev) begin

			if( letter0 == input_bits)			
				guess0 = input_bits;				
			if ( letter1 == input_bits)		
				guess1 = input_bits;			
			if ( letter2 == input_bits)		
				guess2 = input_bits;				
			if ( letter3 == input_bits)			
				guess3 = input_bits;			
			if (letter4 == input_bits)			
				guess4 = input_bits;			
			
		if( guess0 == letter0 && guess1 == letter1 && guess2 == letter2 && guess3 == letter3 && guess4 == letter4) 
				state = POSTGAME;	//if all of the guesses are right transition to the win state
	
		if (state != POSTGAME && state != POSTGAME && letter0 != input_bits && letter1 != input_bits && letter2 != input_bits && letter3 != input_bits && letter4 != input_bits) // if the input of player 2 is wrong, remove a life
				begin	
				
				lives <= lives - 1;
				
			if (lives == 6)
				life[0] <= 0;
			if (lives == 5)
				life[1] <= 0;
			if (lives == 4)
				life[2] <= 0;
			if (lives == 3)
				life[3] <= 0;
			if (lives == 2)
				life[4] <= 0;	
			if (lives == 1) begin
				life[5] <= 0;
				state <= GAMELOSS;	
				end
			end		
		end
	end
	GAMELOSS: begin
				
				guess0 <= 5'b01100 ;		// print "f" on hex5
				guess1 <= 5'b10000;		// print "a" on hex4
				guess2 <= 5'b10010;		// print "i" on hex3
				guess3 <= 5'b00110;		// print "L" on hex2
				guess4 <= 5'b00000;		// print "" on hex1
				state <= POSTGAME;
	
			end

	POSTGAME: begin
	
		timer <= timer+1;
			if(timer == 5000000) begin
				guess0 <= 0;
				guess1 <= 0;
				guess2 <= 0;
				guess3 <= 0;
				guess4 <= 0;
			end else if(timer == 10000000) begin
				guess0 <= letter0;				
				guess1 <= letter1;		
				guess2 <= letter2;		
				guess3 <= letter3;		
				guess4 <= letter4;
				timer <=0;
			end	
	

	if(~key1 && key_prev) begin
		
		if(rst == 0) // resets the game
		begin
			count <= 0;
			guess0 <= 0;
			guess1 <= 0;
			guess2 <= 0;
			guess3 <= 0;
			guess4 <= 0;
		
			lives<=6;
			
			life <= 6'b111111;
			timer<=0;
			state <= PREGAME; 
		end
		
		end	
	end
endcase	

key_prev  = key1;
	
	
end



// Letter Display

seven_seg sevenSeg1(guess0, d0);
seven_seg sevenSeg2(guess1, d1);
seven_seg sevenSeg3(guess2, d2);
seven_seg sevenSeg4(guess3, d3);
seven_seg sevenSeg5(guess4, d4);



endmodule