unit tests;

interface

uses
  System.SysUtils, System.Types,
  math387, MtxVec,  mvutils,
  metapost, statistics, probabilities, statrandom, vcl.Graphics, vcl.Imaging.jpeg;

procedure testalp;

procedure testalp_4;

procedure testalp_4all;

procedure testhist2;

procedure testsigma;

procedure testsigma3;

procedure testrandWalsh;

procedure testalpW;

procedure testsigmaW;

procedure testmac;

procedure testhist2W;

procedure testsearch;

procedure testbin;

procedure alp_curves;

procedure testfixedalp;
procedure testfixedalp_corr;

procedure testintarray;

procedure testscaleimg;


implementation

procedure drawarrayv(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl-1,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl-1,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $-\alpha$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $-\alpha_{\rm b}$ etex scaled 1.0');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');



      beg:=b.xr*be/en;

      drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,1.5,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true);



      h1:=b.xr*(en-be)/(en*v1.Length);

      for i:=1 to v1.length-1 do
         drawcol(f,a,b,beg+(i-1)*h1,b.yr*v1.Values[i-1]/4,
                       beg+i*h1,b.yr*v1.Values[i]/4,1.5,0,{1}0,0,false);


     endmp(f);
     compil(s);  writeln('end');
end;


procedure drawarraymv(const mv:TMtx; const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl-1,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl-1,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $-\alpha$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $-\alpha_{\rm c}^{\rm WR}$ etex scaled 1.0');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');

      h:=b.xr*(en-be)/(en*mv.Cols);

      beg:=b.xr*be/en;

      drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true);

      for j:=0 to mv.Cols-1 do
       for i:=0 to mv.Rows-1 do
           drawcol(f,a,b,beg+j*h,b.yr*mv.Values[i,j]/4,
                       beg+j*h,b.yr*mv.Values[i,j]/4,1,0,0,0,false);

      h1:=b.xr*(en-be)/(en*v1.Length);

      for i:=1 to v1.length-1 do
         drawcol(f,a,b,beg+(i-1)*h1,b.yr*v1.Values[i-1]/4,
                       beg+i*h1,b.yr*v1.Values[i]/4,1,0,1,0,false);


     endmp(f);
     compil(s);  writeln('end');
end;

function integr(n:integer; x,y:Extended):Extended;
 var i,j:integer;
begin
  Result:=1; j:=1;
  for i:=1 to n-1 do
   begin
    Result:=Result*cos(j*x)*cos(j*y);
    j:=2*j;
   end;

  Result:=sqr(Result)*(1-sqr(cos(j*x)*cos(j*y)));
end;

function alp_many_1(n,len:integer; alp:Extended):Extended;
 var i,j:integer;
     h:Extended;
begin
  Result:=0;  h:=pi/(2*len);
  for i:=1 to len do
    for j:=1 to len do
      begin
        Result:=Result+sqr(h)*integr(n,i*h,j*h)/power(sqrt(sqr(i*h)+sqr(j*h)),1-alp);
      end;
end;

function alp_many(n,len:integer; alp:Extended):Extended;
begin
  Result:=-1+ln(alp_many_1(n,len,alp)/alp_many_1(n+1,len,alp))/ln(2);
end;

procedure drawarraymv_fixedalp0(const mv:TMtx; alp:Extended; v1:Tvec; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=4; a.yr:=4;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $j$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex ${\rm log}_2S_j$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');



      {drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true); }

      beg:=0; h:=1/(mv.Cols+1);

      for j:=1 to mv.Cols-1 do
       for i:=0 to mv.Rows-1 do
         begin

           t:=mv.Values[i,j];

           t:=t/(alp*(mv.cols+1));

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+2)*h),b.yr*t,
                       a.xr*(beg+(j+2)*h),b.yr*t,2.0,0,0,0,false);


         end;




      for j:=1 to v1.Length-1 do

         begin

           t:=v1.Values[j];

           t:=t/(alp*(mv.cols+1));

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+2)*h),b.yr*t,
                       a.xr*(beg+(j+2)*h),b.yr*t,1,0,1,0,false);


         end;


     drawcol(f,a,b,a.xr*1,b.yr*0,
                       a.xr*0,b.yr*1,0.5,1,0,0,false);

     dotlabelepsabcol(f,a,b,a.xr*(beg+5*h),a.yl,0,0,0,6,'btex $'+inttostr(5)+'$ etex scaled 0.8');




     endmp(f);
     compil(s);  writeln('end');
