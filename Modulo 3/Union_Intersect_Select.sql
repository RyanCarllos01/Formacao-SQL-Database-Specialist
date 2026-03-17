 -- Union, except e intersect
 Create database teste;	
 use teste;
 create table R(
 A char(2)
 );
  create table S(
 A char(2)
 );
 
 insert into R(A) values ('a1'),('a2'),('a2'),('a3');
  insert into S(A) values ('a1'),('a1'),('a2'),('a3'),('a4'),('a5');
  
  select * from R;
    select * from S;
    
    -- except -> not in
    select * from S Where A not in (select A from R);
    
    -- intersect
    select distinct R.A from R where R.A in (select S.A from S);
    
    -- union, se não usar o distinct funciona da mesma forma,
    -- pois o a propria característica de union é pegar um valor	
    -- que tenha aparecido e juntar, ele não pega redundância
    (select distinct R.A from R)
    union
    (Select distinct S.A from S);
    
        (select R.A from R)
    union
    (Select S.A from S);
    
    