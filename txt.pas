unit txt;

interface

uses
  System.SysUtils, System.Types,
  math387, MtxVec,
  metapost, statistics, mvutils;

procedure testfft;

procedure testenerg;

procedure txttest;

procedure txttest1;

procedure testchangesize;

procedure testchangesizeR;

procedure testchangesizeRdis;

procedure testchangesizeRdis1;

procedure drawleen2;

procedure averag;

procedure averag_ln;

procedure drawleen2_ln;

procedure testallyears_ln;

procedure testallyears;

procedure testdisstr;

procedure drawleen;

procedure drawleen1;

procedure testzigzag;

procedure txttest2;

procedure txttest2a;

procedure txttest3;

procedure txttest3_re;

procedure testfit;

procedure testfit_re;

procedure testfit2_re;

procedure alpval_re;

procedure alpval;

function fitalp(const v:TVec; var alp,c:Extended):Extended;
function fite(x,alp,E,c:Extended):Extended;

procedure testtxt;

procedure testtxt1;

implementation

procedure determine_size(s:string; var row,col:integer);
 var r,str,str1:string;
     j,i,i1,j1:integer;
     f:TextFile;
     z:TCPlx;
     m:TMtx;
begin
  AssignFile(f,s); Reset(f);
  j1:=0; i1:=0;

  r:='), (';

  while not Eof(f) do
  begin
    Readln(f,str);

    j1:=0;

    while str <> '' do
    begin
      j := Pos(r,str);
      if j=0 then
        j := Length(str) + 1;
        str1:=Copy(Str,1,j-1);
      if str1[1]=' ' then Delete(Str1,1,2);
      if str1[length(str1)]=')' then Delete(Str1,length(str1),1);

      i:=Pos('j',str1); str1[i]:='i';

      //write(z.Re:4:4{,'+i',z.Im:4:4},' ');
      Delete(Str,1,j+length(r)-1);
      j1:=j1+1;
    end;
   i1:=i1+1; //writeln;
  end;

  col:=j1; row:=i1;

  CloseFile(f);
end;

procedure determine_size_re(s:string; var row,col:integer);
 var r,str,str1:string;
     j,i,i1,j1:integer;
     f:TextFile;
     z:TCPlx;
     m:TMtx;
begin
  AssignFile(f,s); Reset(f);
  j1:=0; i1:=0;

  r:=','; //  r:=' ';

  while not Eof(f) do
  begin
    Readln(f,str);

    j1:=0;

    while str <> '' do
    begin
      j := Pos(r,str);
      if j=0 then
        j := Length(str) + 1;
        str1:=Copy(Str,1,j-1);
      if str1[1]=' ' then Delete(Str1,1,2);
      Delete(Str,1,j+length(r)-1);
      j1:=j1+1;
    end;
   i1:=i1+1; //writeln;
  end;

  col:=j1; row:=i1;

  CloseFile(f);
end;

procedure filetoarr(s:string; ii,jj:integer;scale:Extended; var mm:TMtx);
 var r,str,str1:string;
     j,i,i1,j1:integer;
     f:TextFile;
     z:TCPlx;
     m:TMtx;
begin
  AssignFile(f,s); Reset(f);

  j1:=0; i1:=0;

  r:='), (';

  CreateIt(m);

  m.Complex:=true; m.Cols:=jj; m.Rows:=ii;

  while not Eof(f) do
  begin
    Readln(f,str);

    j1:=0;

    while str <> '' do
    begin
      j := Pos(r,str);
      if j=0 then
        j := Length(str) + 1;
        str1:=Copy(Str,1,j-1);
      if str1[1]=' ' then Delete(Str1,1,2);
      if str1[length(str1)]=')' then Delete(Str1,length(str1),1);

      i:=Pos('j',str1); str1[i]:='i';
      z:=StrToCPlx(str1)*scale;   m.CValues[i1,j1]:=z;
      //write(z.Re:4:4{,'+i',z.Im:4:4},' ');
      Delete(Str,1,j+length(r)-1);
      j1:=j1+1;
    end;
   i1:=i1+1; //writeln;
  end;

  mm.Copy(m);

  m.SaveToFile(s+'.mat');

  FreeIt(m);

  CloseFile(f);



  writeln('original size: ',i1,' ',j1);
end;

procedure filetoarr_re(s:string; ii,jj:integer;scale:Extended; var mm:TMtx);
 var r,str,str1:string;
     j,i,i1,j1:integer;
     f:TextFile;
     z:Extended;
     m:TMtx;
begin
  AssignFile(f,s); Reset(f);

  j1:=0; i1:=0;

  r:=',';  // r:=' ';

  CreateIt(m);

  m.Complex:=false; m.Cols:=jj; m.Rows:=ii;

  while not Eof(f) do
  begin
    Readln(f,str);

    j1:=0;

    while str <> '' do
    begin
      j := Pos(r,str);
      if j=0 then
        j := Length(str) + 1;
        str1:=Copy(Str,1,j-1);
      if str1[1]=' ' then Delete(Str1,1,2);

      z:=StrTofloat(str1)*scale;   m.Values[i1,j1]:=z;
     // writeln(z); readln;
      Delete(Str,1,j+length(r)-1);
      j1:=j1+1;
    end;
   i1:=i1+1; //writeln;
  end;

  mm.Copy(m);

  m.SaveToFile(s+'.mat');

  FreeIt(m);

  CloseFile(f);



  writeln('original size: ',i1,' ',j1);
end;


procedure zigzagSq(x,y:Extended; var n,m:integer; var xn,yn:Extended);
begin
  n:=floor(x); m:=floor(y);
  xn:=x-n; yn:=y-m;
end;

function eventr(nx,ny:Extended):integer;
begin
  if (nx<=1/2)and(ny>=2*nx) then Result:=-1
  else if (nx>=1/2)and(ny>=2-2*nx) then Result:=1 else Result:=0;
end;

function oddtr(nx,ny:Extended):integer;
begin
  Result:=eventr(nx,1-ny);
end;

procedure zigzagFin(x,y:Extended; var n,m:integer);
 var nx,ny:Extended;
begin
  zigzagsq(x,y,n,m,nx,ny);
  if m mod 2 = 0 then n:=2*n+eventr(nx,ny) else n:=2*n+oddtr(nx,ny);

end;

procedure fitn(var n:integer; m:integer);
begin
  if n<0 then n:=0;
  if n>m then n:=m;
end;

function fitnn(n:integer; m:integer):boolean;
begin
  Result:= (n<0)or(n>m);
end;

procedure changesizeZ(const m:TMtx; nr,nc:integer; var m1:TMtx);
 var i,j:integer;
     x,y:Extended;
     n1,n2:integer;
begin
  m1.Size(nr,nc,false);  m1.Scale(0);
  for i:=0 to nr-1 do
   for j := 0 to nc-1 do
     begin
       x:=m.cols*j/nc; y:=m.Rows*i/nr;
       zigzagFin(x,y,n1,n2);
       {fitn(n1,m.Cols-1); fitn(n2,m.Rows-1);
       m1.Values[i,j]:=m.Values[n2,n1]; }
       if (fitnn(n1,m.Cols-1))or(fitnn(n2,m.Rows-1)) then m1.Values[i,j]:=0
                           else m1.Values[i,j]:=m.Values[n2,n1];;
     end;
end;

procedure drawarrayv(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $E$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,2,2)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*v1.Length);

      t:=v1.Max;



     for i:=0 to v1.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*v1.Values[i]/t,
                       beg+i*h1,b.yr*v1.Values[i]/t,1,0,0,0,false);

     endmp(f);
     compil(s);  writeln('end');
end;