end;


procedure drawarraymv_fixedalp(const mv:TMtx; alp:Extended; v1:Tvec; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=4; a.yr:=4;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $j$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $-\alpha_{\rm c}^{\rm WR}$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');



      {drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true); }

      beg:=0; h:=1/(mv.Cols+1);

      for j:=2 to mv.Cols-2 do
       for i:=0 to mv.Rows-1 do
         begin

           t:=mv.Values[i,j]-mv.Values[i,j+1];

           t:=2*t/(alp*3);

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+3)*h),b.yr*t,
                       a.xr*(beg+(j+3)*h),b.yr*t,2.0,0,0,0,false);


         end;




      for j:=2 to v1.Length-2 do

         begin

           t:=v1.Values[j]-v1.Values[j+1];

           t:=2*t/(alp*3);

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+3)*h),b.yr*t,
                       a.xr*(beg+(j+3)*h),b.yr*t,1,0,1,0,false);


         end;


     drawcol(f,a,b,a.xr*1,b.yr*(2/3),
                       a.xr*0,b.yr*(2/3),0.5,1,0,0,false);



     dotlabelepsabcol(f,a,b,a.xr*(beg+5*h),a.yl,0,0,0,6,'btex $'+inttostr(5)+'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,a.xl,b.yr*(2/3),0,0,0,4,'btex $'+inttostr(2)+'$ etex scaled 0.8');

     endmp(f);
     compil(s);  writeln('end');
end;

procedure testalp;
 var mv:TMtx; v1:TVec;
     sm,samp:integer;
     be,en:Extended;
begin
  CreateIt(mv); CreateIt(v1);

    sm:=400;  be:=-1; en:=4;  samp:=40;

    mv.Size(samp,400,false);  genmv(mv,be,en,sm);

    v1.Size(400,false); genv1(v1,be,en,sm div 2);

    drawarraymv(mv,v1,be,en,'tm'+inttostr(sm));

  FreeIt(mv); FreeIt(v1);
end;

procedure testfixedalp;
 var mv,mv1:TMtx; v1:TVec;
     sm,samp:integer;
     be,en,alp:Extended;
     i:integer;
begin
  //writeln(alp_many(2,4000,-2.0):3:3,'   ',mac2(2.0,4000):3:3); readln;

  CreateIt(mv,mv1); CreateIt(v1);

    sm:=2048;  be:=-1; en:=4;  samp:=11; alp:=2;

    mv.Size(50,samp,false);  genmv_fixed_alp(mv,sm,-alp);

    norm_mv_fixed_alp(mv,mv1);

    writeln('number of cols',' ',mv1.cols);

    //v1.Size(1,false); genv1(v1,be,en,sm div 2);

    writem(mv1);

    writeln; writeln(mac2(alp,sm div 2):5:5);

    v1.Complex:=false; v1.Length:=samp-1;

    intarray_norm(sm div 2,alp,v1);

    writeln; writev(v1);

    drawarraymv_fixedalp0(mv1,alp,v1,'tmfixedalpn0_'+inttostr(sm));

  FreeIt(mv,mv1); FreeIt(v1);    readln;
end;


procedure drawarraymv_fixedalp0_corr(const mv:TMtx; alp:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=4; a.yr:=4;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $j$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,{4}0,'btex $({\rm log}_2S^{\rm e})^{-1}({\rm log}_2S_j)$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');



      {drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true); }

      beg:=0; h:=1/(mv.Cols+1);

      for j:=1 to mv.Cols-1 do
       for i:=0 to mv.Rows-1 do
         begin

           t:=mv.Values[i,j];

           t:=t/(alp*(mv.cols+1));

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+2)*h),b.yr*t,
                       a.xr*(beg+(j+2)*h),b.yr*t,2.0,0,0,0,false);


         end;



     dotlabelepsabcol(f,a,b,a.xr*(beg+5*h),a.yl,0,0,0,6,'btex $'+inttostr(5)+'$ etex scaled 0.8');



     drawcol(f,a,b,a.xr*1,b.yr*0,
                       a.xr*0,b.yr*1,0.5,1,0,0,false);




     endmp(f);
     compil(s);  writeln('end');
end;

