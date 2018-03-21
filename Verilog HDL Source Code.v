`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:    Middle East Technical University
// Engineer:    Cem Recai Cirak
// 
// Create Date:    09:39:42 06/08/2014 
// Design Name: 
// Module Name:    game 
// Project Name:    2-Level FPGA Guitar Hero
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module game(button, level, clock, reset, h_sync, v_sync, red, green, blue, led_r, led_y, led_g, led_b, pfm);

// ****************************************************************************************************
//definition and initialization of wires and registers

//define inputs
input[3:0] button;
input clock;
input level;
input reset;

//define outputs
output h_sync;
output v_sync;
output[2:0] red;
output[2:0] green;
output[1:0] blue;
output led_r;
output led_y;
output led_g;
output led_b;
output pfm;

//define wires
wire clock, level, reset;
wire[3:0] button;

//define registers
reg clk, h_sync, v_sync, led_r, led_y, led_g, led_b, pfm, right_1, wrong_1, right_2, wrong_2, right_3, wrong_3, right_4, wrong_4;
reg[1:0] clk_cnt, blue;
reg[2:0] red, green;
reg[3:0] beat, beat_max, note, note_1, note_2, note_3, note_4, passed_1, passed_2, passed_3, passed_4, i, j, k_1, k_2, k_3, k_4;
reg[5:0] bps_cnt, bps_cnt_max;
reg[7:0] score;
reg[9:0] h_cnt, v_cnt, v_edge_1[15:0], v_edge_2[15:0], v_edge_3[15:0], v_edge_4[15:0];
reg[19:0] f_cnt, f, f_div[3:0];

//reset and initialize registers
always@(posedge clock)
begin
    if(reset)
	 begin
			clk = 0;            //variable
			h_sync = 0;         //output
			v_sync = 0;          //output
			led_r = 0;          //output
			led_y = 0;          //output
			led_g = 0;          //output
			led_b = 0;          //output
			pfm = 0;            //output
			right_1 = 0;        //variable
			wrong_1 = 0;        //variable
			right_2 = 0;        //variable
			wrong_2 = 0;        //variable
			right_3 = 0;        //variable
			wrong_3 = 0;        //variable
			right_4 = 0;        //variable
			wrong_4 = 0;        //variable
			//2-bit
			clk_cnt = 0;        //variable
			blue = 0;           //output
			//3-bit
			red = 0;            //output
			green = 0;          //output
			//4-bit
			beat = 0;           //variable
			beat_max = 0;       //variable
			note = 0;           //variable
			note_1 = 0;         //variable
			note_2 = 0;         //variable
			note_3 = 0;         //variable
			note_4 = 0;         //variable
			passed_1 = 0;       //variable
			passed_2 = 0;       //variable
			passed_3 = 0;       //variable
			passed_4 = 0;       //variable
			i = 0;              //variable
			j = 0;              //variable
			k_1 = 0;            //variable
			k_2 = 0;            //variable
			k_3 = 0;            //variable
			k_4 = 0;            //variable
			//6-bit
			bps_cnt = 0;        //variable
			bps_cnt_max = 0;    //variable
			//8-bit
			score = 0;          //variable
			//10-bit
			h_cnt = 0;          //variable
			v_cnt = 0;          //variable
			v_edge_1[0] = 0;    //variable
			v_edge_1[1] = 0;    //variable
			v_edge_1[2] = 0;    //variable
			v_edge_1[3] = 0;    //variable
			v_edge_1[4] = 0;    //variable
			v_edge_1[5] = 0;    //variable
			v_edge_1[6] = 0;    //variable
			v_edge_1[7] = 0;    //variable
			v_edge_1[8] = 0;    //variable
			v_edge_1[9] = 0;    //variable
			v_edge_1[10] = 0;   //variable
			v_edge_1[11] = 0;   //variable
			v_edge_1[12] = 0;   //variable
			v_edge_1[13] = 0;   //variable
			v_edge_1[14] = 0;   //variable
			v_edge_1[15] = 0;   //variable
			v_edge_2[0] = 0;    //variable
			v_edge_2[1] = 0;    //variable
			v_edge_2[2] = 0;    //variable
			v_edge_2[3] = 0;    //variable
			v_edge_2[4] = 0;    //variable
			v_edge_2[5] = 0;    //variable
			v_edge_2[6] = 0;    //variable
			v_edge_2[7] = 0;    //variable
			v_edge_2[8] = 0;    //variable
			v_edge_2[9] = 0;    //variable
			v_edge_2[10] = 0;   //variable
			v_edge_2[11] = 0;   //variable
			v_edge_2[12] = 0;   //variable
			v_edge_2[13] = 0;   //variable
			v_edge_2[14] = 0;   //variable
			v_edge_2[15] = 0;   //variable
			v_edge_3[0] = 0;    //variable
			v_edge_3[1] = 0;    //variable
			v_edge_3[2] = 0;    //variable
			v_edge_3[3] = 0;    //variable
			v_edge_3[4] = 0;    //variable
			v_edge_3[5] = 0;    //variable
			v_edge_3[6] = 0;    //variable
			v_edge_3[7] = 0;    //variable
			v_edge_3[8] = 0;    //variable
			v_edge_3[9] = 0;    //variable
			v_edge_3[10] = 0;   //variable
			v_edge_3[11] = 0;   //variable
			v_edge_3[12] = 0;   //variable
			v_edge_3[13] = 0;   //variable
			v_edge_3[14] = 0;   //variable
			v_edge_3[15] = 0;   //variable
			v_edge_4[0] = 0;    //variable
			v_edge_4[1] = 0;    //variable
			v_edge_4[2] = 0;    //variable
			v_edge_4[3] = 0;    //variable
			v_edge_4[4] = 0;    //variable
			v_edge_4[5] = 0;    //variable
			v_edge_4[6] = 0;    //variable
			v_edge_4[7] = 0;    //variable
			v_edge_4[8] = 0;    //variable
			v_edge_4[9] = 0;    //variable
			v_edge_4[10] = 0;   //variable
			v_edge_4[11] = 0;   //variable
			v_edge_4[12] = 0;   //variable
			v_edge_4[13] = 0;   //variable
			v_edge_4[14] = 0;   //variable
			v_edge_4[15] = 0;   //variable
			//20-bit
			f_cnt = 0;          //variable
			f_div = 0;          //variable
    end
end

// ****************************************************************************************************
//100 mhz to 25 mhz clock converter

always@(posedge clock)
begin
    if(clk_cnt < 3)
    begin
        if(clk_cnt == 0)
        begin
            clk = ~clk;
        end
        clk_cnt = clk_cnt + 1;
    end
    else
    begin
        clk_cnt = 0;
    end
end

// ****************************************************************************************************
//horizontal and vertical synchronisation

always@(posedge clk)
begin
	if(h_cnt < 800)
    begin
		if(h_cnt < 96)
        begin
			h_sync = 0;
			h_cnt = h_cnt + 1;
        end
		else
        begin
			h_sync = 1;
			h_cnt = h_cnt + 1;
        end
    end
	else
    begin
		if(v_cnt < 525)
        begin
			if(v_cnt < 2)
            begin
				v_sync = 0;
				v_cnt = v_cnt + 1;
            end
			else
            begin
				v_sync = 1;
				v_cnt = v_cnt + 1;
            end
        end
		else
        begin
			v_cnt = 0;
        end
		h_cnt = 0;
    end
end

// ****************************************************************************************************
//draw reference line and vertical brackerts

always@(posedge clk)
begin
	if((((390 < v_cnt < 395) || (455 < v_cnt < 460)) && (200 < h_cnt < 625)) || (200 < h_cnt < 205) || (305 < h_cnt < 310) || (410 < h_cnt < 415) || (515 < h_cnt < 520) || (620 < h_cnt < 625))
	begin
		red = 7;
		green = 7;
		blue = 3;
	end
end

// ****************************************************************************************************
//beat maker

//one or half second counter
always@(posedge clk)
begin
    if(bps_cnt_max == 0)
    begin
        if(level)
        begin
            bps_cnt_max = 29;
        end
        else
        begin
            bps_cnt_max = 59;
        end
    end
end

//one or two beat per second metronome
always@(posedge clk)
begin
    if(v_cnt == 0 && h_cnt == 0)
    begin
        if(bps_cnt < bps_cnt_max)
        begin
            bps_cnt = bps_cnt + 1;
        end
        else
        begin
            bps_cnt = 0;
        end
    end
end

//beat counter
always@(posedge clk)
begin
    if(beat_max == 0)
    begin
        if(level)
        begin
            beat_max = 15;
        end
        else
        begin
            beat_max = 7;
        end
    end
end

always@(posedge clk)
begin
    if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
    begin
        if(beat < beat_max)
        begin
            beat = beat + 1;
        end
        else
        begin
            beat = 0;
        end
    end
end

// ****************************************************************************************************
//song compositon

always@(posedge clk)
begin
    if(note == 0)
    begin
        if(level)
        begin
            if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
            begin
                if(beat == 0)
                begin
                    note = 5;
                end
                if(beat == 1)
                begin
                    note = 6;
                end
                if(beat == 2)
                begin
                    note = 9;
                end
                if(beat == 3)
                begin
                    note = 4;
                end
                if(beat == 4)
                begin
                    note = 12;
                end
                if(beat == 5)
                begin
                    note = 8;
                end
                if(beat == 6)
                begin
                    note = 13;
                end
                if(beat == 7)
                begin
                    note = 3;
                end
                if(beat == 8)
                begin
                    note = 3;
                end
                if(beat == 9)
                begin
                    note = 12;
                end
                if(beat == 10)
                begin
                    note = 10;
                end
                if(beat == 11)
                begin
                    note = 14;
                end
                if(beat == 12)
                begin
                    note = 8;
                end
                if(beat == 13)
                begin
                    note = 5;
                end
                if(beat == 14)
                begin
                    note = 9;
                end
                if(beat == 15)
                begin
                    note = 2;
                end
            end
        end
        else
        begin
            if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
            begin
                if(beat == 0)
                begin
                    note = 1;
                end
                if(beat == 1)
                begin
                    note = 4;
                end
                if(beat == 2)
                begin
                    note = 1;
                end
                if(beat == 3)
                begin
                    note = 8;
                end
                if(beat == 4)
                begin
                    note = 1;
                end
                if(beat == 5)
                begin
                    note = 4;
                end
                if(beat == 6)
                begin
                    note = 2;
                end
                if(beat == 7)
                begin
                    note = 1;
                end
            end
        end
    end
end

// ****************************************************************************************************
//draw and shift down notes

//check if there is a new note
always@(posedge clk)
begin
    //if a new note_1 comes
    if(note == 1 || note == 3 || note == 5 || note == 7 || note == 9 || note == 11 || note == 13 || note == 15)
    begin
        note = 0;
        note_1 = note_1 + 1;
    end
    //if a new note_2 comes
    if(note == 2 || note == 3 || note == 6 || note == 7 || note == 10 || note == 11 || note == 14 || note == 15)
    begin
        note = 0;
        note_2 = note_2 + 1;
    end
    //if a new note_3 comes
    if(note == 4 || note == 5 || note == 6 || note == 7 || note == 12 || note == 13 || note == 14 || note == 15)
    begin
        note = 0;
        note_3 = note_3 + 1;
    end
    //if a new note_4 comes
    if(note == 8 || note == 9 || note == 10 || note == 11 || note == 12 || note == 13 || note == 14 || note == 15)
    begin
        note = 0;
        note_4 = note_4 + 1;
    end
end

//shift down all generated notes at each new frame

//shift note 1
always@(posedge clk)
begin
    if(k_1 <= note_1)
    begin
        if(v_edge_1[k_1] < 526)
        begin
            if((204 < h_cnt < 306) && (v_edge_1[k_1] < v_cnt < (v_edge_1[k_1] + 60)))
            begin
                if(35 < v_cnt < 516)
                begin
                    red = 7;
                    green = 0;
                    blue = 0;
                end
                if(level)
                begin
                    v_edge_1[k_1] = v_edge_1[k_1] + 2 * (note_1 - passed_1);
                end
                else
                begin
                    v_edge_1[k_1] = v_edge_1[k_1] + (note_1 - passed_1);
                end
            end
        end
        else
        begin
            passed_1 = passed_1 + 1;
        end
        if(v_cnt == 0 && h_cnt ==0)
        begin
            if(k_1 < note_1)
            begin
                k_1 = k_1 + 1;
            end
            else
            begin
                k_1 = passed_1;
            end
        end
    end
end

//shift note 2
always@(posedge clk)
begin
    if(k_2 <= note_2)
    begin
        if(v_edge_2[k_2] < 526)
        begin
            if((309 < h_cnt < 411) && (v_edge_2[k_2] < v_cnt < (v_edge_2[k_2] + 60)))
            begin
                if(35 < v_cnt < 516)
                begin
                    red = 7;
                    green = 7;
                    blue = 0;
                end
                if(level)
                begin
                    v_edge_2[k_2] = v_edge_2[k_2] + 2 * (note_2 - passed_2);
                end
                else
                begin
                    v_edge_2[k_2] = v_edge_2[k_2] + (note_2 - passed_2);
                end
            end
        end
        else
        begin
            passed_2 = passed_2 + 1;
        end
        if(v_cnt == 0 && h_cnt ==0)
        begin
            if(k_2 < note_2)
            begin
                k_2 = k_2 + 1;
            end
            else
            begin
                k_2 = passed_2;
            end
        end
    end
end

//shift note 3
always@(posedge clk)
begin
    if(k_3 <= note_3)
    begin
        if(v_edge_3[k_3] < 526)
        begin
            if((414 < h_cnt < 516) && (v_edge_3[k_3] < v_cnt < (v_edge_3[k_3] + 60)))
            begin
                if(35 < v_cnt < 516)
                begin
                    red = 0;
                    green = 7;
                    blue = 0;
                end
                if(level)
                begin
                    v_edge_3[k_3] = v_edge_3[k_3] + 2 * (note_3 - passed_3);
                end
                else
                begin
                    v_edge_3[k_3] = v_edge_3[k_3] + (note_3 - passed_3);
                end
            end
        end
        else
        begin
            passed_3 = passed_3 + 1;
        end
        if(v_cnt == 0 && h_cnt ==0)
        begin
            if(k_3 < note_3)
            begin
                k_3 = k_3 + 1;
            end
            else
            begin
                k_3 = passed_3;
            end
        end
    end
end

//shift note 4
always@(posedge clk)
begin
    if(k_4 <= note_4)
    begin
        if(v_edge_4[k_4] < 526)
        begin
            if((519 < h_cnt < 621) && (v_edge_4[k_4] < v_cnt < (v_edge_4[k_4] + 60)))
            begin
                if(35 < v_cnt < 516)
                begin
                    red = 0;
                    green = 0;
                    blue = 3;
                end
                if(level)
                begin
                    v_edge_4[k_4] = v_edge_4[k_4] + 2 * (note_4 - passed_4);
                end
                else
                begin
                    v_edge_4[k_4] = v_edge_4[k_4] + (note_4 - passed_4);
                end
            end
        end
        else
        begin
            passed_4 = passed_4 + 1;
        end
        if(v_cnt == 0 && h_cnt ==0)
        begin
            if(k_4 < note_4)
            begin
                k_4 = k_4 + 1;
            end
            else
            begin
                k_4 = passed_4;
            end
        end
    end
end

// ****************************************************************************************************
//light up leds and update score

//if button 1 is pressed
always@(posedge clk)
begin
    if(button == 1 || button == 3 || button == 5 || button == 7 || button == 9 || button == 11 || button == 13 || button == 15)
    begin
        if(right_1 == 0 && wrong_1 == 0)
        begin
            for(j = 0; j < 7; j = j + 1)
            begin
                if(380 < v_edge_1[j] < 410)
                begin
                    right_1 = 1;
                end
            end
            if(right_1)
            begin
                led_r = 1;
            end
            else
            begin
                wrong_1 = 1;
            end
        end
    end
    if(v_cnt == 0 && h_cnt == 0)
    begin
        if(right_1)
        begin
            if(level)
            begin
                if(score < 190)
                begin
                    score = score + 10;
                end
                else
                begin
                    score = 200;
                end
            end
            else
            begin
                if(score < 175)
                begin
                    score = score + 25;
                end
                else
                begin
                    score = 200;
                end
            end
        end
        if(wrong_1)
        begin
            if(score > 10)
            begin
                score = score - 10;
            end
            else
            begin
                score = 0;
            end
        end
    end
    if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
    begin
        right_1 = 0;
        wrong_1 = 0;
        led_r = 0;
    end
end

//if button 2 is pressed
always@(posedge clk)
begin
    if(button == 2 || button == 3 || button == 6 || button == 7 || button == 10 || button == 11 || button == 14 || button == 15)
    begin
        if(right_2 == 0 && wrong_2 == 0)
        begin
            for(j = 0; j < 6; j = j + 1)
            begin
                if(380 < v_edge_2[j] < 410)
                begin
                    right_2 = 1;
                end
            end
            if(right_2)
            begin
                led_y = 1;
            end
            else
            begin
                wrong_2 = 1;
            end
        end
    end
    if(v_cnt == 0 && h_cnt == 0)
    begin
        if(right_2)
        begin
            if(level)
            begin
                if(score < 190)
                begin
                    score = score + 10;
                end
                else
                begin
                    score = 200;
                end
            end
            else
            begin
                if(score < 175)
                begin
                    score = score + 25;
                end
                else
                begin
                    score = 200;
                end
            end
        end
        if(wrong_2)
        begin
            if(score > 10)
            begin
                score = score - 10;
            end
            else
            begin
                score = 0;
            end
        end
    end
    if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
    begin
        right_2 = 0;
        wrong_2 = 0;
        led_y = 0;
    end
end

//if button 3 is pressed
always@(posedge clk)
begin
    if(button == 4 || button == 5 || button == 6 || button == 7 || button == 12 || button == 13 || button == 14 || button == 15)
    begin
        if(right_3 == 0 && wrong_3 == 0)
        begin
            for(j = 0; j < 8; j = j + 1)
            begin
                if(380 < v_edge_3[j] < 410)
                begin
                    right_3 = 1;
                end
            end
            if(right_3)
            begin
                led_g = 1;
            end
            else
            begin
                wrong_3 = 1;
            end
        end
    end
    if(v_cnt == 0 && h_cnt == 0)
    begin
        if(right_3)
        begin
            if(level)
            begin
                if(score < 190)
                begin
                    score = score + 10;
                end
                else
                begin
                    score = 200;
                end
            end
            else
            begin
                if(score < 175)
                begin
                    score = score + 25;
                end
                else
                begin
                    score = 200;
                end
            end
        end
        if(wrong_3)
        begin
            if(score > 10)
            begin
                score = score - 10;
            end
            else
            begin
                score = 0;
            end
        end
    end
    if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
    begin
        right_3 = 0;
        wrong_3 = 0;
        led_g = 0;
    end
end

//if button 4 is pressed
always@(posedge clk)
begin
    if(button == 8 || button == 9 || button == 10 || button == 11 || button == 12 || button == 13 || button == 14 || button == 15)
    begin
        if(right_4 == 0 && wrong_4 == 0)
        begin
            for(j = 0; j < 9; j = j + 1)
            begin
                if(380 < v_edge_4[j] < 410)
                begin
                    right_4 = 1;
                end
            end
            if(right_4)
            begin
                led_b = 1;
            end
            else
            begin
                wrong_4 = 1;
            end
        end
    end
    if(v_cnt == 0 && h_cnt == 0)
    begin
        if(right_4)
        begin
            if(level)
            begin
                if(score < 190)
                begin
                    score = score + 10;
                end
                else
                begin
                    score = 200;
                end
            end
            else
            begin
                if(score < 175)
                begin
                    score = score + 25;
                end
                else
                begin
                    score = 200;
                end
            end
        end
        if(wrong_4)
        begin
            if(score > 10)
            begin
                score = score - 10;
            end
            else
            begin
                score = 0;
            end
        end
    end
    if(bps_cnt == 0 && v_cnt == 0 && h_cnt == 0)
    begin
        right_4 = 0;
        wrong_4 = 0;
        led_b = 0;
    end
end

// ****************************************************************************************************
//draw score bar

always@(posedge clk)
begin
	if(((675 < h_cnt < 690) && ((375 - score) < v_cnt < 375)) || (((665 < h_cnt < 700))&&(375 < v_cnt < 380)))
	begin
		red = 0;
		green = 7;
		blue = 3;
	end
end

// ****************************************************************************************************
//audio output waveform generator

//change frequency divider with respect to button combination
always@(posedge clk)
begin
    if(button)
    begin
        if(button == 1)
        begin
            f_div = 213675;
        end
        if(button == 2)
        begin
            f_div = 120192;
        end
        if(button == 3)
        begin
            f_div = 179859;
        end
        if(button == 4)
        begin
            f_div = 90253;
        end
        if(button == 5)
        begin
            f_div = 160256;
        end
        if(button == 6)
        begin
            f_div = 107296;
        end
        if(button == 7)
        begin
            f_div = 135135;
        end
        if(button == 8)
        begin
            f_div = 30084;
        end
        if(button == 9)
        begin
            f_div = 60240;
        end
        if(button == 10)
        begin
            f_div = 40193;
        end
        if(button == 11)
        begin
            f_div = 80386;
        end
        if(button == 12)
        begin
            f_div = 33784;
        end
        if(button == 13)
        begin
            f_div = 56054;
        end
        if(button == 14)
        begin
            f_div = 45126;
        end
        if(button == 15)
        begin
            f_div = 67568;
        end
    end
    else
    begin
        pfm = 0;
    end
end

//create square waveform with audible frequencies for each button combination
always@(posedge clk)
begin
    if(f_cnt < f_div)
    begin
        if(f_cnt == 0)
        begin
            pfm = ~pfm;
        end
        f_cnt = f_cnt + 1;
    end
    else
    begin
        f_cnt = 0;
    end
end

endmodule