procedure drawarrayvf(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
      alp,cc,E:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $E$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,3,1)+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*v1.Length);

      t:=v1.Max;



     for i:=0 to v1.length-2 do
         drawcol(f,a,b,beg+i*h1,b.yr*v1.Values[i]/t,
                       beg+i*h1,b.yr*v1.Values[i]/t,1.5,0,0,0,false);

     fitalp(v1,alp,cc);     E:=v1.Values[v1.Length-1];

     for i:=1 to v1.length-2 do
         drawcol(f,a,b,beg+i*h1,b.yr*fite(i,alp,E,cc)/t,
                       beg+(i+1)*h1,b.yr*fite(i+1,alp,E,cc)/t,1,0,1,0,false);





     endmp(f);
     compil(s);  writeln('end');
end;

procedure drawarrayvfln(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
      alp,cc,E:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $\ln k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $\ln E(k,\infty)$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,3,1)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*ln(v1.Length));







     fitalp(v1,alp,cc);     E:=v1.Values[v1.Length-1];  v1.Values[v1.Length-1]:=0;



      t:=-ln(E-v1.Max); {t:=ln(E-v1.min);}  v1.Values[v1.Length-1]:=E;

     for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(E-v1.Values[i])/t+b.yr,
                       beg+ln(i)*h1,b.yr*ln(E-v1.Values[i])/t+b.yr,1.5,0,0,0,false);



     for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*(ln(cc)-alp*ln(i))/t+b.yr,
                       beg+ln(i+1)*h1,b.yr*(ln(cc)-alp*ln(i+1))/t+b.yr,1,0,1,0,false);


       

     endmp(f);
     compil(s);  writeln('end');
end;

procedure drawarrayvfln_re(const v1:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t:Extended;
      alp,cc,E:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $\ln k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $\ln E(k,\infty)$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,3,1)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*ln(v1.Length));







     fitalp(v1,alp,cc);     E:=v1.Values[v1.Length-1];  v1.Values[v1.Length-1]:=0;



      {t:=-ln(E-v1.Max);} t:=ln(E-v1.min);  v1.Values[v1.Length-1]:=E;

     for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(E-v1.Values[i])/t{+b.yr},
                       beg+ln(i)*h1,b.yr*ln(E-v1.Values[i])/t{+b.yr},1.5,0,0,0,false);



     for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*(ln(cc)-alp*ln(i))/t{+b.yr},
                       beg+ln(i+1)*h1,b.yr*(ln(cc)-alp*ln(i+1))/t{+b.yr},1,0,1,0,false);




     endmp(f);
     compil(s);  writeln('end');
end;

procedure drawarrayvf2ln_re(const v1,v2:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t,t1,t2:Extended;
      alp,cc,E1,E2:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $\ln k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $\ln E(k,\infty)$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,3,1)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*ln(v1.Length));







     (*fitalp(v1,alp,cc); *)


     E1:=v1.Values[v1.Length-1];  v1.Values[v1.Length-1]:=0;
     {t:=-ln(E-v1.Max);} t1:=ln(E1-v1.min);  v1.Values[v1.Length-1]:=E1;

     E2:=v2.Values[v2.Length-1];  v2.Values[v2.Length-1]:=0;
     {t:=-ln(E-v1.Max);} t2:=ln(E2-v2.min);  v2.Values[v2.Length-1]:=E2;

     t:=max(t1,t2);

     for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(E1-v1.Values[i])/t{+b.yr},
                       beg+ln(i)*h1,b.yr*ln(E1-v1.Values[i])/t{+b.yr},1.5,0.7,0,0,false);


     for i:=3 to v2.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(E2-v2.Values[i])/t{+b.yr},
                       beg+ln(i)*h1,b.yr*ln(E2-v2.Values[i])/t{+b.yr},1.5,0,0,0.7,false);


     (*for i:=3 to v1.length-2 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*(ln(cc)-alp*ln(i))/t{+b.yr},
                       beg+ln(i+1)*h1,b.yr*(ln(cc)-alp*ln(i+1))/t{+b.yr},1,0,1,0,false);

     *)


     endmp(f);
     compil(s);  writeln('end');
end;

procedure testzigzag;
 var x,y:Extended;
     n,m:integer;
begin
  x:=2.2; y:=1.05;
  zigzagFin(x,y,n,m);
  writeln(n,' ',m); readln;
end;

procedure txttest2;
 var row,col:integer;
     m,m1:TMtx;
     s:string;
     t:Extended;
begin
  CreateIt(m,m1);
    s:='triangvel_v0_k3_id_114x48.csv';
    determine_size(s,row,col);
    filetoarr(s,row,col,1000,m);
    m1.RealPart(m);
    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    writeln('original energy ',energym(m)/2:5:5);

    {writeln;
     writeln(m.Values[1,0],' ',m.Values[1,47]);
    writeln; }

    changesizeZ(m,1*2048,1*1024,m1);

    writeln('after energy ',energym(m1):5:5);

    reduce(m1,1*256,1*256,m);

     writeln('reduce16 energy ',energym(m):5:5);

    writeln;

    writeln('file ',s);
    writeln('computed ',alpha4(m,t):3:3);
    writeln('analytic ',-mac2(3,row):3:3);
  FreeIt(m,m1); readln;
end;

procedure txttest2a;
 var row,col:integer;
     m,m1:TMtx;
     s:string;
     t:Extended;
     i:integer;
begin
  CreateIt(m,m1);
    s:='triangvel_v0_k3_id_114x48.csv';
    determine_size(s,row,col);
    filetoarr(s,row,col,1000,m);
    m1.RealPart(m);
    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    writeln('original energy ',energym(m)/2:5:5);

    t:=energym(m)/2;

    changesizeZ(m,4*4096,4*2048,m1);

    writeln('after energy ',energym(m1):5:5);

    t:=energym(m1)/2;

    for i:=1 to 11 do
      begin
        reduce(m1,2,2,m);
        writeln(13-i,': ',ln(t-energym(m)/2)/ln(2):5:5);
        m1.Copy(m);
      end;


  FreeIt(m,m1); readln;
end;

function fite(x,alp,E,c:Extended):Extended;
begin
  Result:=E-c/power(x,alp);
end;

function fitnor(const v:TVec; alp,c:Extended):Extended;
 var i:integer;
     E:extended;
begin
  E:=v.Values[v.Length-1];
    Result:=0;
    for i:=1 to v.Length-2 do Result:=Result+sqr(v.Values[i]-fite(i,alp,E,c));
end;

function fitc(const v:TVec; alp:Extended; var c:Extended):Extended;
 var i:integer;
     h,nor,norn:Extended;
begin
  c:=0;
  norn:=fitnor(v,alp,c); h:=0.01;
  repeat
    nor:=norn;
    c:=c+h;
    norn:=fitnor(v,alp,c);
  until norn>nor;
  Result:=nor; c:=c-h;
end;

function fitalp(const v:TVec; var alp,c:Extended):Extended;
 var i:integer;
     h,nor,norn:Extended;
begin
  alp:=0;
  norn:=fitc(v,alp,c); h:=0.01;
  repeat
    nor:=norn;
    alp:=alp+h;
    norn:=fitc(v,alp,c);
  until norn>nor;
  Result:=nor; alp:=alp-h;
end;

procedure testfit;
 var v:TVec;
     alp,c,nor,E:Extended;
     i,j,N:integer;
     s:string;
begin
  CreateIt(v);
    s:='triangvel_u0_k53_id_114x48';

      s:='u_easy4_1956_d0_114x50';

    v.LoadFromFile(s+'.vec'{'scalesv1v.vec'});

    {alp:=1.5;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end; }

    writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);
     writeln('analytic ',-mac2(3,53):3:3); writeln;

    E:=v.Values[v.Length-1];   N:=v.Length-1;

    drawarrayvf(v,1,4*N,'tt_'+s);

    drawarrayvfln(v,1,4*N,'ttln_'+s);

    {for i:=1 to v.Length-2 do v.Values[i]:=v.Values[i]-fite(i,alp,0,c);

    writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);

    writeln; }

   { alp:=2;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end;      }

  FreeIt(v);  readln;
end;

procedure testfit_re;
 var v:TVec;
     alp,c,nor,E:Extended;
     i,j,N:integer;
     s:string;