procedure drawarraymv_fixedalp_corr(const mv:TMtx; alp:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=4; a.yr:=4;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $j$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,{4}0,'btex $-(\alpha^{\rm WR}_{\rm e})^{-1}\alpha^{\rm WR}_{\rm c}$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');



      {drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);

      drawcol(f,a,b,b.xl,3*b.yr/4,
                       b.xr,3*b.yr/4,0.5,0,0,1,true); }

      beg:=0; h:=1/(mv.Cols+1);

      for j:=2 to mv.Cols-2 do
       for i:=0 to mv.Rows-1 do
         begin

           t:=mv.Values[i,j]-mv.Values[i,j+1];

           t:=2*t/(alp*3);

           //t:=t-ln(2)*j+ln(2)*(mv.cols-1);

           {t:=t/ln(2);

           t:=t+1;    t:=(3/4)*t/alp; }

           drawcol(f,a,b,a.xr*(beg+(j+3)*h),b.yr*t,
                       a.xr*(beg+(j+3)*h),b.yr*t,2.0,0,0,0,false);


         end;



     dotlabelepsabcol(f,a,b,a.xr*(beg+5*h),a.yl,0,0,0,6,'btex $'+inttostr(5)+'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,a.xl,b.yr*(2/3),0,0,0,4,'btex $'+inttostr(2)+'$ etex scaled 0.8');



     drawcol(f,a,b,a.xr*1,b.yr*(2/3),
                       a.xr*0,b.yr*(2/3),0.5,1,0,0,false);




     endmp(f);
     compil(s);  writeln('end');
end;

procedure testfixedalp_corr;
 var mv,mv1:TMtx; v1:TVec;
     sm,samp:integer;
     be,en,alp:Extended;
     i,j:integer;
     val: array of TVec;
begin
  {SetLength(val,11); for i:=0 to Length(val)-1 do CreateIt(val[i]);

                     for i:=0 to Length(val)-1 do begin val[i].Complex:=false; val[i].Length:=100; end;

                     intarray_norm_alpinterval(1024,1,2,val);

                     for j:=0 to val[0].Length-1 do
                       begin
                         for i:=0 to Length(val)-1 do write(val[i].Values[j]:3:3,' '); writeln;
                       end;

                     writeln('ok');

                     for i:=0 to Length(val)-1 do FreeIt(val[i]);  readln;}


  CreateIt(mv,mv1); CreateIt(v1);

    sm:=2048;  be:=-1; en:=4;  samp:=11; alp:=2;

    mv.Size(50,samp,false);  genmv_fixed_alp(mv,sm,-alp);

    norm_mv_fixed_alp(mv,mv1);

    //v1.Size(1,false); genv1(v1,be,en,sm div 2);

    writem(mv1);

    writeln; writeln(mac2(alp,sm div 2):5:5);

    v1.Complex:=false; v1.Length:=samp-1;

    intarray_norm(sm div 2,alp,v1);

    writeln; writev(v1);

    norm_mv_fixed_alp_cor(mv1,mv,alp-1,alp+1,sm div 2, 400);

    drawarraymv_fixedalp0_corr(mv,alp,'tmfixedalpn0_corr_'+inttostr(sm));

  FreeIt(mv,mv1); FreeIt(v1);    readln;
end;

procedure testintarray;
 var val: array of Extended;
     i:integer;
     t:Extended;
begin
  SetLength(val,10);
  intarray(15000,2.5,val);
  for i:=0 to Length(val)-1 do writeln(val[i]:5:5);

  t:=(val[7]-val[8])/(val[8]-val[9]);

  t:=1-ln(t)/ln(2);

  writeln(t:5:5,'  ',mac2(2.5,10000):5:5);

  SetLength(val,0); readln;
end;

procedure alp_curves;
 var v1:TVec;
     sm,N,i,j1,j2:integer;
     be,en,e:Extended;
begin
  CreateIt(v1);

    sm:=4000;  be:=-1; en:=4;

    N:=400;  e:=0.1;

    v1.Size(N,false); genv1(v1,be,en,sm );

    j1:=ceil(N*((3-be)/(en-be)-e));

    j2:=ceil(N*((3-be)/(en-be)));

    for i:=j1 to j2 do v1.Values[i]:=v1.Values[j1]+(3-v1.Values[j1])*(i-j1)/(j2-j1);

    for i:=j2 to N-1 do v1.Values[i]:=3;

    drawarrayv(v1,be,en,'alp_curves');

  FreeIt(v1);
end;

procedure testalp_4;
 var mv:TMtx; v1:TVec;
     sm,samp:integer;
     be,en:Extended;
begin
  CreateIt(mv); CreateIt(v1);

    sm:=1200;  be:=-1; en:=4;  samp:=40;

    mv.Size(samp,400,false);  genmv_4(mv,be,en,sm);

    v1.Size(400,false); genv1_4(v1,be,en,sm div 2);

    drawarraymv(mv,v1,be,en,'tm'+inttostr(sm)+'_4');

  FreeIt(mv); FreeIt(v1);
end;

procedure meand(const v:TVec; var mean,vary:Extended);
 var v1:TVec;
begin
 CreateIt(v1);
  mean:=v.Sum/v.Length;
  v1.Copy(v); v1.Sub(mean);
  vary:=v1.SumOfSquares/v1.length;
 FreeIt(v1);
end;

procedure drawarrayv2(const v,v1,v2:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=-b.xr; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,0,c.yl,0,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $N(\alpha-\alpha_C)$ etex scaled 0.8');

      labelepsabcol(f,a,b,0,c.yr,0,0,0,4,'btex $p$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,4,4)+'$ etex scaled 0.8');

      t:=Max(v1.Max,v2.Max);

      dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(t/2,ffFixed,3,3)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*v1.Length);





     for i:=0 to v1.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*v1.Values[i]/t,
                       beg+i*h1,b.yr*v1.Values[i]/t,1,0,0,0,false);


     h1:=b.xr*(en-be)/(en*v2.Length);

     for i:=0 to v2.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*v2.Values[i]/t,
                       beg+i*h1,b.yr*v2.Values[i]/t,1,1,0,0,false);


     h1:=b.xr*(en-be)/(en*v.Length);

      for i:=1 to v.length-1 do
         drawcol(f,a,b,beg+(i-1)*h1,b.yr*v.Values[i-1]/t,
                       beg+i*h1,b.yr*v.Values[i]/t,1,0,1,0,false);

     endmp(f);
     compil(s);  writeln('end');
