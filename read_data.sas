libname sam "\\Mac\Home\Desktop\r_lecture\sample_data" ;
filename prd "\\Mac\Home\Desktop\r_lecture\sample_data\product.csv" encoding="utf-8" ;
filename sale "\\Mac\Home\Desktop\r_lecture\sample_data\sales.csv" encoding="utf-8" ;

proc import out=sam.product
  datafile=prd
  dbms=csv replace ;
    getnames=yes ;
    datarow=2 ;
 run ;

 data sam.sales ;
  infile sale missover dsd firstobs=2 ;
  length
    UserId $20
    ProductId 8
    Timestamp $20
  ;
  input UserId ProductId Timestamp ;
  Time = input(Timestamp, e8601dt19.) ;
  format Time datetime. ;
run ; 