begin
  CreateIt(v);
    s:='triangvel_u0_k3_id_114x48';

     s:='u_leith_1956_d0_114x50';

    v.LoadFromFile(s+'.vec'{'scalesv1v.vec'});

    {alp:=1.5;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end; }

    writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);
     writeln('analytic ',-mac2(3,53):3:3); writeln;

    E:=v.Values[v.Length-1];   N:=v.Length-1;

    drawarrayvf(v,1,4*N,'tt_'+s);

    drawarrayvfln_re(v,1,4*N,'ttln_'+s);

    {for i:=1 to v.Length-2 do v.Values[i]:=v.Values[i]-fite(i,alp,0,c);

    writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);

    writeln; }

   { alp:=2;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end;      }

  FreeIt(v);  readln;
end;

procedure testfit2_re;
 var v1,v2:TVec;
     alp,c,nor,E:Extended;
     i,j,N:integer;
     s1,s2:string;
begin
  CreateIt(v1,v2);
    s1:='u_easy4_1956_d0_114x50R';

     s2:='u_leith_1956_d0_114x50R';

    v1.LoadFromFile(s1+'.vec'{'scalesv1v.vec'});

    v2.LoadFromFile(s2+'.vec'{'scalesv1v.vec'});

    {alp:=1.5;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end; }

    (*writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);
     writeln('analytic ',-mac2(3,53):3:3); writeln; *)

    (*E:=v.Values[v.Length-1];*)   N:=v1.Length-1;

    (*drawarrayvf(v,1,4*N,'tt2_'+s); *)

    drawarrayvf2ln_re(v1,v2,1,4*N,'tt2ln_'+'easy_leith_uR');

    {for i:=1 to v.Length-2 do v.Values[i]:=v.Values[i]-fite(i,alp,0,c);

    writeln; writeln(fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);

    writeln; }

   { alp:=2;

    for i:=1 to 100 do begin
      c:=i/10;
      writeln(c:3:3,' ',fitnor(v,alp,c):5:5);
    end;      }

  FreeIt(v1,v2);  readln;
end;

procedure txttest3;
 var row,col,i,N:integer;
     m,m1,m2:TMtx;
     s:string;
     t:Extended;
     v,v1:TVec;
begin
  CreateIt(m,m1,m2);   CreateIt(v,v1);
    s:='triangvel_u0_k3_id_114x48';
    determine_size(s+'.csv',row,col);
    filetoarr(s+'.csv',row,col,100,m);
    m1.RealPart(m);
    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    N:=100; v.Size(N+1,false);  v1.Size(N,false);

    v.Values[0]:=0;

    for i:=1 to N do begin

    changesizeZ(m,i*200,i*100,m1);

    //writeln('after energy ',energym(m1):5:5);

    reduce(m1,50,25,m2);  v.Values[i]:=energym(m2);




    v1.Values[i-1]:=ln(abs(energym(m)/2-v.Values[i]-0*0.06))/ln(i+1);

    writeln(i,' ',v.Values[i]:5:5,' ',v1.Values[i-1]:5:5,' ',energym(m)/2-0.7/power(i,0.3):5:5);

    end;

    writeln;

    writeln('original energy ',energym(m)/2:5:5);

    writeln;

    writeln('file ',s);

    drawarrayv(v,1,4*N,s);   v1.Add(1) ;

    //drawarrayv(v1,1,4*N,'twomeshlnv');

     v.Values[N]:=energym(m)/2; v.SaveToFile(s+'.vec');

    //writeln('computed ',alpha4(m,t):3:3);
    //writeln('analytic ',-mac2(3,row):3:3);
  FreeIt(m,m1,m2); FreeIt(v,v1); readln;
end;

procedure txttest3_re;
 var row,col,i,N:integer;
     m,m1,m2:TMtx;
     s:string;
     t:Extended;
     v,v1:TVec;
begin
  CreateIt(m,m1,m2);   CreateIt(v,v1);
    s:='v_easy4_1956_d0_114x50';

    determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,100,m);
    m1.copy(m);
    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    writeln('resize and averaging alpha ',alpha4(m,t):3:3);

    N:=100; v.Size(N+1,false);  v1.Size(N,false);

    v.Values[0]:=0;

    for i:=1 to N do begin

    changesizeZ(m,i*179,i*89,m1);            // 200 100   or 245 115

    //writeln('after energy ',energym(m1):5:5);

    reduce(m1,159,79,m2);  v.Values[i]:=energym(m2);    // 50 25  or  49 23




    v1.Values[i-1]:=ln(abs(energym(m)/2-v.Values[i]-0*0.06))/ln(i+1);

    writeln(i,' ',v.Values[i]:5:5,' ',v1.Values[i-1]:5:5,' ',energym(m)/2-0.7/power(i,0.3):5:5);

    end;

    writeln;

    writeln('original energy ',energym(m)/2:5:5);

    writeln;

    writeln('file ',s);

    drawarrayv(v,1,4*N,s);   v1.Add(1) ;

    //drawarrayv(v1,1,4*N,'twomeshlnv');

     v.Values[N]:=energym(m)/2; v.SaveToFile(s+'.vec');

    //writeln('computed ',alpha4(m,t):3:3);
    //writeln('analytic ',-mac2(3,row):3:3);
  FreeIt(m,m1,m2); FreeIt(v,v1); readln;
end;

procedure alpval_re;
 var row,col,i,N:integer;
     m,m1,m2:TMtx;
     s:string;
     t,alp,c,E:Extended;
     v,v1:TVec;
begin
  CreateIt(m,m1);   CreateIt(v);
    s:='u_easy4_1956_d0_114x50';
    determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,100,m);
    m1.copy(m);

    N:=48;

    m.Complex:=false; m.Rows:=N; m.Cols:=48;
    m.copy(m1,0,0,0,0,N,48);

    writeln('resize and averaging alpha ',alpha4(m,t):3:3);
    writeln('inverse resize and averaging alpha ',-inv_mac2(-alpha4(m,t),m.Cols):3:3);

    v.LoadFromFile(s+'.vec'{'scalesv1v.vec'});

   E:=v.Values[v.Length-1];

   writeln; writeln('energy ',E:5:5);
   writeln('fiting norm constant and alpha_infty(positive) ',fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);
   writeln('inverse local alpha ',-inv_mac2(1+alp,m.Cols):5:5);





  FreeIt(m,m1); FreeIt(v);    readln;
end;

procedure alpval;
 var row,col,i,N:integer;
     m,m1,m2:TMtx;
     s:string;
     t,alp,c,E:Extended;
     v,v1:TVec;
begin
  CreateIt(m,m1);   CreateIt(v);
    s:='triangvel_u0_k3_id_114x48';
    determine_size(s+'.csv',row,col);
    filetoarr(s+'.csv',row,col,100,m);
    m1.RealPart(m);

    N:=48;

    m.Complex:=false; m.Rows:=N; m.Cols:=48;
    m.copy(m1,0,0,0,0,N,48);

    writeln('resize and averaging alpha ',alpha4(m,t):3:3);
    writeln('inverse resize and averaging alpha ',-inv_mac2(-alpha4(m,t),m.Cols):3:3);

    v.LoadFromFile(s+'.vec'{'scalesv1v.vec'});

   E:=v.Values[v.Length-1];

   writeln; writeln('energy ',E:5:5);
   writeln('fiting norm constant and alpha_infty(positive) ',fitalp(v,alp,c):5:5,' ',c:5:5,' ',alp:5:5);
   writeln('inverse local alpha ',-inv_mac2(1+alp,m.Cols):5:5);





  FreeIt(m,m1); FreeIt(v);    readln;
end;

procedure txttest;
 var row,col:integer;
     m,m1:TMtx;
     s:string;
     t:Extended;
begin
  CreateIt(m,m1);
    s:='rectvel_v_k30_2.csv';
    determine_size(s,row,col);
    filetoarr(s,row,col,1000,m);
    m1.RealPart(m);
    writeln('file ',s);
    writeln('computed ',alpha4(m1,t)-1:3:3);
    writeln('analytic ',-mac2(3,row):3:3);
  FreeIt(m,m1); readln;