end;

procedure testhist2;
 var v,v1,v2,v3:TVec;
     alp,mean,vary,t1,t0,be,en,h,mult:Extended;
     mean1,vary1:Double;
     sm,i,N,st:integer;
begin
  CreateIt(v,v1,v2,v3);

  alp:=-0.8;

  t0:=mac2(-alp,8000);



  sm:=200;

  N:=8000;

  v.Size(N,false);

    t1:=mac2(-alp,sm);

    genv2(v,alp,sm);

    writeln(t1); writeln;

    normalfit(v,mean1,vary1);



    meand(v,mean,vary);

    Mult:=5*sqrt(vary)*power(sm,min(3+alp,1));



    histogram(v,100,v1,v2,false,t0+Mult/power(sm,min(3+alp,1)),t0-Mult/power(sm,min(3+alp,1)));



    {writev(v1); writeln;
    writev(v2); writeln; }

    for i:=1 to v2.Length-3 do
     writeln(power(sm,min(3+alp,1))*(v2.Values[i]-t0):3:3,' ',v1.Values[i]/N:3:3,' ',
         -NormalCDF(v2.Values[i],mean,sqrt(vary))+normalcdf(v2.Values[i+1],mean,sqrt(vary)):3:3);

    sm:=2*sm;



    t1:=mac2(-alp,sm);

    genv2(v,alp,sm);

    writeln(t1); writeln;

    normalfit(v,mean1,vary1);



    meand(v,mean,vary);



    histogram(v,100,v3,v2,false,t0+Mult/power(sm,min(3+alp,1)),t0-Mult/power(sm,min(3+alp,1)));

    {writev(v3); writeln;
    writev(v2); writeln;}

    for i:=1 to v2.Length-3 do
     writeln(power(sm,min(3+alp,1))*(v2.Values[i]-t0):3:3,' ',v3.Values[i]/N:3:3,' ',
         -NormalCDF(v2.Values[i],mean,sqrt(vary))+normalcdf(v2.Values[i+1],mean,sqrt(vary)):3:3);

    v1.Scale(1/N); v3.Scale(1/N);

    v.Size(400,false);   v.Scale(0);

    be:=(v2.Values[0]+v2.Values[0])/2;    //be:=(be-t0)*sm;

    en:=(v2.Values[v2.Length-1]+v2.Values[v2.Length-1])/2;  //en:=(en-t0)*sm;

    h:=(en-be)/400;

    for I := 0 to v.Length-1 do v.Values[i]:=NormalPDF(be+h*i{+h*8},mean,sqrt(vary))*4*h;


    //for I := 0 to v.Length-1 do v.Values[i]:=(NormalCDF(be+h*i+h,0,sm*sqrt(vary))
    //                                         -NormalCDF(be+h*i,0,sm*sqrt(vary)))/h;

    drawarrayv2(v,v1,v3,4*(v2.Values[0]-t0)/(v2.Values[v2.Length-1]-t0),4,'compare08aaa0d');

  FreeIt(v,v1,v2,v3);   readln;
