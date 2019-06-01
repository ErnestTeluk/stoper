`timescale 1ns / 1ps

module test_bench();

    reg CLOCK_50;   // zegar 50MHz
    reg [1:0] KEY;  // bit pierwszy: stany pauza, dzia³a (liczy) - zmiana NEGEDGE
                    // bit drugi : reset  (0 - reset, 1- not_reset)
    
    localparam speed_up = 1; // aby uzyskaæ zegar 100Hz nale¿y zminiæ wartoœæ na 500000 
                             // 1 - aby przyspieszyæ symulacjê 
    stopwatch #(speed_up) uut(.CLOCK_50(CLOCK_50), .KEY(KEY));
    // podgl¹d stopwatch
    wire CLOCK_SW, CLOCK_100;
    assign CLOCK_100 = uut.CLOCK_100;
    assign CLOCK_SW = uut.CLOCK_SW;
    wire [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
    assign HEX0 = uut.HEX0;
    assign HEX1 = uut.HEX1;
    assign HEX2 = uut.HEX2;
    assign HEX3 = uut.HEX3;
    assign HEX4 = uut.HEX4;
    assign HEX5 = uut.HEX5;
    
    
    // podgl¹d ms_clock
    wire [0:17] count;
    assign count = uut.ms_clock1.count;
    
    // ms_clock_switched ms_clock_switched1(clk, KEY[0], ms_clk);
    // podgl¹d ms_clock_switched
    // negedge na KEY powoduje zmianê stanu pauza <-> licz (na pocz¹tku nie liczymy)
    wire state;
    assign state = uut.ms_clock_switched1.state;
    
    // bcd_counter bcd_counter_hundredths(ms_clk, KEY[1], hundredths_bcd[3:0], tenths_in);
    // bcd_counter bcd_counter_tenths(tenths_in, KEY[1], tenths_bcd[3:0], ones_in);
    // bcd_counter bcd_counter_ones(ones_in, KEY[1], ones_bcd[3:0], tens_in);
    // bcd_counter bcd_counter_tens(tens_in, KEY[1], tens_bcd[3:0], );
    wire [3:0] hundredths_bcd, tenths_bcd, ones_bcd, tens_bcd, mins_bcd, tmins_bcd;
    assign hundredths_bcd = uut.hundredths_bcd;
    assign tenths_bcd = uut.tenths_bcd;
    assign ones_bcd = uut.ones_bcd;
    assign tens_bcd = uut.tens_bcd;
    assign mins_bcd = uut.mins_bcd;
    assign tmins_bcd = uut.tmins_bcd;
    
    initial
        begin
            CLOCK_50 = 1'b0; // na pocz¹tku 0
            KEY = 2'b11; // oba przyciski nie wciœniête
            
            #20 KEY[1] <= ~KEY[1];   // reset (przycisniecie przycisku reset)
            // test
            #300 KEY[0] <= ~KEY[0];   // zacznij mierzyæ czas (przycisniecie przycisku start)
            #300 KEY[0] <= ~KEY[0];   // pauza (przycisniecie przycisku start)
            #300 KEY[0] <= ~KEY[0];   // kontynuuj mierzenie czasu (przycisniecie przycisku start)
            #300 KEY[0] <= ~KEY[0];   // pauza (przycisniecie przycisku start)
            #200 KEY[1] <= ~KEY[1];   // reset (przycisniecie przycisku reset)
            #300 KEY[0] <= ~KEY[0];   // zacznij mierzyæ czas od pocz¹tku (przycisniecie przycisku start)
        end
    
    always
        begin
            #10 CLOCK_50 <= ~CLOCK_50; // tick co 20 ns co daje 50MHz
        end
    always @(negedge KEY[0])
        #10 KEY[0] <= ~KEY[0];  // ustawiamy wysoki stan (puszczenbie przycisku start)
    always @(negedge KEY[1])
        #10 KEY[1] <= ~KEY[1];  // ustawiamy wysoki stan (puszczenie przycisku reset)
endmodule