end;

procedure txttest1;
 var row,col:integer;
     m,m1:TMtx;
     s:string;
     t:Extended;
begin
  CreateIt(m,m1);
    s:='triangvel_v0_k53_id_114x48.csv';
    determine_size(s,row,col);
    filetoarr(s,row,col,1000,m);
    m1.RealPart(m);
    m.Complex:=false; m.Rows:=112{48}; m.Cols:=48;
    m.copy(m1,0,0,0,0,112{48},48);

    {writeln;
     writeln(m.Values[1,0],' ',m.Values[1,47]);
    writeln; }

    writeln('file ',s);
    writeln('computed ',alpha4(m,t):3:3);
    writeln('analytic ',-mac2(5/3,row):3:3);
  FreeIt(m,m1); readln;
end;

procedure testchangesize;
 var m,m1:TMtx;
     v,v1:TVec;
     s,s2:string;
     t,t1:Extended;
     row,col,i,j,k:integer;
     N:int64;
     f:TextFile;
      a,b,c:TReps;
begin
  CreateIt(m,m1); CreateIt(v,v1);
   s:='v_easy4_1956_d0_114x50';
    determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,1000,m);
    m1.copy(m);



    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    writeln(energym(m):3:3);  j:=15;

    N:=1; for i:=1 to j do N:=2*N;

    changesizeZ(m,N,N div 2,m1);

    

    v.Size(j,false);

    for i:=1 to j do
      begin

       v.Values[j-i]:=2*energym(m1);

        writeln(i,' ',v.Values[j-i]:3:3);

       reduce(m1,2,2,m);  m1.Copy(m);



      end;


       s:='v_leith_1956_d0_114x50';
    determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,1000,m);
    m1.copy(m);



    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    writeln(energym(m):3:3);  j:=15;

    N:=1; for i:=1 to j do N:=2*N;

    changesizeZ(m,N,N div 2,m1);

    v1.Size(j,false);

    for i:=1 to j do
      begin

       v1.Values[j-i]:=2*energym(m1);

        writeln(i,' ',v1.Values[j-i]:3:3);

       reduce(m1,2,2,m);  m1.Copy(m);



      end;

    writeln;


    writeln;

    k:=1;


    s2:='der_easy_leith_v';

    beginmp(f,s2);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $0$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $\ln k$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $\ln E(k)$ etex scaled 0.8');



    for i:=1 to j-1 do
      begin

       t:=v.Values[i]-v.Values[i-1];

       t:=ln(t)/ln(2)-i;

       t1:=v1.Values[i]-v1.Values[i-1];

       t1:=ln(t1)/ln(2)-i;

       writeln(i,' ',t:3:3,' ',t1:3:3);

       drawcol(f,a,b,b.xr*i/j,b.yr*(t+13)/26,b.xr*i/j,b.yr*(t+13)/26,1.5,0.7,0,0,false);

       drawcol(f,a,b,b.xr*i/j,b.yr*(t1+13)/26,b.xr*i/j,b.yr*(t1+13)/26,1.5,0,0,0.7,false);

      end;


  FreeIt(m,m1);  FreeIt(v,v1);

  endmp(f); compil(s2);

     readln;
end;

procedure testchangesizeR;
 var m,m1:TMtx;
     v,v1:TVec;
     s:string;
     t,t1,E:Extended;
     row,col,i,j,k:integer;
     N:int64;
begin
  CreateIt(m,m1); CreateIt(v,v1);
   s:='u_easy4_1956_d0_114x50';
    determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,100,m);
    m1.copy(m);



    m.Complex:=false; m.Rows:=96; m.Cols:=48;
    m.copy(m1,0,0,0,0,96,48);

    E:=energym(m);

    writeln(E:3:3);  j:=15;

    N:=1; for i:=1 to j do N:=2*N;

    changesizeZ(m,N,N div 2,m1);

    j:=150;

    v.Size(j-1,false);

    for i:=3 to j do
      begin
        changesizee(m1,i,i,m);
        v.Values[i-3]:=2*energym(m);
        writeln(i,': ',v.Values[i-3]:5:5);
      end;

    v.Values[j-2]:=E;

    v.SaveToFile(s+'R.vec');



  FreeIt(m,m1);  FreeIt(v,v1);      readln;
end;

procedure ftoar(s:string);
 var i,j:integer;
     f:TextFile;
     str:string;
     m:TMtx;
begin
  AssignFile(f,s); Reset(f);
  CreateIt(m);

  m.Size(114,50,false);

  i:=0; j:=0;
  while not Eof(f) do
  begin
    Readln(f,str);
    m.Values[i,j]:=StrToFloat(str);
    i:=i+1;
    if i=114 then begin i:=0; j:=j+1 end;
  end;

  for i:=0 to 113 do writeln(i,' ',m.Values[i,0]:5:5,' ',m.Values[i,1]:5:5,' ',m.Values[i,2]:5:5);

  CloseFile(f);
  FreeIt(m);
   readln;
end;

procedure largem(s:string; j:integer; var m,m1:TMtx);
 var row,col:integer;
     N,i:integer;

begin

  //ftoar(s+'.csv');

  determine_size_re(s+'.csv',row,col);
    filetoarr_re(s+'.csv',row,col,300,m);

    //m.LoadFromFile(s+'.csv.mat');

    m1.copy(m);



    m.Complex:=false; m.Rows:=114; m.Cols:=50;
    m.copy(m1,{7}0,0,0,0,114,50);

    N:=1; for i:=1 to j do N:=2*N;

    changesizeZ(m,N,N div 2,m1);
end;

procedure testchangesizeRdis;
 var m,m1,p,p1,mp:TMtx;
     v,v1:TVec;
     s,s1:string;
     t,t1,E:Extended;
     row,col,i,j,k:integer;
     N:int64;
begin
  CreateIt(m,m1,p,p1); CreateIt(v,v1);

  CreateIt(mp);

   s:='v_leith1956_365_114x50';
   s1:='vdis_leith1956_365_114x50';

   s:='anton\v_leith_1950_365';
   s1:='anton\vdis_leith_1950_365';

   j:=15;

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=150;

    v.Size(j-1,false);

    for i:=3 to j do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);
        mp.MulElem(m,p);
        v.Values[i]:=mp.Sum/(mp.Cols*mp.rows);
        writeln(i,': ',v.Values[i]:5:5);
      end;

   writeln;

   s:='u_leith1956_365_114x50';
   s1:='udis_leith1956_365_114x50';

   s:='anton\u_leith_1950_365';
   s1:='anton\udis_leith_1950_365';

   j:=15;

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=150;

    v1.Size(j-1,false);

    for i:=3 to j do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);
        mp.MulElem(m,p);
        v1.Values[i]:=mp.Sum/(mp.Cols*mp.rows);
        writeln(i,': ',v1.Values[i]:5:5);
      end;

   writeln;


   for i:=3 to j do
      begin

        writeln(i,': ',v1.Values[i]+v.Values[i]:5:5);
      end;

    //v.SaveToFile('tesdis.vec');

  FreeIt(mp);

  FreeIt(m,m1,p,p1);  FreeIt(v,v1);      readln;
end;

procedure testchangesizeRdis1;
 var m,m1,p,p1,mp,m2,p2,m3,p3:TMtx;
     v,v1:TVec;
     s,s1:string;
     t,t1,E:Extended;
     row,col,i,j,k:integer;
     N:int64;