end;

procedure testsigma;
 var i,sm:integer;
     v:TVec;
     alp,mean,disp,t0,t1:Extended;
     mean1,disp1:Double;
begin
  CreateIt(v);
    v.Size(10000,false); sm:=400;
    alp:=-1.7;  t0:=mac2(-alp,8000);
    writeln(t0:5:5); writeln;
    for i:=1 to 1 do
     begin
       sm:=sm+40;
       genv2(v,alp,sm);
       meand(v,mean,disp);
       normalfit(v,mean1,disp1);

       t1:=mac2(-alp,sm);

       writeln(sm,' ',sqrt(disp)*power(sm,min(3+alp,1)):5:5,' ',mean:5:5,'   ',
       disp1*power(sm,min(3+alp,1)):5:5,' ',mean1:5:5,'    ',
       (t0-mean)*power(sm,min(3+alp,1)):5:5,'     ',(t1-mean)*power(sm,min(3+alp,1)):5:5);
     end;
  FreeIt(v); readln;
end;

procedure testsigma3;
 var i,sm:integer;
     v:TVec;
     alp,mean,disp,t0,t1,k:Extended;
     mean1,disp1:Double;
begin
  CreateIt(v);
    v.Size(1000,false); sm:=200; k:=1;
    alp:=-3.5;  t0:=mac2(-alp,8000);
    writeln(t0:5:5); writeln;
    for i:=1 to 30 do
     begin
       sm:=sm+40;
       genv2(v,alp,sm);
       meand(v,mean,disp);
       normalfit(v,mean1,disp1);

       t1:=mac2(-alp,sm);

       writeln(sm,' ',sqrt(disp)*power(sm,(-alp-3)*k):5:5,' ',mean:5:5,'   ',
       disp1*power(sm,(-alp-3)*k):5:5,' ',mean1:5:5,'    ',
       (t0-mean)*power(sm,(-alp-3)*k):5:5,'     ',(t1-mean)*power(sm,(-alp-3)*k):5:5);
     end;
  FreeIt(v); readln;
end;

procedure testscaleimg;
 var m:TMtx;
     i,j:integer;
begin
  CreateIt(m);

  m.Size(300,300,false);

  for i:=0 to m.rows-1 do
   for j:=0 to m.cols-1 do m.Values[i,j]:=-2+4*i/m.rows;

    jpgbmp(m,'test_scales_img1');

    writeln('ok');

  FreeIt(m);  readln;
end;

procedure testrandWalsh;
 var m,m1:TMtx;
     v:TVec;
     sm,i:integer;
     t,alp1,alp:Extended;
     mean1,disp1:Double;
begin
  CreateIt(m,m1);  CreateIt(v);
    sm:=200;  alp1:=-1.7;  alp:=-3;

    //m1.Size(sm,sm,false); m1.RandUniform(-1,1);

    randmsp_re(m1,sm,alp1); changesize(m1,3*m1.Rows,3*m1.Cols,m);

    jpgbmp(m,'test_Walsh');

    addnoise3_Walsh(m1,alp,m1.Max/3,m);

    writeln('computed ',alpha4(m,t):3:3);

    reduce(m,4,4,m1);

    writeln('computed ',alpha4(m1,t):3:3);

    jpgbmp(m,'test_Walsh_add');

    writeln('ok');

    v.Size(1000,false);

    alp:=1.3; sm:=256;

    for i:=1 to 2 do  begin

    alp:=-0.5-i/10;

    genv2_Walsh3a(v,alp,sm);

    normalfit(v,mean1,disp1);

    writeln(mean1:5:5,' ',sqr(4*sm*disp1*ln(2)):5:5);

    end;
    t:=0;

    //writeln(t:5:5);

    //reduce(m,2,2,m1); writeln(m1.max,' ',m.max);
  FreeIt(m,m1); FreeIt(v); readln;
