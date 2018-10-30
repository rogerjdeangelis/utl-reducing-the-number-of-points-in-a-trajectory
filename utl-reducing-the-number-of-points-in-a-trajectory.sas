Reducing the number of points in a trajectory                                                    
                                                                                                 
I tend to prefer Python for this type of problem, however                                        
here is an R solution.                                                                           
                                                                                                 
github                                                                                           
https://github.com/rogerjdeangelis/utl-reducing-the-number-of-points-in-a-trajectory             
                                                                                                 
R Doc (there are other Python and R packages)                                                    
https://cran.r-project.org/web/packages/kmlShape/kmlShape.pdf                                    
                                                                                                 
Original message                                                                                 
https://listserv.uga.edu/cgi-bin/wa?A2=SAS-L;b1882900.1810e                                      
                                                                                                 
                                                                                                 
INPUT                                                                                            
=====                                                                                            
                                                                                                 
 SD1.HAVE total obs=100                                                                          
                                                                                                 
    1     0.1    0.016                                                                           
    2     0.2    0.028                                                                           
    3     0.3    0.040                                                                           
   ...                                                                                           
   98     9.8    0.988                                                                           
   99     9.9    0.996                                                                           
  100    10.0    1.004                                                                           
                                                                                                 
options ls=64 ps=32;                                                                             
proc plot data=sd1.have(rename=py=p1234567890123456789);                                         
  plot p1234567890123456789*px='*';                                                              
run;quit;                                                                                        
                                                                                                 
                                                                                                 
 PY  +                                                                                           
     |                        **                                                                 
     |                      ******                                                               
 1.0 +                     **    ***  **                                                         
     |                     *       ***                                                           
     |                    *                                                                      
     |                   **                                                                      
     |          ***     **                                                                       
     |         *   **  **                                                                        
     |        *      **                                                                          
 0.5 +       *                                                                                   
     |      **                                                                                   
     |      *                                                                                    
     |     *                                                                                     
     |    *                                                                                      
     |   **                                                                                      
     | **                                                                                        
 0.0 +**                                                                                         
     -+---------+---------+---------+---------+-                                                 
      0         3         6         9        12                                                  
                                                                                                 
                          PX                                                                     
                                                                                                 
OUTPUT (only 12 key points)                                                                      
======                                                                                           
                                                                                                 
options ls=64 ps=32;                                                                             
proc plot data=sd1.want(rename=y=p1234567890123456789);                                          
  plot p1234567890123456789*x='*';                                                               
run;quit;                                                                                        
                                                                                                 
                                                                                                 
 Y  +                                                                                            
    |                             *                                                              
    |                            * *                                                             
1.0 +                                        *                                                   
    |                                    *                                                       
    |                                                                                            
    |             *                                                                              
    |            * *                                                                             
    |                    *                                                                       
    |                  *                                                                         
0.5 +                                                                                            
    |                                                                                            
    |                                                                                            
    |                                                                                            
    |     *                                                                                      
    |                                                                                            
    |                                                                                            
0.0 +*                                                                                           
    -+---------+---------+---------+---------+-                                                  
    0.0       2.5       5.0       7.5      10.0                                                  
                                                                                                 
                         X                                                                       
                                                                                                 
 SD1.WANT total obs=10                                                                           
                                                                                                 
    X       Y                                                                                    
                                                                                                 
  0.1    0.01595                                                                                 
  1.2    0.19895                                                                                 
  2.9    0.68704                                                                                 
  3.4    0.70888                                                                                 
  4.4    0.60331                                                                                 
  5.0    0.60798                                                                                 
  7.0    1.09908                                                                                 
  7.5    1.10208                                                                                 
  8.9    0.95562                                                                                 
 10.0    1.00443                                                                                 
                                                                                                 
                                                                                                 
PROCESS                                                                                          
=======                                                                                          
                                                                                                 
%utl_submit_r64('                                                                                
library(kmlShape);                                                                               
library(SASxport);                                                                               
library(haven);                                                                                  
<-read_sas("d:/sd1/have.sas7bdat");                                                              
png(file="d:/png/DouglasPeuckerEpsilon.png");                                                    
par(mfrow=c(2,1));                                                                               
plot(PX,PY,type="l");                                                                            
plot(DouglasPeuckerEpsilon(PX,PY,0.04),type="b",col=3);                                          
dev.off();                                                                                       
write.xport(want,file="d:/xpt/want.xpt");                                                        
');                                                                                              
                                                                                                 
libname xpt xport "d:/xpt/want.xpt";                                                             
libname sd1 "d:/sd1";                                                                            
                                                                                                 
data sd1.want;                                                                                   
  set xpt.want;                                                                                  
run;quit;                                                                                        
                                                                                                 
                                                                                                 
*                _              _       _                                                        
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _                                                 
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |                                                
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |                                                
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|                                                
                                                                                                 
;                                                                                                
                                                                                                 
options validvarname=upcase;                                                                     
data sd1.have(where=(px ne .));                                                                  
 input Px 5.3 +1 py 6.3 +1 @@;                                                                   
cards4;                                                                                          
0.100  0.016 0.200  0.028 0.300  0.040 0.400  0.054 0.500  0.068 0.600  0.082                    
0.700  0.098 0.800  0.115 0.900  0.134 1.000  0.154 1.100  0.176 1.200  0.199                    
1.300  0.224 1.400  0.251 1.500  0.280 1.600  0.310 1.700  0.341 1.800  0.374                    
1.900  0.408 2.000  0.442 2.100  0.476 2.200  0.510 2.300  0.542 2.400  0.573                    
2.500  0.602 2.600  0.628 2.700  0.651 2.800  0.671 2.900  0.687 3.000  0.699                    
3.100  0.707 3.200  0.711 3.300  0.712 3.400  0.709 3.500  0.703 3.600  0.694                    
3.700  0.684 3.800  0.672 3.900  0.659 4.000  0.646 4.100  0.634 4.200  0.622                    
4.300  0.612 4.400  0.603 4.500  0.597 4.600  0.593 4.700  0.592 4.800  0.594                    
4.900  0.600 5.000  0.608 5.100  0.620 5.200  0.634 5.300  0.652 5.400  0.673                    
5.500  0.697 5.600  0.723 5.700  0.752 5.800  0.782 5.900  0.814 6.000  0.846                    
6.100  0.879 6.200  0.912 6.300  0.944 6.400  0.974 6.500  1.003 6.600  1.029                    
6.700  1.052 6.800  1.071 6.900  1.087 7.000  1.099 7.100  1.107 7.200  1.111                    
7.300  1.111 7.400  1.108 7.500  1.102 7.600  1.093 7.700  1.082 7.800  1.070                    
7.900  1.056 8.000  1.042 8.100  1.028 8.200  1.014 8.300  1.001 8.400  0.990                    
8.500  0.980 8.600  0.971 8.700  0.964 8.800  0.959 8.900  0.956 9.000  0.954                    
9.100  0.954 9.200  0.955 9.300  0.958 9.400  0.962 9.500  0.968 9.600  0.974                    
9.700  0.980 9.800  0.988 9.900  0.996 10.00  1.004                                              
;;;;                                                                                             
run;quit;                                                                                        
                                                                                                 
                                                                                                 
                                                                                                 
                                                                                                 