begin
  CreateIt(m,m1,p,p1); CreateIt(v,v1);

  CreateIt(mp,m2,p2,m3);  CreateIt(p3);

   s:='v_leith1956_365_114x50';
   s1:='vdis_leith1956_365_114x50';

   s:='anton\v_leith_1950_365';
   s1:='anton\vdis_leith_1950_365';

   //s:='v_leith_1956_d0_114x50'; s1:=s;

   j:=15;

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=100;

    v.Size(j-1,false);

    for i:=1 to j-1 do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);

        changesizee(m,i*(i+1),i*(i+1),m2);
        changesizee(p,i*(i+1),i*(i+1),p2);

        changesizee(m1,i+1,i+1,m);
        changesizee(p1,i+1,i+1,p);

        changesizee(m,i*(i+1),i*(i+1),m3);
        changesizee(p,i*(i+1),i*(i+1),p3);

        m.sub(m3,m2); p.Sub(p3,p2);

        mp.MulElem(m,p);
        v.Values[i-1]:=mp.Sum/(mp.Cols*mp.rows);
        writeln(i,': ',v.Values[i]:5:5);
      end;

   writeln;

   s:='u_leith1956_365_114x50';
   s1:='udis_leith1956_365_114x50';

   s:='anton\u_leith_1950_365';
   s1:='anton\udis_leith_1950_365';

   //s:='u_leith_1956_d0_114x50'; s1:=s;

   j:=15;

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=100;

    v1.Size(j-1,false);

    for i:=1 to j-1 do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);

        changesizee(m,i*(i+1),i*(i+1),m2);
        changesizee(p,i*(i+1),i*(i+1),p2);

        changesizee(m1,i+1,i+1,m);
        changesizee(p1,i+1,i+1,p);

        changesizee(m,i*(i+1),i*(i+1),m3);
        changesizee(p,i*(i+1),i*(i+1),p3);

        m.sub(m3,m2); p.Sub(p3,p2);


        mp.MulElem(m,p);
        v1.Values[i-1]:=mp.Sum/(mp.Cols*mp.rows);
        writeln(i,': ',v1.Values[i]:5:5);
      end;

   writeln;


   for i:=0 to j-2 do
      begin

        writeln(i,': ',v1.Values[i]+v.Values[i]:5:5);
      end;

     v.Add(v1);

    v.SaveToFile('anton\leith_1950_365.vec');

  FreeIt(mp,m2,p2,m3);  FreeIt(p3);

  FreeIt(m,m1,p,p1);  FreeIt(v,v1);      readln;
end;


procedure drawarrayvln_re(const v1,v2:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t,t1,t2:Extended;
      alp,cc,E1,E2:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.3; c.yr:=b.yr+0.3;


      for i:=1 to 19 do
      begin
        drawcol(f,a,b,c.xr*i/20,0,c.xr*i/20,c.yr,0.5,0.9,0.9,0.9,false);
      end;

     for j:=1 to 19 do
     begin
       drawcol(f,a,b,c.xl,c.yr*j/20,c.xr,c.yr*j/20,0.5,0.9,0.9,0.9,false);
     end;


     t1:=v1.Max; t2:=v2.Max;



     t:=max(ln(t1),ln(t2));

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,c.yl,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $2000$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $x,\,{\rm km}$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $E,\,{{\rm m}^2\over{\rm s}^2}$ etex scaled 0.8');  //,\ {{\rm m}^2\over{\rm s}^2}

      dotlabelepsabcol(f,a,b,b.xr*ln(40)/ln(100),0,0,0,0,6,'btex $'+'50'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,b.xr*ln(10)/ln(100),0,0,0,0,6,'btex $'+'200'+'$ etex scaled 0.8');

       dotlabelepsabcol(f,a,b,b.xr*ln(20)/ln(100),0,0,0,0,6,'btex $'+'100'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,b.xr*ln(80)/ln(100),0,0,0,0,6,'btex $'+'25'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,b.xr*ln(5)/ln(100),0,0,0,0,6,'btex $'+'400'+'$ etex scaled 0.8');

       dotlabelepsabcol(f,a,b,b.xr*ln(2)/ln(100),0,0,0,0,6,'btex $'+'1000'+'$ etex scaled 0.8');



     (* dotlabelepsabcol(f,a,b,0,b.yr*ln(v2.max/1.75)/ln(v1.max),0,0,0,4,'btex $'+{floattostrf(v1.Max/2,ffFixed,2,2)}
                                                                          '2^{-1}'+'$ etex scaled 0.8');


      dotlabelepsabcol(f,a,b,0,b.yr*ln(4*v2.max/3.5)/ln(v1.max),0,0,0,4,'btex $'+{floattostrf(v1.Max/2,ffFixed,2,2)}
                                                                          '2^0'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr*ln(1*v2.max/3.5)/ln(v1.max),0,0,0,4,'btex $'+{floattostrf(v1.Max/2,ffFixed,2,2)}
                                                                          '2^{-2}'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr*ln(0.5*v2.max/3.5)/ln(v1.max),0,0,0,4,'btex $'+{floattostrf(v1.Max/2,ffFixed,2,2)}
                                                                          '2^{-3}'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr*ln(0.25*v2.max/3.5)/ln(v1.max),0,0,0,4,'btex $'+{floattostrf(v1.Max/2,ffFixed,2,2)}
                                                                          '2^{-4}'+'$ etex scaled 0.8');    *)


      dotlabelepsabcol(f,a,b,0,b.yr*ln(v1.max)/(1.0*ln(v1.max)),0,0,0,4,'btex $'+
                                                                          '6\cdot10^{-3}'+'$ etex scaled 0.8');


      dotlabelepsabcol(f,a,b,0,b.yr*ln(v1.max/10)/(1.0*ln(v1.max)),0,0,0,4,'btex $'+
                                                                          '6\cdot10^{-4}'+'$ etex scaled 0.8');

      dotlabelepsabcol(f,a,b,0,b.yr*ln(v1.max/100)/(1.0*ln(v1.max)),0,0,0,4,'btex $'+
                                                                          '6\cdot10^{-5}'+'$ etex scaled 0.8');

      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*ln(v1.Length));





      t1:=v1.Max; t2:=v2.Max;



     t:=max(ln(t1),ln(t2));    t:=t*1.0;

     for i:=1 to v1.length-1 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(v1.Values[i])/t{+b.yr},
                       beg+ln(i)*h1,b.yr*ln(v1.Values[i])/t{+b.yr},2.5,0.0,0,0.7,false);


     for i:=1 to v2.length-1 do
         drawcol(f,a,b,beg+ln(i)*h1,b.yr*ln(v2.Values[i])/t{+b.yr},
                       beg+ln(i)*h1,b.yr*ln(v2.Values[i])/t{+b.yr},2.5,0.7,0,0.0,false);


     drawcol(f,a,b,2.5,
                       3,3.5,2,1.0,0.0,0,0,false);
                       labelepsabcol(f,a,b,3,2.5,0,0,0,5,'btex $k_{\rm F}^{-3}$ etex scaled 0.8');


     endmp(f);
     compil(s);  writeln('end');     readln;
end;

procedure drawleen;
 var v,v1:TVec;
begin
  CreateIt(v,v1);
    v.LoadFromFile('easy4_1956_d0_114x50.vec');
    v1.LoadFromFile('leith_1956_d0_114x50.vec');
    drawarrayvln_re(v,v1,0,1,'lnenel');
  FreeIt(v,v1);
end;

procedure drawarrayv_re(const v1,v2:Tvec; be,en:Extended; s:string);
  var f:TextFile;
      a,b,c:TReps;
      i,j,k:integer;
      beg,h,h1,t,t1,t2,tm1,tm2,tm:Extended;
      alp,cc,E1,E2:Extended;