end;

procedure drawarraymvW(const mv:TMtx; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl-1,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl-1,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $-\alpha$ etex scaled 1.0');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $-\alpha_{\rm c}^{\rm WR}$ etex scaled 1.0');

      //labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $-(\alpha_{\rm e}^{\rm WR})^{-1}(\alpha_{\rm c}^{\rm WR})$ etex scaled 1.0');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 1.0');

      h:=b.xr*(en-be)/(en*mv.Cols);

      beg:=b.xr*be/en;

      {drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,3,1,0,0,false);        }



      for j:=0 to mv.Cols-1 do
       for i:=0 to mv.Rows-1 do
           drawcol(f,a,b,beg+j*h,b.yr*mv.Values[i,j]/4,
                       beg+j*h,b.yr*mv.Values[i,j]/4,1,0,0,0,false);

    { drawcol(f,a,b,b.xl-1,b.yl-1,
                       b.xr,b.yr,1,0,1,0,false);       }


     endmp(f);
     compil(s);  writeln('end');
end;

procedure testalpW;
 var mv:TMtx; v1:TVec;
     sm,samp:integer;
     be,en:Extended;
begin
  CreateIt(mv);

    sm:=400;  be:=-1; en:=4;  samp:=40;

    mv.Size(samp,400,false);  genmv3_Walsh(mv,be,en,sm);



    drawarraymvW(mv,be,en,'W'+inttostr(sm));

  FreeIt(mv);
end;

procedure testalp_4all;
 var mv:TMtx; v1:TVec;
     sm,samp:integer;
     be,en:Extended;
begin
  CreateIt(mv);

    sm:=400;  be:=-1; en:=4;  samp:=40;

    mv.Size(samp,400,false);  genmv_4all(mv,be,en,sm);



    drawarraymvW(mv,be,en,'all4a_'+inttostr(sm));

  FreeIt(mv);
end;

procedure drawarraysigmaW(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl-1,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl-1,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $-\alpha$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $N\sigma$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr/2,0,0,0,0,6,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,3*b.xr/4,0,0,0,0,6,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');


      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(2,ffFixed,0,0)+'$ etex scaled 0.8');

      // * dotlabelepsabcol(f,a,b,0,3*b.yr/4,0,0,0,4,'btex $'+floattostrf(3,ffFixed,0,0)+'$ etex scaled 0.8');



      beg:=b.xr*be/en;





      h1:=b.xr*(en-be)/(en*v1.Length);

      for i:=0 to v1.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*v1.Values[i]/4,
                       beg+i*h1,b.yr*v1.Values[i]/4,1,0,0,0,false);


      h1:=4/(sqrt(3)*ln(2));
      drawcol(f,a,b,beg,h1*b.yr/4,
                       b.xr,h1*b.yr/4,1,0,1,0,false);

      dotlabelepsabcol(f,a,b,0,h1*b.yr/4,0,0,0,4,'btex $4 \over {\sqrt{3}\ln{2}}$ etex scaled 0.8');



     endmp(f);
     compil(s);  writeln('end');
end;

procedure testsigmaW;
 var mv,m1:TMtx; v1,v2:TVec;
     sm,samp,pp:integer;
     be,en:Extended;
     i:integer;
     mu, sigma:Double;
begin
  CreateIt(mv,m1);  CreateIt(v1,v2);

    sm:=100;  be:=-1; en:=4;  samp:=800;  pp:=200;

    mv.Size(samp,100,false);  genmv3_Walsh(mv,be,en,sm);

    v1.Size(samp,false);  m1.Size(samp,1,false);

    v2.Size(mv.Cols,false);

    for i:=0 to mv.Cols-1 do
      begin
        m1.Copy(mv,0,i,0,0,samp,1);  v1.Copy(m1);
        Normalfit(v1,mu,sigma);
        writeln(mu:5:5,' ',sqr(4*sm*sigma*ln(2)):5:5);

        v2.Values[i]:=4*sm*sigma;
      end;

    drawarraysigmaW(v2,be,en,'W_sigma_'+inttostr(sm)+'_'+inttostr(samp)+'_'+inttostr(pp));

  FreeIt(mv,m1);  FreeIt(v1,v2); readln;
end;


