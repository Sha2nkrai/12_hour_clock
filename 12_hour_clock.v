module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    reg flag=0;                    //flag is used to predict AM and PM
    
    
    always@(posedge clk)begin                       // this is the block used for incrememnting seconds
        if(reset)begin
            ss<=8'h00;
        end
        else if(ena) begin
            if(ss[3:0]==4'h9)
                ss[3:0]<=4'h0;
            else 
                ss[3:0]<=ss[3:0]+1;
            if((ss[7:4]==4'h5)&&(ss[3:0]==4'h9))
                ss[7:4]<=4'h0;
            else if(ss[3:0]==4'h9)
                ss[7:4]<=ss[7:4]+1;
            
        end 
        
    end 
    always@(posedge clk)begin                        //this is the block used for incrememnting minutes 
        if(reset)begin
            mm<=8'd00;
        end
        else if(ena)begin
            if((ss[7:4]==4'h5)&&(ss[3:0]==4'h9))begin
                 if(mm[3:0]==4'h9)
                     mm[3:0]<=4'h0;
                 else 
                     mm[3:0]<=mm[3:0]+1;
                if((mm[7:4]==4'h5)&&(mm[3:0]==4'h9))
                    mm[7:4]<=4'h0;
                else if(mm[3:0]==4'h9)
                    mm[7:4]<=mm[7:4]+1;
            end 
        end
        
    end 
        
        
    always@(posedge clk)begin                                    //this is the block used for incrememnting hours
        if((hh==8'h11)&((mm==8'h59))&(ss==8'h59))                 //here the flag is turned to PM 
            flag=~flag;
        if(reset)begin
            hh<=8'h12;
        end
        else if(ena)begin
            if((ss[7:4]==4'h5)&&(ss[3:0]==4'h9)&&(mm[7:4]==4'h5)&&(mm[3:0]==4'h9))begin
                if(hh[3:0]==4'h9)
                    hh[3:0]<=4'h0;
                 else 
                     hh[3:0]<=hh[3:0]+1;
                if((hh[7:4]==4'h1)&&(hh[3:0]==4'h2))
                     hh<=8'h1;
                else if(hh[3:0]==4'h9)
                    hh[7:4]<=hh[7:4]+1;
            end
                
            
        end
            
        
        
    end
    always@(*)begin                 //block to assign pm with flag
       pm<=flag;
    end 
        
        
        
    
        
    
    

endmodule