begin

  beginmp(f,s);


      a.xl:=0; a.yl:=0; a.xr:=6; a.yr:=6;
      b.xl:=0; b.yl:=0; b.xr:=4; b.yr:=4;
      c.xl:=0; c.yl:=0; c.xr:=b.xr+0.1; c.yr:=b.yr/2+0.1;

      for i:=1 to 19 do
      begin
        drawcol(f,a,b,c.xr*i/20,-c.yr,c.xr*i/20,c.yr,0.5,0.9,0.9,0.9,false);
      end;

     for j:=1 to 19 do
     begin
       drawcol(f,a,b,c.xl,-c.yr+c.yr*j/10,c.xr,-c.yr+c.yr*j/10,0.5,0.9,0.9,0.9,false);
     end;

      drawarrowcol(f,a,b,c.xl,c.yl,c.xr,c.yl,0.5,0,0,0,false);
      drawarrowcol(f,a,b,c.xl,-c.yr,c.xl,c.yr,0.5,0,0,0,false);

      dotlabelepsabcol(f,a,b,b.xl,b.yl,0,0,0,6,'btex $2000$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xr,c.yl,0,0,0,6,'btex $x,\,{\rm km}$ etex scaled 0.8');

      labelepsabcol(f,a,b,c.xl,c.yr,0,0,0,4,'btex $E_{\rm dis},\,{{\rm m}^2\over{\rm s}^3}$ etex scaled 0.8');




      //dotlabelepsabcol(f,a,b,b.xr*(en+be)/(2*en),0,0,0,0,6,'btex $'+floattostrf((en+be)/2,ffFixed,3,1)+'$ etex scaled 0.8');

      //dotlabelepsabcol(f,a,b,0,b.yr/2,0,0,0,4,'btex $'+floattostrf(v1.Max/2,ffFixed,2,2)+'$ etex scaled 0.8');


      beg:=b.xr*be/en;

      h1:=b.xr*(en-be)/(en*v1.Length);





      t1:=v1.Max; t2:=v2.Max;

      tm1:=v1.Min; tm2:=v2.Min;

      tm:=max(abs(tm1),abs(tm2));

     t:=max(t1,t2);

     t:=tm+t;

     for i:=0 to v1.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*(v1.Values[i]{+tm})/t,
                       beg+i*h1,b.yr*(v1.Values[i]{+tm})/t,2.5,0.0,0,0.7,false);


     for i:=0 to v2.length-1 do
         drawcol(f,a,b,beg+i*h1,b.yr*(v2.Values[i]{+tm})/t,
                       beg+i*h1,b.yr*(v2.Values[i]{+tm})/t,2.5,0.7,0,0.0,false);





     dotlabelepsabcol(f,a,b,c.xr/2,0,0,0,0,6,'btex $'+inttostr(40)+'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,c.xr/4,0,0,0,0,6,'btex $'+inttostr(80)+'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,3*c.xr/4,0,0,0,0,6,'btex $'+inttostr(28)+'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,0,c.yr*0.45,0,0,0,4,'btex $'+
     //floattostrf({v1.Max}0.000000332,{ffFixed}ffExponent,1,1)
     '1.5\cdot10^{-7}'
     +'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,0,-c.yr*0.45,0,0,0,4,'btex $'+
     '-1.5\cdot10^{-7}'
     +'$ etex scaled 0.8');

     dotlabelepsabcol(f,a,b,0,-c.yr*0.9,0,0,0,4,'btex $'+
     '-3\cdot10^{-7}'
     +'$ etex scaled 0.8');


     endmp(f);
     compil(s);  writeln('end');  {writeln(v1.Max/90000:9:9);}   readln;
end;

procedure drawleen1;
 var v,v1:TVec;
begin
  CreateIt(v,v1);
    v.LoadFromFile('anton\easy_1950_365.vec');
    v1.LoadFromFile('anton\leith_1950_365.vec');
    drawarrayv_re(v,v1,0,1,'lneneldis_new5');
  FreeIt(v,v1);
end;


procedure testchangesizeRdis1str(sa,sb,sa1,sb1,sr,sre:string);
 var m,m1,p,p1,mp,m2,p2,m3,p3:TMtx;
     v,v1,ve,ve1:TVec;
     s,s1:string;
     t,t1,E:Extended;
     row,col,i,j,k:integer;
     N:int64;
begin
  CreateIt(m,m1,p,p1); CreateIt(v,v1,ve,ve1);

  CreateIt(mp,m2,p2,m3);  CreateIt(p3);

   s:='v_leith1956_365_114x50';
   s1:='vdis_leith1956_365_114x50';

   s:='anton\v_easy_1950_131';
   s1:='anton\vdis_easy_1950_131';

   s:=sa; s1:=sb;

   //s:='v_leith_1956_d0_114x50'; s1:=s;

   j:=11;      //15

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=100;    //100

    v.Size(j-1,false);   ve.size(j-1,false);

    for i:=1 to j do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);

        changesizee(m,i*(i+1),i*(i+1),m2);
        changesizee(p,i*(i+1),i*(i+1),p2);

        changesizee(m1,i+1,i+1,m);
        changesizee(p1,i+1,i+1,p);

        changesizee(m,i*(i+1),i*(i+1),m3);
        changesizee(p,i*(i+1),i*(i+1),p3);

        m.sub(m3,m2); p.Sub(p3,p2);

        mp.MulElem(m,p);
        v.Values[i-1]:=mp.Sum/(mp.Cols*mp.rows);

        m.sqr;
        ve.Values[i-1]:=m.Sum/(m.Cols*m.rows);

        writeln(i,': ',v.Values[i-1]:5:5,' ',ve.Values[i-1]:5:5);
      end;

   writeln;

   s:='u_leith1956_365_114x50';
   s1:='udis_leith1956_365_114x50';

   s:='anton\u_easy_1950_131';
   s1:='anton\udis_easy_1950_131';

   s:=sa1; s1:=sb1;

   //s:='u_leith_1956_d0_114x50'; s1:=s;

   j:=11;      //15

   largem(s,j,m,m1);

   largem(s1,j,p,p1);


    j:=100;  //100

    v1.Size(j-1,false);     ve1.Size(j-1,false);

    for i:=1 to j do
      begin
        changesizee(m1,i,i,m);
        changesizee(p1,i,i,p);

        changesizee(m,i*(i+1),i*(i+1),m2);
        changesizee(p,i*(i+1),i*(i+1),p2);

        changesizee(m1,i+1,i+1,m);
        changesizee(p1,i+1,i+1,p);

        changesizee(m,i*(i+1),i*(i+1),m3);
        changesizee(p,i*(i+1),i*(i+1),p3);

        m.sub(m3,m2); p.Sub(p3,p2);


        mp.MulElem(m,p);
        v1.Values[i-1]:=mp.Sum/(mp.Cols*mp.rows);

        m.sqr;
        ve1.Values[i-1]:=m.Sum/(m.Cols*m.rows);

        writeln(i,': ',v1.Values[i-1]:5:5,' ',ve1.Values[i-1]:5:5);
      end;

   writeln;


   for i:=1 to j do
      begin

        writeln(i,': ',v1.Values[i-1]+v.Values[i-1]:5:5);
      end;

     v.Add(v1);

    v.SaveToFile({'anton\easy_1950_131.vec'}sr);

     ve.Add(ve1);

    ve.SaveToFile({'anton\easy_1950_131.vec'}sre);

  FreeIt(mp,m2,p2,m3);  FreeIt(p3);

  FreeIt(m,m1,p,p1);  FreeIt(v,v1,ve,ve1);
end;

procedure testdisstr;
 var i:integer;
     se, s, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12: string;
begin
  s:='anton1956\';   se:='56_';
  
  //s:='anton1949\';   se:='49_';
  //s:='vel_1956\'; se:='6_';
  s1:=s+'u_easy_19'+se;  s2:=s+'udis_easy_19'+se;
  s3:=s+'v_easy_19'+se;  s4:=s+'vdis_easy_19'+se;
  s5:=s+'u_leith_19'+se;  s6:=s+'udis_leith_19'+se;
  s7:=s+'v_leith_19'+se;  s8:=s+'vdis_leith_19'+se;
  s9:=s+'dis_easy_19'+se; s10:=s+'energy_easy_19'+se;
  s11:=s+'dis_leith_19'+se; s12:=s+'energy_leith_19'+se;
  for i:=1 to 10 do
    begin

       writeln('DAY   ',i);

      testchangesizeRdis1str
      (s3+inttostr(i),s4+inttostr(i),s1+inttostr(i),s2+inttostr(i),s9+inttostr(i),s10+inttostr(i));
      testchangesizeRdis1str
      (s7+inttostr(i),s8+inttostr(i),s5+inttostr(i),s6+inttostr(i),s11+inttostr(i),s12+inttostr(i));

    end;

  readln;