procedure testmac;
 var len,i:integer;
     alp:Extended;
begin
  len:=100; alp:=4.1;
  writeln((3-mac2(alp,len)){/lnp(alp,len)}*power(len,alp-3){ln(len)}:3:3);
  for i:=1 to 20 do begin
   alp:=3+i/10; writeln(alp:3:3,' ',3-ln(3-mac2(alp,len))/ln(len):3:3);
  end;
  writeln;
  for i:=1 to 10 do begin
   alp:=5+i/10; writeln(alp:3:3,' ',(alp-5)*power(len,2)*(3-mac2(alp,len)):3:3);
  end;
  readln;
end;

procedure testhist2W;
 var v,v1,v2,v3:TVec;
     alp,mean,vary,t1,t0,be,en,h,mult:Extended;
     mean1,vary1:Double;
     sm,i,N,st:integer;
begin
  CreateIt(v,v1,v2,v3);

  alp:=-0.8;

  t0:=-alp;



  sm:=100;

  N:=8000;

  v.Size(N,false);



    genv2_Walsh3a(v,alp,sm);



    normalfit(v,mean1,vary1);



    meand(v,mean,vary);

    Mult:=5*sqrt(vary)*power(sm,1);



    histogram(v,100,v1,v2,false,t0+Mult/power(sm,1),t0-Mult/power(sm,1));



    {writev(v1); writeln;
    writev(v2); writeln; }

    for i:=1 to v2.Length-3 do
     writeln(power(sm,1)*(v2.Values[i]-t0):3:3,' ',v1.Values[i]/N:3:3,' ',
         -NormalCDF(v2.Values[i],mean,sqrt(vary))+normalcdf(v2.Values[i+1],mean,sqrt(vary)):3:3);

    writeln;


    sm:=2*sm;





    genv2_Walsh3a(v,alp,sm);



    normalfit(v,mean1,vary1);



    meand(v,mean,vary);



    histogram(v,100,v3,v2,false,t0+Mult/power(sm,1),t0-Mult/power(sm,1));

    {writev(v3); writeln;
    writev(v2); writeln;}

    for i:=1 to v2.Length-3 do
     writeln(power(sm,1)*(v2.Values[i]-t0):3:3,' ',v3.Values[i]/N:3:3,' ',
         -NormalCDF(v2.Values[i],mean,sqrt(vary))+normalcdf(v2.Values[i+1],mean,sqrt(vary)):3:3);

    writeln;

    v1.Scale(1/N); v3.Scale(1/N);

    v.Size(400,false);   v.Scale(0);

    be:=(v2.Values[0]+v2.Values[0])/2;    //be:=(be-t0)*sm;

    en:=(v2.Values[v2.Length-1]+v2.Values[v2.Length-1])/2;  //en:=(en-t0)*sm;

    h:=(en-be)/400;

    for I := 0 to v.Length-1 do v.Values[i]:=NormalPDF(be+h*i{+h*8},mean,sqrt(vary))*4*h;


    //for I := 0 to v.Length-1 do v.Values[i]:=(NormalCDF(be+h*i+h,0,sm*sqrt(vary))
    //                                         -NormalCDF(be+h*i,0,sm*sqrt(vary)))/h;

    drawarrayv2(v,v1,v3,4*(v2.Values[0]-t0)/(v2.Values[v2.Length-1]-t0),4,'compare08aaa0dW');

  FreeIt(v,v1,v2,v3);   readln;
end;


procedure testsearch;
 var v:TVec;
     i:integer;
begin
  CreateIt(v);
    v.Size(100,false);
    for i:=0 to v.Length-1 do  v.Values[i]:=i;
    v.BinarySearch(10.7,i);
    writeln(i);
  FreeIt(v); readln;
end;

procedure testbin;
 var p,q,p1:extended;
     i,k,N:integer;
begin
  q:=0;
  for i:=1 to 20 do begin
   p:=0; N:=i*5;
   for k:=1 to N div 2 do p:=p+sqr(binomial(2*k,k)/power(4,k))*(N-2*k);
   p1:=(p*pi/N-ln(N))+1+ln(2);
   writeln(N,': ',p:3:3,' ',p/(N*ln(N)):5:5,' ',q-p/(N*ln(N)):5:5,'   ',1/pi:5:5,'   ',p1:5:5);
   q:=p/(N*ln(N));
  end;
  readln;
end;



end.
