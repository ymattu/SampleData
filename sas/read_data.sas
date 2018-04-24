libname sam "\\Mac\Home\Desktop\SampleData\sas7bdat" ;
filename prd "\\Mac\Home\Desktop\SampleData\csv\Products.csv" encoding="utf-8" ;
filename sale "\\Mac\Home\Desktop\SampleData\csv\Sales.csv" encoding="utf-8" ;

proc import out=sam.Products
  datafile=prd
  dbms=csv replace ;
    getnames=yes ;
    datarow=2 ;
 run ;

 data sam.Sales ;
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