end;

procedure drawleen2;
 var v,v1:TVec;
     se:string;
begin
  CreateIt(v,v1);
    se:='56';
    v.LoadFromFile('anton19'+se+'\dis_easy_19'+se+'_av');
    v1.LoadFromFile('anton19'+se+'\dis_leith_19'+se+'_av');
    drawarrayv_re(v,v1,0,1,'lneneldis_19'+se);
  FreeIt(v,v1);
end;

procedure averag;
 var i,N,S,E:integer;
     v,v1,v2,v3:TVec;
     se:string;
begin
  CreateIt(v,v1,v2,v3);
    se:='56';
    S:=1; E:=10;
    N:=E-S+1;
    v2.size(99,false); v3.size(99,false);
    v2.scale(0); v3.scale(0);
    for i:=S to E do
      begin

        v.LoadFromFile('anton19'+se+'\dis_easy_19'+se+'_'+inttostr(i));
        v1.LoadFromFile('anton19'+se+'\dis_leith_19'+se+'_'+inttostr(i));
        v2.add(v); v3.Add(v1);
      end;
      v2.scale(1/N); v3.scale(1/N);
      v2.SavetoFile('anton19'+se+'\dis_easy_19'+se+'_av');
        v3.SaveToFile('anton19'+se+'\dis_leith_19'+se+'_av');
        writeln('vector length: ',v2.Length);
        writeln('vector max (easy): ',v2.max/90000:9:9);
  FreeIt(v,v1,v2,v3);
end;

procedure averag_ln;
 var i,N,S,E:integer;
     v,v1,v2,v3:TVec;
     se:string;
begin
  CreateIt(v,v1,v2,v3);
    se:='56';
    S:=1; E:=10;
    N:=E-S+1;
    v2.size(99,false); v3.size(99,false);
    v2.scale(0); v3.scale(0);
    for i:=S to E do
      begin
        v.LoadFromFile('anton19'+se+'\energy_easy_19'+se+'_'+inttostr(i));
        v1.LoadFromFile('anton19'+se+'\energy_leith_19'+se+'_'+inttostr(i));
        v2.add(v); v3.Add(v1);
      end;
      v2.scale(1/N); v3.scale(1/N);
      v2.SavetoFile('anton19'+se+'\energy_easy_19'+se+'_av');
        v3.SaveToFile('anton19'+se+'\energy_leith_19'+se+'_av');
        writeln('vector length: ',v2.Length);
        writeln('vector max (easy): ',v2.max/90000:9:9);
  FreeIt(v,v1,v2,v3);
end;

procedure drawleen2_ln;
 var v,v1:TVec;
     se:string;
begin
  CreateIt(v,v1);
    se:='56';
    v.LoadFromFile('anton19'+se+'\energy_easy_19'+se+'_av');
    v1.LoadFromFile('anton19'+se+'\energy_leith_19'+se+'_av');
    drawarrayvln_re(v,v1,0,1,'lneneldis_19'+se+'_ln');
  FreeIt(v,v1);        readln;
end;

procedure testallyears;
 var i,N,S,E:integer;
     v,v1,v2,v3:TVec;
     se:string;
begin
  CreateIt(v,v1,v2,v3);
    se:='56';
    S:=49; E:=57;
    N:=E-S+1;
    v2.size(99,false); v3.size(99,false);
    v2.scale(0); v3.scale(0);
    for i:=S to E do
      begin
        se:=inttostr(i);
        v.LoadFromFile('anton19'+se+'\dis_easy_19'+se+'_av');
        v1.LoadFromFile('anton19'+se+'\dis_leith_19'+se+'_av');
        v2.add(v); v3.Add(v1);
      end;
      v2.scale(1/N); v3.scale(1/N);
      v2.SavetoFile('dis_easy_all_av');
        v3.SaveToFile('dis_leith_all_av');
        writeln('vector length: ',v2.Length);
        writeln('vector max (easy): ',v2.max/(2*90000):9:9);
        drawarrayv_re(v2,v3,0,1,'lneneldis_all');
  FreeIt(v,v1,v2,v3);
end;

procedure testallyears_ln;
 var i,N,S,E:integer;
     v,v1,v2,v3:TVec;
     se:string;
     t1,t2:Extended;
begin
  CreateIt(v,v1,v2,v3);
    se:='56';
    S:=49; E:=57;
    N:=E-S+1;
    v2.size(99,false); v3.size(99,false);
    v2.scale(0); v3.scale(0);
    for i:=S to E do
      begin
        se:=inttostr(i);
        v.LoadFromFile('anton19'+se+'\energy_easy_19'+se+'_av');
        v1.LoadFromFile('anton19'+se+'\energy_leith_19'+se+'_av');
        v2.add(v); v3.Add(v1);
      end;
      v2.scale(1/N); v3.scale(1/N);

      writeln;

      t1:=0; t2:=0;

      for i:=55 to 95 do
        begin
          writeln(i,':   ',(ln(v2.Values[i])-ln(v2.Values[i-1]))/(ln(i)-ln(i-1)):5:5);
          writeln(i,':    ',(ln(v3.Values[i])-ln(v3.Values[i-1]))/(ln(i)-ln(i-1)):5:5);
          t1:=t1+(ln(v2.Values[i])-ln(v2.Values[i-1]))/(ln(i)-ln(i-1));
          t2:=t2+(ln(v3.Values[i])-ln(v3.Values[i-1]))/(ln(i)-ln(i-1));
        end;

      writeln;

      writeln(t1/41:5:5,'   ',t2/41:5:5);

      writeln;


      writeln(mac2(5/3,100):5:5);

      writeln;

      v2.SavetoFile('energy_easy_all_av');
        v3.SaveToFile('energy_leith_all_av');
        writeln('vector length: ',v2.Length);
        writeln('vector max (easy): ',v2.max/(2*90000):9:9);
         writeln('vector max (Leith): ',v3.max/(2*90000):9:9);
        drawarrayvln_re(v2,v3,0,1,'lneneldis_all_ln');
  FreeIt(v,v1,v2,v3);
end;


procedure testenerg;
 var m,m1,m2,m3:TMtx;
     s1,s2,s3,s4:string;
     row,col,i:integer;
     d:Extended;
begin
 CreateIt(m,m1,m2,m3);
    s1:='anton\u_leith_1950_';  s2:='anton\udis_leith_1950_';
  s3:='anton\v_leith_1950_';  s4:='anton\vdis_leith_1950_';
  d:=0;
   for i:=1 to 365 do begin
    determine_size_re(s1+inttostr(i)+'.csv',row,col);
    filetoarr_re(s1+inttostr(i)+'.csv',row,col,300,m);
    determine_size_re(s2+inttostr(i)+'.csv',row,col);
    filetoarr_re(s2+inttostr(i)+'.csv',row,col,300,m1);
    m.MulElem(m1);
    determine_size_re(s3+inttostr(i)+'.csv',row,col);
    filetoarr_re(s3+inttostr(i)+'.csv',row,col,300,m2);
    determine_size_re(s4+inttostr(i)+'.csv',row,col);
    filetoarr_re(s4+inttostr(i)+'.csv',row,col,300,m3);
    m2.MulElem(m3);
    m.add(m2); d:=d+m.sum;
    writeln(m.sum);
   end;
 writeln('final ',d);
 FreeIt(m,m1,m2,m3);
 Readln;
end;

///// Fourier transform
///
///

procedure energ(const m:TMtx; var v:TVec);
  var i,j:integer;
begin
  v.size(m.cols, false);   v.scale(0);
  for i:=0 to (m.rows div 2)-1 do
    for j:=0 to (m.cols div 2)-1 do
     V.values[ceil(2*sqrt(i*i+j*j))]:=
                   V.values[ceil(2*sqrt(i*i+j*j))]+m.Cvalues[i,j].Re;
  v.scale(1/(300*m.cols*m.rows));
end;

procedure testfft;
 var m,m1,m2,m3:TMtx;
     v,v1:Tvec;
     i,j,n:integer;
     s:string;
     t,t1:Extended;
begin
    CreateIt(m,m1,m2,m3);   CreateIt(v,v1);

  {m.size(4,4,false); m.scale(0); m.add(1);

  for i:=0 to m.rows-1 do
    for j:=0 to m.cols-1 do m.values[i,j]:=i-j;

  changesizee(m,8,8,m1); writem(m); writeln; writem(m1); readln;
  }

  n:=200;  v.size(n,false); v.scale(0);

  s:='leith'; //  s:='easy';

    for i:=1 to 200 do begin

    // writeln(i);

     m.LoadFromFile('anton\u_'+s+'_1956_'+inttostr(i)+'.csv.mat');
     m1.LoadFromFile('anton\udis_'+s+'_1956_'+inttostr(i)+'.csv.mat');

     //writeln(m.rows,' ',m.cols);

     changesizee(m,n,n,m2);
     changesizee(m1,n,n,m3);

     m2.fft2d;
     m2.conj;

     m3.fft2d;

     m3.mulelem(m2);

     m.LoadFromFile('anton\v_'+s+'_1956_'+inttostr(i)+'.csv.mat');
     m1.LoadFromFile('anton\vdis_'+s+'_1956_'+inttostr(i)+'.csv.mat');

     changesizee(m,n,n,m2);
     changesizee(m1,n,n,m);

     m2.fft2d;
     m2.conj;

     m.fft2d;

     m.mulelem(m2);

     m3.add(m);

     energ(m3,v1);         v.add(v1);
    end;

     for i:=0 to v.Length-1 do writeln(i,':   ',v.values[i]:5:5);

     FreeIt(m,m1,m2,m3); FreeIt(v,v1);  readln;
end;


procedure testtxt;
 var m,m1,m2,m3:TMtx;
     ve1,v:Tvec;
     t,alp:Extended;
     i,j,k:integer;
begin
  CreateIt(m,m1,m2,m3);  CreateIt(ve1,v);

    j:=100;      alp:=-2.5;

    {randmsp_re(m,2400,alp);

      writeln(0,':   ',alpha4(m,t):5:5,'   ',-mac2(-alp,j div 2):5:5);     readln; }

     Randomize;

    ve1.Complex:=false; ve1.Length:=j;

    ve1.scale(0);

    v.copy(ve1);

    writeln;

    for k:=1 to 20 do begin

      randmsp_re(m,j,alp);

      writeln(k,':   ',alpha4(m,t):5:5,'   ',-mac2(-alp,j div 2):5:5);

      changesizee(m,2048,2048,m1);   m.copy(m1);

    for i:=1 to j do
      begin
        changesizee(m,i,i,m1);


        changesizee(m1,i*(i+1),i*(i+1),m2);



        changesizee(m,i+1,i+1,m1);



        changesizee(m1,i*(i+1),i*(i+1),m3);



        m3.sub(m2);






        m3.sqr;

        {m3.sqr; m2.sqr; m3.sub(m2);}



        v.Values[i-1]:=m3.Sum/(m3.Cols*m3.rows);


      end;
           ve1.add(v);
    end;
      writeln;

      t:=0;

      for i:=55 to {ve1.Length-1}95 do
        begin
          writeln(i,':   ',(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1)):5:5);
          //  writeln(i,':   ',ve1.Values[i]:5:5);
            t:=t+(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1));
        end;

     writeln(t/41:5:5);

  FreeIt(m,m1,m2,m3); FreeIt(ve1,v);

  writeln('end'); readln;
end;

procedure testtxt1;
 var m,m1,m2,m3,m4:TMtx;
     ve1,v,v1:Tvec;
     t,alp:Extended;
     i,j,k:integer;
     s,s1:string;
begin
  CreateIt(m,m1,m2,m3); CreateIt(m4);  CreateIt(ve1,v,v1);

    j:=100;      alp:=-2.5;

    {randmsp_re(m,2400,alp);

      writeln(0,':   ',alpha4(m,t):5:5,'   ',-mac2(-alp,j div 2):5:5);     readln; }

     Randomize;



     ////
     ///
     ///
     ///

     //s:='v_leith_1956_d0_114x50'; s1:=s;

   //j:=11;      //15

   s:='idealized_velocities\u30_idealized';

   s1:='idealized_velocities\v30_idealized';

   largem(s,11,m,m1);

   largem(s1,11,m,m2);







     ////
     ///
     ///
     ///

    ve1.Complex:=false; ve1.Length:=j;

    ve1.scale(0);

    v.copy(ve1);

    writeln;

    for k:=1 to 1 do begin




    for i:=1 to j do
      begin
        changesizee(m1,i,i,m3);


        changesizee(m3,i*(i+1),i*(i+1),m);



        changesizee(m1,i+1,i+1,m3);



        changesizee(m3,i*(i+1),i*(i+1),m4);



        m.sub(m4);






        m.sqr;





        v.Values[i-1]:=m.Sum/(m.Cols*m.rows);


        changesizee(m2,i,i,m3);


        changesizee(m3,i*(i+1),i*(i+1),m);



        changesizee(m2,i+1,i+1,m3);



        changesizee(m3,i*(i+1),i*(i+1),m4);



        m.sub(m4);






        m.sqr;





        v.Values[i-1]:=v.Values[i-1]+m.Sum/(m.Cols*m.rows);

        writeln(i,': ',v.Values[i-1]:5:5);

      end;
           ve1.add(v);
    end;
      writeln;

      t:=0;

      for i:=10 to {ve1.Length-1}50 do
        begin
          //writeln(i,':   ',(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1)):5:5);
            writeln(i,':   ',ve1.Values[i]:5:5);
            t:=t+(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1));
        end;

     writeln(t/41:5:5);



     ///////
     ///
     ///
     ///


         ////
     ///
     ///
     ///

     //s:='v_leith_1956_d0_114x50'; s1:=s;

   //j:=11;      //15

   s:='idealized_velocities\u53_idealized';

   s1:='idealized_velocities\v53_idealized';

   largem(s,11,m,m1);

   largem(s1,11,m,m2);







     ////
     ///
     ///
     ///

    ve1.Complex:=false; ve1.Length:=j;

    ve1.scale(0);

    v1.copy(ve1);

    writeln;

    for k:=1 to 1 do begin




    for i:=1 to j do
      begin
        changesizee(m1,i,i,m3);


        changesizee(m3,i*(i+1),i*(i+1),m);



        changesizee(m1,i+1,i+1,m3);



        changesizee(m3,i*(i+1),i*(i+1),m4);



        m.sub(m4);






        m.sqr;





        v1.Values[i-1]:=m.Sum/(m.Cols*m.rows);


        changesizee(m2,i,i,m3);


        changesizee(m3,i*(i+1),i*(i+1),m);



        changesizee(m2,i+1,i+1,m3);



        changesizee(m3,i*(i+1),i*(i+1),m4);



        m.sub(m4);






        m.sqr;





        v1.Values[i-1]:=v1.Values[i-1]+m.Sum/(m.Cols*m.rows);

        writeln(i,': ',v1.Values[i-1]:5:5);

      end;
           ve1.add(v1);
    end;
      writeln;

      t:=0;

      for i:=55 to {ve1.Length-1}95 do
        begin
          //writeln(i,':   ',(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1)):5:5);
            writeln(i,':   ',ve1.Values[i]:5:5);
            t:=t+(ln(ve1.Values[i])-ln(ve1.Values[i-1]))/(ln(i)-ln(i-1));
        end;

     writeln(t/41:5:5);


     drawarrayvln_re(v,v,0,1,'idealized_spectrum');

  FreeIt(m,m1,m2,m3); FreeIt(m4);  FreeIt(ve1,v,v1);

  writeln('end'); readln;
end;

end.
