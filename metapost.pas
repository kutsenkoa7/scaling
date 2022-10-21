unit metapost;

interface

uses math, SysUtils, Windows;

type TL = array [1..4] of Extended;
     TReps = record xl,yl,xr,yr:Extended end;
     TReps3d =  record xl,yl,zl,xr,yr,zr:Extended end;
     TC = record x,y : Extended; end;
     TPath = array[1..100] of TC;
     TCol = record r,g,b:extended end;
     TF = function(x:extended):Extended;
     TFo = function(x:extended):Extended of object;
     Te = array of extended;
     TFar = function(x:extended):Te;

procedure beginmp(var f:TextFile; name: string);
procedure endmp(var f:TextFile);

//draw line, (x[1],x[2])--(x[3],x[4])
procedure draw(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);
procedure drawcol(var f:Textfile; x: TL; wid,cr,cg,cb:Extended; dash:boolean) overload;
//procedure drawcoldot(var f:Textfile; x: TL; wid,wid1,cr,cg,cb:Extended; empt:boolean);
procedure drawdot(var f:Textfile; x: TC; wid,cr,cg,cb:Extended; empt:boolean);
procedure drawarrow(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);
procedure drawarrowcol(var f:Textfile; x: TL; wid,cr,cg,cb:Extended; dash:boolean); overload
procedure drawarrowd(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);

procedure drawcol(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean) overload;

procedure drawarrowcol(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean) overload;
procedure drawarrowcold(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean);

//draw grafic f1(x), b is TRect corresponding to function, a is TRect corresponding to file
procedure grafeps1(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,col:Extended);
// clip of c inside b map to a
procedure grafeps2(var f1:TextFile;f:TF;a,b,c:TReps;d:integer;wid,col:Extended);
// draw grafic (fx(t),fy(t)) for t\in[tmin,tmax] inside b and map it to a
procedure grafeps3(var f1:TextFile;fx,fy:TF;a,b:TReps;d:integer;tmin,tmax,wid,col:Extended);

procedure grafeps1col(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);

procedure grafeps1colo(var f1:TextFile;f:TFo;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);

procedure grafeps1ar(var f1:TextFile;f:TFar;j:integer;a,b:TReps;d:integer;wid,col:Extended);

//procedure grafeps1ar1(var f1:TextFile;const m:TMN;coeff,N,j:integer;a,b:TReps;wid,col:Extended);
//procedure grafeps1ar2(var f1:TextFile;const m:TMN;N:integer;a,b:TReps;wid,col:Extended);

procedure grafeps1colp(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended; empt:boolean);

procedure grafeps1cold(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);

procedure rot2d(x: TL; var y:TL; vp:extended);

procedure coordeps1(var f1:TextFile; a,b:TReps; d1,d2:integer;wid,col:Extended; sx,sy:string);
procedure coordeps2(var f1:TextFile; a,b:TReps; d1,d2:integer;wid,col:Extended; sx,sy:string);
procedure coordeps3(var f1:TextFile; a,b:TReps; d1,d2:integer;wid,col:Extended; sx,sy:string);

procedure coordeps(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);

procedure coordepspositive(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);

procedure coordepspositive2(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);

procedure coordepspositive3(var f1:TextFile; a,b:TReps; wid,col:Extended; sx,sy:string);

//draw label; sect=0 - 0 , 1 - pi/4, ...
procedure labeleps(var f1:TextFile; x,y,col:Extended; sect:Integer; s:string);
procedure labelepscol(var f1:TextFile; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
procedure labelepsabcol(var f1:TextFile; a,b:TReps; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
procedure dotlabeleps(var f1:TextFile; x,y,col:Extended; sect:Integer; s:string);
procedure dotlabelepscol(var f1:TextFile; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
procedure dotlabelepsab(var f1:TextFile; a,b:TReps; x,y,col:Extended; sect:Integer; s:string);
procedure dotlabelepsabcol(var f1:TextFile; a,b:TReps; x,y,cr,cg,cb:Extended; sect:Integer; s:string);

 // 3D line (x(t),y(t),z(t)) on [tmin,tmax]
 // vp is a view point
 // dir is a point of direction of view
 // O=vp+dis*(dir-vp)/||dir-vp|| is a point which lie on the view plain which is
 // orthogonal to dir-vp
 // rectangle a coresponds to view plane (0,0) is a center view plane (point O)
 // rectangle b correspons to plane of eps, the masshtab of values is santimetres
procedure line3d(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);

//without color variety
procedure line3dc(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);

//without width and color variety
procedure line3dcw(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);

// scalar product
function scal3d(x,y:TL):Extended;

//sc1*x+sc2*y
 function add3d(x,y:TL; sc1,sc2:Extended):TL;

 // (x,y,z)
  function vect3d(x,y,z:Extended): TL;

  // vector product of x and y that is orthogonal to both
 function ort3d(x,y:TL): TL;

 // projection of x on view plane which is orthogonal to vp+dis*(dir-vp)/||dir-vp||
 // first basis vector on view plane parallel to xOy
 // (y[1],y[2]) is a projection
 function proj3d(x:TL; vp,dir:TL; dis:Extended; var y:TL): boolean;

 //  (x[3],x[4]) is a rotated vector (x[1],x[2]) on angle ang
 procedure rot(var x:TL; ang:Extended);

 // ||x-y||
 function dist3d(x,y:TL):Extended;


//liniar transformation x=x[3], y=x[4] from b to x=x[1], y=x[2] corresponding to a
procedure Trans(a,b:TReps; var x:TL);

//liniar transformation xb from b to  corresponding vector in a
function Transv(a,b:TReps; xb:TL):TL;


// create a path with name by points a[i], 0<=i<=n, with straight lines (line=true) or smooth (line=false) and cycle or not
procedure path(var f:TextFile; name:string; a:TPath; n:integer; line:boolean; cycle:boolean);

// draw path with name, wid (0.5 0.7 1 e.t.c) is a width and cr,cg,cb (0<=..<=1) are color components
procedure drawpath(var f:TextFile; name:string; wid,cr,cg,cb:Extended; dash:boolean);

// fill the region by color (cr,cg,cb) defined by path with name
procedure fillpath(var f:TextFile; name:string; cr,cg,cb:Extended);

// translate path from rect b to rect a; n is a number of points of array
function transpath(a,b:TReps; pb:TPath; n:integer):TPath;


procedure fillpath1(var f:TextFile; a:TPath; n:integer; line:boolean; cycle:boolean; cr,cg,cb:Extended); // simple fill the region

procedure compil(s:string);

implementation

procedure beginmp(var f:TextFile; name: string);
begin
 AssignFile(f,name+'.mp');
 Rewrite(f);
 {Writeln(f,'beginfig('+name+');'); }
 Writeln(f,'beginfig(1);');
 Writeln(f);
end;

procedure endmp(var f:TextFile);
begin
 Writeln(f);
 Writeln(f,'endfig;');
 CloseFile(f);
end;

procedure draw(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);
 var s: array [1..6] of string;
     rs:string;
     i: Integer;
begin
 rs:='';
 for i:=1 to 4 do s[i]:=floattostrf(x[i],ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(col,ffFixed,7,2);
 rs:=rs+'draw';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm)--('+s[3]+'cm,'+s[4]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'white';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure drawcol(var f:Textfile; x: TL; wid,cr,cg,cb:Extended; dash:boolean);
 var s: array [1..8] of string;
     rs:string;
     i: Integer;
begin
 rs:='';
 for i:=1 to 4 do s[i]:=floattostrf(x[i],ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(cr,ffFixed,7,2);
 s[7]:=floattostrf(cg,ffFixed,7,2);
 s[8]:=floattostrf(cb,ffFixed,7,2);
 rs:=rs+'draw';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm)--('+s[3]+'cm,'+s[4]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'red+'+s[7]+'green+'+s[8]+'blue';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure drawcol(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean);
 var x,y:TL;
begin
 x[3]:=x1;
 x[4]:=y1;
 trans(a,b,x);
 y[3]:=x2;
 y[4]:=y2;
 trans(a,b,y);
 x[3]:=y[1];
 x[4]:=y[2];
 drawcol(f,x,wid,cr,cg,cb,dash);
end;

procedure drawarrowcol(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean);
 var x,y:TL;
begin
 x[3]:=x1;
 x[4]:=y1;
 trans(a,b,x);
 y[3]:=x2;
 y[4]:=y2;
 trans(a,b,y);
 x[3]:=y[1];
 x[4]:=y[2];
 drawarrowcol(f,x,wid,cr,cg,cb,dash);
end;

procedure drawdot(var f:Textfile; x: TC; wid,cr,cg,cb:Extended; empt:boolean);
 var s: array [1..8] of string;
     rs:string;
     i: Integer;
     x1:TL;
begin
 if empt then begin
 rs:='';
 s[1]:=floattostrf(x.x,ffFixed,7,4);
 s[2]:=floattostrf(x.y,ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(cr,ffFixed,7,2);
 s[7]:=floattostrf(cg,ffFixed,7,2);
 s[8]:=floattostrf(cb,ffFixed,7,2);
 rs:=rs+'drawdot ';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'red+'+s[7]+'green+'+s[8]+'blue;';
 Writeln(f,rs);
 end else begin
 x1[1]:=x.x; x1[2]:=x.y; x1[3]:=x.x; x1[4]:=x.y;
 drawcol(f,x1,wid/2,cr,cg,cb,false);
 end;
end;


procedure drawarrow(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);
 var s: array [1..6] of string;
     rs:string;
     i: Integer;
begin
 rs:='';
 for i:=1 to 4 do s[i]:=floattostrf(x[i],ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(col,ffFixed,7,2);
 rs:=rs+'drawarrow';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm)--('+s[3]+'cm,'+s[4]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'white';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure drawarrowcol(var f:Textfile; x: TL; wid,cr,cg,cb:Extended; dash:boolean);
 var s: array [1..8] of string;
     rs:string;
     i: Integer;
begin
 rs:='';
 for i:=1 to 4 do s[i]:=floattostrf(x[i],ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(cr,ffFixed,7,2);
 s[7]:=floattostrf(cg,ffFixed,7,2);
 s[8]:=floattostrf(cb,ffFixed,7,2);
 rs:=rs+'drawarrow';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm)--('+s[3]+'cm,'+s[4]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'red+'+s[7]+'green+'+s[8]+'blue';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure drawarrowcold(var f:Textfile; a,b:TReps; x1,y1,x2,y2: Extended; wid,cr,cg,cb:Extended; dash:boolean);
begin
  drawarrowcol(f,a,b,x1,y1,x2,y2,wid,cr,cg,cb,dash);
  drawarrowcol(f,a,b,x2,y2,x1,y1,wid,cr,cg,cb,dash);
end;

procedure drawarrowd(var f:Textfile; x: TL; wid,col:Extended; dash:boolean);
 var s: array [1..6] of string;
     rs:string;
     i: Integer;
begin
 rs:='';
 for i:=1 to 4 do s[i]:=floattostrf(x[i],ffFixed,7,4);
 s[5]:=floattostrf(wid,ffFixed,7,2);
 s[6]:=floattostrf(col,ffFixed,7,2);
 rs:=rs+'drawdblarrow';
 rs:=rs+'('+s[1]+'cm,'+s[2]+'cm)--('+s[3]+'cm,'+s[4]+'cm) ';
 rs:=rs+'withpen pencircle scaled '+s[5]+'pt';
 rs:=rs+' withcolor '+s[6]+'white';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure grafeps1(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,col:Extended);
 var i:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
begin
 for i:=0 to d-1 do
  begin
   bb:=true;
   x[1]:=a.xl+i*(a.xr-a.xl)/d;
   t:=f(b.xl+i*(b.xr-b.xl)/d);
   if (t<=b.yr)and(t>=b.yl) then x[2]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl) else bb:=false;
   x[3]:=a.xl+(i+1)*(a.xr-a.xl)/d;
   t:=f(b.xl+(i+1)*(b.xr-b.xl)/d);
   if (t<=b.yr)and(t>=b.yl) then x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl) else bb:=false;
   if bb then draw(f1,x,wid,col,false);
   write(i,' ');
  end;
  Writeln(f1,' ');
end;

procedure grafeps1col(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);
 var i:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
begin
   bb:=true;
   x[3]:=a.xl+0*(a.xr-a.xl)/d;
   t:=f(b.xl+0*(b.xr-b.xl)/d);
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
 for i:=1 to d-1 do
  begin
   bb:=true;
   x[1]:=x[3]; x[2]:=x[4];
   x[3]:=a.xl+(i+1)*(a.xr-a.xl)/d;
   if (t>b.yr)or(t<b.yl) then bb:=false;
   t:=f(b.xl+(i+1)*(b.xr-b.xl)/d);
   if (t>b.yr)or(t<b.yl) then bb:=false;
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
   if bb then drawcol(f1,x,wid,cr,cg,cb,false);
   write(i,' ');
  end;
  Writeln(f1,' ');
end;

procedure grafeps1colo(var f1:TextFile;f:TFo;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);
 var i:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
begin
   bb:=true;
   x[3]:=a.xl+0*(a.xr-a.xl)/d;
   t:=f(b.xl+0*(b.xr-b.xl)/d);
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
 for i:=1 to d-1 do
  begin
   bb:=true;
   x[1]:=x[3]; x[2]:=x[4];
   x[3]:=a.xl+(i+1)*(a.xr-a.xl)/d;
   if (t>b.yr)or(t<b.yl) then bb:=false;
   t:=f(b.xl+(i+1)*(b.xr-b.xl)/d);
   if (t>b.yr)or(t<b.yl) then bb:=false;
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
   if bb then drawcol(f1,x,wid,cr,cg,cb,false);
   write(i,' ');
  end;

end;


procedure grafeps1cold(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended);
  var i:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
begin
   bb:=true;
   x[3]:=a.xl+0*(a.xr-a.xl)/d;
   t:=f(b.xl+0*(b.xr-b.xl)/d);
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
 for i:=1 to d-1 do
  begin
   bb:=true;
   x[1]:=x[3]; x[2]:=x[4];
   x[3]:=a.xl+(i+1)*(a.xr-a.xl)/d;
   if (t>b.yr)or(t<b.yl) then bb:=false;
   t:=f(b.xl+(i+1)*(b.xr-b.xl)/d);
   if (t>b.yr)or(t<b.yl) then bb:=false;
   x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl);
   if bb then drawcol(f1,x,wid,cr,cg,cb,true);
   write(i,' ');
  end;
  Writeln(f1,' ');
end;


procedure grafeps1colp(var f1:TextFile;f:TF;a,b:TReps;d:integer;wid,cr,cg,cb:Extended; empt:boolean);
 var i:Integer;
     x:TC;
     bb:Boolean;
     t,k:Extended;
begin
 for i:=0 to d-1 do
  begin
   bb:=true;
   x.x:=a.xl+i*(a.xr-a.xl)/d;
   t:=f(b.xl+i*(b.xr-b.xl)/d);
   if (t<=b.yr)and(t>=b.yl) then x.y:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl) else bb:=false;
   if bb then drawdot(f1,x,wid,cr,cg,cb,empt);
   write(i,' ');
  end;
  Writeln(f1,' ');
end;



procedure grafeps1ar(var f1:TextFile;f:TFar;j:integer;a,b:TReps;d:integer;wid,col:Extended);
 var i,k1:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
     s,s1:TE;
begin
 s1:=f(b.xl+0*(b.xr-b.xl)/d);
 for i:=0 to d-1 do
  begin
   s:=s1;  write(i,' ');
   s1:=f(b.xl+(i+1)*(b.xr-b.xl)/d);
   for k1:=1 to j do
    begin
     bb:=true;
     x[1]:=a.xl+i*(a.xr-a.xl)/d;
     t:=s[k1];
     if (t<=b.yr)and(t>=b.yl) then x[2]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl) else bb:=false;
     x[3]:=a.xl+(i+1)*(a.xr-a.xl)/d;
     t:=s1[k1];
     if (t<=b.yr)and(t>=b.yl) then x[4]:=a.yl+(a.yr-a.yl)*(t-b.yl)/(b.yr-b.yl) else bb:=false;
     if bb then draw(f1,x,wid,col,false);
    end;
  end;
  Writeln(f1,' ');
end;

{function points11(const m:TMN;N:integer;column,j:integer):TVNi;
 var i,jj,jj1:integer;
begin
 jj1:=0; jj:=1; Setlength(Result,j+1);  for jj := 1 to j do Result[jj]:=0;

 repeat
  jj1:=jj1+1;
  if sign(m[jj1,column].x)<>sign(m[jj1+1,column].x) then
   begin
    Result[jj]:=jj1;
    jj:=jj+1;
   end;
 until (jj=j+1)or(jj1=N-1);
end;

function sortt(const v1, v2:TVNi; j,coeff:integer; var v3,v4:TVNi):integer;
 var i,jj,jj1,jj2:integer;
begin
 setlength(v3,j+1); setlength(v4,j+1);

 jj:=0; i:=0;  jj1:=0;

 repeat
  jj:=jj+1;

  repeat
   i:=i+1;
  until (v2[i]>=v1[jj])or(i=j);

  if i=j then exit;


  if (v2[i]-v1[jj])>=abs(v1[jj]-v2[i-1]) then
   begin
     if abs(v1[jj]-v2[i-1])<=coeff then
      begin
        jj1:=jj1+1;
        v3[jj1]:=v1[jj]; v4[jj1]:=v2[i-1];
      end;
   end
  else
   begin
     if (v2[i]-v1[jj])<=coeff then
      begin
        jj1:=jj1+1;
        v3[jj1]:=v1[jj]; v4[jj1]:=v2[i];
      end;
   end;

 until (jj=j)or(i=j)or(jj1=j);

 Result:=jj1;

end;

procedure grafeps1ar1(var f1:TextFile;const m:TMN;coeff,N,j:integer;a,b:TReps;wid,col:Extended);
 var i,jj,jj1,k1:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
     s,s1,s2,s3:TVNi;
begin

  s:=points11(m,N,1,j);

  for i:=1 to N-1 do
    begin
     s1:=points11(m,N,i+1,j);
     k1:=sortt(s,s1,j,coeff,s2,s3);
     for jj:=1 to k1 do
       begin
        x[1]:=a.xl+i*(a.xr-a.xl)/N;  x[3]:=a.xl+(i+1)*(a.xr-a.xl)/N;
        x[2]:=a.yl+s2[jj]*(a.yr-a.yl)/N;  x[4]:=a.yl+s3[jj]*(a.yr-a.yl)/N;
        draw(f1,x,wid,col,false);
       end;
     s:=s1; setlength(s,j+1);
    end;
  Writeln(f1,' ');
end;

procedure grafeps1ar2(var f1:TextFile;const m:TMN;N:integer;a,b:TReps;wid,col:Extended);
 var i,jj,jj1,k1:Integer;
     x:TL;
     bb:Boolean;
     t,k:Extended;
     s,s1,s2,s3:TVNi;
begin


  for jj:=1 to N-1 do
   for i:=1 to N-1 do
       begin
        if (sign(m[i,jj].x)>sign(m[i+1,jj].x))and(abs(m[i,jj].x)<900000)and(abs(m[i+1,jj].x)<900000) then   begin

        x[2]:=a.yl+i*(a.yr-a.yl)/N;  x[4]:=x[2];
        x[1]:=a.xl+jj*(a.xr-a.xl)/N;  x[3]:=x[1];
        draw(f1,x,wid,col,false);                        end;
       end;

  Writeln(f1,' ');
end;   }


procedure grafeps2(var f1:TextFile;f:TF;a,b,c:TReps;d:integer;wid,col:Extended);
 var i:Integer;
     x,y:TL;
     bb:Boolean;
     t,k:Extended;
begin
 for i:=0 to d-1 do
  begin
   bb:=true;
   y[3]:=c.xl+i*(c.xr-c.xl)/d;
   y[4]:=f(y[3]);
   if (y[4]<=c.yr)and(y[4]>=c.yl) then begin Trans(a,b,y); x[1]:=y[1]; x[2]:=y[2] end else bb:=false;
   y[3]:=c.xl+(i+1)*(c.xr-c.xl)/d;
   y[4]:=f(y[3]);
   if (y[4]<=c.yr)and(y[4]>=c.yl) then begin Trans(a,b,y); x[3]:=y[1]; x[4]:=y[2] end else bb:=false;
   if bb then draw(f1,x,wid,col,false);
  end;
  Writeln(f1,' ');
end;

procedure grafeps3(var f1:TextFile;fx,fy:TF;a,b:TReps;d:integer;tmin,tmax,wid,col:Extended);
 var i:Integer;
     x,y:TL;
     bb:Boolean;
     t,k:Extended;
begin
 for i:=0 to d-1 do
  begin
   bb:=true;

   t:=tmin+(tmax-tmin)*i/d;
   x[3]:=fx(t); x[4]:=fy(t);
   if (x[3]<b.xr)and(x[3]>b.xl)and(x[4]<b.yr)and(x[4]>b.yl) then trans(a,b,x) else bb:=false;
   y[1]:=x[1]; y[2]:=x[2];

   t:=tmin+(tmax-tmin)*(i+1)/d;
   x[3]:=fx(t); x[4]:=fy(t);
   if (x[3]<b.xr)and(x[3]>b.xl)and(x[4]<b.yr)and(x[4]>b.yl) then trans(a,b,x) else bb:=false;
   y[3]:=x[1]; y[4]:=x[2];
   if bb then draw(f1,y,wid,col,false);
  end;
  Writeln(f1,' ');
end;

procedure Trans(a,b:TReps; var x:TL);
begin
  x[1]:=a.xl+(x[3]-b.xl)*(a.xr-a.xl)/(b.xr-b.xl);
  x[2]:=a.yl+(x[4]-b.yl)*(a.yr-a.yl)/(b.yr-b.yl);
end;

procedure rot2d(x: TL; var y:TL; vp:extended);
begin
 y[1]:=x[1]*cos(vp)-x[2]*sin(vp);
 y[2]:=x[1]*sin(vp)+x[2]*cos(vp);
 y[3]:=x[3]*cos(vp)-x[4]*sin(vp);
 y[4]:=x[3]*sin(vp)+x[4]*cos(vp);
end;

procedure coordeps1(var f1:TextFile; a,b:TReps; d1,d2:integer; wid,col:Extended; sx,sy:string);
 var x:TL;
 i:Integer;
 s1,s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[1]:=a.xl; x[2]:=(a.yl+a.yr)/2;
 x[3]:=a.xr; x[4]:=x[2];
 drawarrow(f1,x,wid,col,false);
 s1:=FloatToStrF(Min(1,min((a.xr-a.xl)/d1,(a.yr-a.yl)/d2)),ffFixed,7,1);
 Writeln(f1,' defaultscale:='+s1+';');
 for i:=1 to d1-1 do
  begin
    x[1]:=a.xl+i*(a.xr-a.xl)/d1; x[2]:=((a.yl+a.yr)/2)-0.01*(a.yr-a.yl);
    x[3]:=x[1]; x[4]:=x[2]+0.02*(a.yr-a.yl);
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.xl+i*(b.xr-b.xl)/d1),ffGeneral,7,2);
    s2:=floattostrf(x[1],ffFixed,7,4);
    s3:=floattostrf(x[2],ffFixed,7,4);
    {s4:='label.bot(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));'; }
    s4:='label.bot("'+s1+'", ('+s2+'cm,'+s3+'cm));';


    {if not((d1 mod 2 = 0)and(i = d1 div 2)) then} Writeln(f1,s4);
  end;
  s2:=floattostrf(a.xr,ffFixed,7,4);
  s3:=floattostrf(((a.yl+a.yr)/2),ffFixed,7,4);
  s4:='label.lrt('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
  Writeln(f1,' ');
 x[1]:=(a.xl+a.xr)/2; x[2]:=a.yl;
 x[3]:=x[1]; x[4]:=a.yr;
 drawarrow(f1,x,wid,col,false);
 for i:=1 to d2-1 do
  begin
    x[1]:=((a.xl+a.xr)/2)-0.01*(a.xr-a.xl); x[2]:=a.yl+i*(a.yr-a.yl)/d2;
    x[3]:=x[1]+0.02*(a.xr-a.xl); x[4]:=x[2];
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.yl+i*(b.yr-b.yl)/d2),ffGeneral,7,2);
    s2:=floattostrf(x[3],ffFixed,7,4);
    s3:=floattostrf(x[4],ffFixed,7,4);
    {s4:='label.rt(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));';}
    s4:='label.rt("'+s1+'", ('+s2+'cm,'+s3+'cm));';

    if not((d2 mod 2 = 0)and(i = d2 div 2)) then Writeln(f1,s4);
  end;
  s2:=floattostrf(((a.xr+a.xl)/2),ffFixed,7,4);
  s3:=floattostrf(a.yr,ffFixed,7,4);
  s4:='label.urt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
  Writeln(f1,' defaultscale:=1;');
  Writeln(f1,' ');
end;


procedure coordeps2(var f1:TextFile; a,b:TReps; d1,d2:integer; wid,col:Extended; sx,sy:string);
 var x:TL;
 i:Integer;
 s1,s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[1]:=a.xl; x[2]:=a.yl;
 x[3]:=a.xr; x[4]:=x[2];
 drawarrow(f1,x,wid,col,false);
 s1:=FloatToStrF(Min(1,min((a.xr-a.xl)/d1,(a.yr-a.yl)/d2)),ffFixed,7,1);
 Writeln(f1,' defaultscale:='+s1+';');
 for i:=1 to d1-1 do
  begin
    x[1]:=a.xl+i*(a.xr-a.xl)/d1; x[2]:=a.yl-0.01*(a.yr-a.yl);
    x[3]:=x[1]; x[4]:=x[2]+0.02*(a.yr-a.yl);
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.xl+i*(b.xr-b.xl)/d1),ffGeneral,7,2);
    s2:=floattostrf(x[1],ffFixed,7,4);
    s3:=floattostrf(x[2],ffFixed,7,4);
    {s4:='label.bot(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));'; }
    s4:='label.bot("'+s1+'", ('+s2+'cm,'+s3+'cm));';


    {if not((d1 mod 2 = 0)and(i = d1 div 2)) then} Writeln(f1,s4);
  end;
  s2:=floattostrf(a.xr,ffFixed,7,4);
  s3:=floattostrf(a.yl,ffFixed,7,4);
  s4:='label.lrt('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
  Writeln(f1,' ');
 x[1]:=(a.xl+a.xr)/2; x[2]:=a.yl;
 x[3]:=x[1]; x[4]:=a.yr;
 drawarrow(f1,x,wid,col,false);
 for i:=1 to d2-1 do
  begin
    x[1]:=((a.xl+a.xr)/2)-0.01*(a.xr-a.xl); x[2]:=a.yl+i*(a.yr-a.yl)/d2;
    x[3]:=x[1]+0.02*(a.xr-a.xl); x[4]:=x[2];
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.yl+i*(b.yr-b.yl)/d2),ffGeneral,7,2);
    s2:=floattostrf(x[3],ffFixed,7,4);
    s3:=floattostrf(x[4],ffFixed,7,4);
    {s4:='label.rt(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));';}
    s4:='label.rt("'+s1+'", ('+s2+'cm,'+s3+'cm));';

    {if not((d2 mod 2 = 0)and(i = d2 div 2)) then} Writeln(f1,s4);
  end;
  s2:=floattostrf(((a.xr+a.xl)/2),ffFixed,7,4);
  s3:=floattostrf(a.yr,ffFixed,7,4);
  s4:='label.urt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
  Writeln(f1,' defaultscale:=1;');
  Writeln(f1,' ');
end;






procedure coordeps3(var f1:TextFile; a,b:TReps; d1,d2:integer; wid,col:Extended; sx,sy:string);
 var x:TL;
 i:Integer;
 s1,s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[1]:=a.xl; x[2]:=(a.yl+a.yr)/2;
 x[3]:=a.xr; x[4]:=x[2];
 drawarrow(f1,x,wid,col,false);
 s1:=FloatToStrF(Min(1,min((a.xr-a.xl)/d1,(a.yr-a.yl)/d2)),ffFixed,7,1);
 Writeln(f1,' defaultscale:='+s1+';');
 for i:=1 to d1-1 do
  begin
    x[1]:=a.xl+i*(a.xr-a.xl)/d1; x[2]:=((a.yl+a.yr)/2)-0.01*(a.yr-a.yl);
    x[3]:=x[1]; x[4]:=x[2]+0.02*(a.yr-a.yl);
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.xl+i*(b.xr-b.xl)/d1),ffFixed,7,2);
    s2:=floattostrf(x[1],ffFixed,7,4);
    s3:=floattostrf(x[2],ffFixed,7,4);
    {s4:='label.bot(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));'; }
    s4:='label.bot("'+s1+'", ('+s2+'cm,'+s3+'cm));';


    if not((d1 mod 2 = 0)and(i = d1 div 2)) then Writeln(f1,s4);
  end;
  Writeln(f1,' ');
 x[1]:=(a.xl+a.xr)/2; x[2]:=a.yl;
 x[3]:=x[1]; x[4]:=a.yr;
 drawarrow(f1,x,wid,col,false);
 for i:=1 to d2-1 do
  begin
    x[1]:=((a.xl+a.xr)/2)-0.01*(a.xr-a.xl); x[2]:=a.yl+i*(a.yr-a.yl)/d2;
    x[3]:=x[1]+0.02*(a.xr-a.xl); x[4]:=x[2];
    draw(f1,x,wid,col,false);

    s1:=floattostrf((b.yl+i*(b.yr-b.yl)/d2),ffFixed,7,2);
    s2:=floattostrf(x[3],ffFixed,7,4);
    s3:=floattostrf(x[4],ffFixed,7,4);
    {s4:='label.rt(btex $'+s1+'$ etex, ('+s2+'cm,'+s3+'cm));';}
    s4:='label.rt("'+s1+'", ('+s2+'cm,'+s3+'cm));';

    if not((d2 mod 2 = 0)and(i = d2 div 2)) then Writeln(f1,s4);
  end;
  Writeln(f1,' defaultscale:=1;');
  Writeln(f1,' ');
end;

procedure coordeps(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);
 var x,y:TL;
     s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[3]:=c.xl; x[4]:=(c.yl+c.yr)/2;
 Trans(a,b,x);
 y[3]:=c.xr; y[4]:=(c.yl+c.yr)/2;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];
 drawarrow(f1,x,wid,col,false);
 Writeln(f1,' ');

 s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.lrt('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);

 x[3]:=(c.xl+c.xr)/2; x[4]:=c.yl;
 Trans(a,b,x);
 y[3]:=(c.xl+c.xr)/2; y[4]:=c.yr;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];


 drawarrow(f1,x,wid,col,false);

   s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.urt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
end;

procedure coordepspositive(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);
 var x,y:TL;
     s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[3]:=c.xl; x[4]:=c.yl;
 Trans(a,b,x);
 y[3]:=c.xr; y[4]:=c.yl;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];
 drawarrow(f1,x,wid,col,false);
 Writeln(f1,' ');

 s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.lrt('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);

 x[3]:=(c.xl+c.xr)/2; x[4]:=c.yl;
 Trans(a,b,x);
 y[3]:=(c.xl+c.xr)/2; y[4]:=c.yr;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];


 drawarrow(f1,x,wid,col,false);

   s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.urt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
end;


procedure coordepspositive2(var f1:TextFile; a,b,c:TReps; wid,col:Extended; sx,sy:string);
 var x,y:TL;
     s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[3]:=c.xl; x[4]:=c.yl;
 Trans(a,b,x);
 y[3]:=c.xr; y[4]:=c.yl;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];
 drawarrow(f1,x,wid,col,false);
 Writeln(f1,' ');

 s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.bot('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);

 x[3]:=c.xl; x[4]:=c.yl;
 Trans(a,b,x);
 y[3]:=c.xl; y[4]:=c.yr;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];


 drawarrow(f1,x,wid,col,false);

   s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.rt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
end;


procedure coordepspositive3(var f1:TextFile; a,b:TReps; wid,col:Extended; sx,sy:string);
 var x,y:TL;
     s2,s3,s4:string;
begin
 Writeln(f1,' ');
 x[3]:=b.xl; x[4]:=(b.yl+b.yr)/2;
 Trans(a,b,x);
 y[3]:=b.xr; y[4]:=(b.yl+b.yr)/2;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];
 drawarrow(f1,x,wid,col,false);
 Writeln(f1,' ');

 s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.lrt('+sx+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);

 x[3]:=b.xl; x[4]:=b.yl;
 Trans(a,b,x);
 y[3]:=b.xl; y[4]:=b.yr;
 Trans(a,b,y);
 x[3]:=y[1]; x[4]:=y[2];


 drawarrow(f1,x,wid,col,false);

   s2:=floattostrf(x[3],ffFixed,7,4);
  s3:=floattostrf(x[4],ffFixed,7,4);
  s4:='label.urt('+sy+', ('+s2+'cm,'+s3+'cm));';
   Writeln(f1,s4);
end;


procedure labeleps(var f1:TextFile; x,y,col:Extended; sect:Integer; s:string);
 var s1,s2,s3:string;
begin
 case (sect mod 8) of
  0 : s1:='rt';
  1 : s1:='urt';
  2 : s1:='top';
  3 : s1:='ulft';
  4 : s1:='lft';
  5 : s1:='llft';
  6 : s1:='bot';
  7 : s1:='lrt';
 end;
 s3:='label.'+s1+'('+s+',(';
 s2:= floattostrf(x,ffFixed,7,4);
 s3:=s3+s2+'cm,';
 s2:= floattostrf(y,ffFixed,7,4);
 s3:=s3+s2+'cm)) ';
 s2:=floattostrf(col,ffFixed,7,2);
 s3:=s3+'withcolor '+s2+'white;';
 Writeln(f1,s3); Writeln(f1);
end;

procedure labelepscol(var f1:TextFile; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
 var s1,s2,s3:string;
begin
 case (sect mod 8) of
  0 : s1:='rt';
  1 : s1:='urt';
  2 : s1:='top';
  3 : s1:='ulft';
  4 : s1:='lft';
  5 : s1:='llft';
  6 : s1:='bot';
  7 : s1:='lrt';
 end;
 s3:='label.'+s1+'('+s+',(';
 s2:= floattostrf(x,ffFixed,7,4);
 s3:=s3+s2+'cm,';
 s2:= floattostrf(y,ffFixed,7,4);
 s3:=s3+s2+'cm)) ';
 s2:=floattostrf(cr,ffFixed,7,2);
 s3:=s3+'withcolor '+s2+'red+';
 s2:=floattostrf(cg,ffFixed,7,2);
 s3:=s3+s2+'green+';
 s2:=floattostrf(cb,ffFixed,7,2);
 s3:=s3+s2+'blue;';
 Writeln(f1,s3); Writeln(f1);
end;

procedure labelepsabcol(var f1:TextFile; a,b:TReps; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
 var gg:TL;
begin
 gg[3]:=x; gg[4]:=y;
 trans(a,b,gg);
 labelepscol(f1,gg[1],gg[2],cr,cg,cb,sect,s);
end;

procedure dotlabeleps(var f1:TextFile; x,y,col:Extended; sect:Integer; s:string);
 var s1,s2,s3:string;
begin
 case (sect mod 8) of
  0 : s1:='rt';
  1 : s1:='urt';
  2 : s1:='top';
  3 : s1:='ulft';
  4 : s1:='lft';
  5 : s1:='llft';
  6 : s1:='bot';
  7 : s1:='lrt';
 end;
 s3:='dotlabel.'+s1+'('+s+',(';
 s2:= floattostrf(x,ffFixed,7,4);
 s3:=s3+s2+'cm,';
 s2:= floattostrf(y,ffFixed,7,4);
 s3:=s3+s2+'cm)) ';
 s2:=floattostrf(col,ffFixed,7,2);
 s3:=s3+'withcolor '+s2+'white;';
 Writeln(f1,s3); Writeln(f1);
end;

procedure dotlabelepscol(var f1:TextFile; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
 var s1,s2,s3:string;
begin
 case (sect mod 8) of
  0 : s1:='rt';
  1 : s1:='urt';
  2 : s1:='top';
  3 : s1:='ulft';
  4 : s1:='lft';
  5 : s1:='llft';
  6 : s1:='bot';
  7 : s1:='lrt';
 end;
 s3:='dotlabel.'+s1+'('+s+',(';
 s2:= floattostrf(x,ffFixed,7,4);
 s3:=s3+s2+'cm,';
 s2:= floattostrf(y,ffFixed,7,4);
 s3:=s3+s2+'cm)) ';
 s2:=floattostrf(cr,ffFixed,7,2);
 s3:=s3+'withcolor '+s2+'red+';
 s2:=floattostrf(cg,ffFixed,7,2);
 s3:=s3+s2+'green+';
 s2:=floattostrf(cb,ffFixed,7,2);
 s3:=s3+s2+'blue;';
 Writeln(f1,s3); Writeln(f1);
end;

procedure dotlabelepsab(var f1:TextFile; a,b:TReps; x,y,col:Extended; sect:Integer; s:string);
 var gg:TL;
begin
 gg[3]:=x; gg[4]:=y;
 trans(a,b,gg);
 dotlabeleps(f1,gg[1],gg[2],col,sect,s);
end;

procedure dotlabelepsabcol(var f1:TextFile; a,b:TReps; x,y,cr,cg,cb:Extended; sect:Integer; s:string);
 var gg:TL;
begin
 gg[3]:=x; gg[4]:=y;
 trans(a,b,gg);
 dotlabelepscol(f1,gg[1],gg[2],cr,cg,cb,sect,s);
end;

function scal3d(x,y:TL):Extended;
begin
 Result:=x[1]*y[1]+x[2]*y[2]+x[3]*y[3]
end;

function add3d(x,y:TL; sc1,sc2:Extended):TL;
begin
 Result[1]:=sc1*x[1]+sc2*y[1];
 Result[2]:=sc1*x[2]+sc2*y[2];
 Result[3]:=sc1*x[3]+sc2*y[3];
 Result[4]:=0;
end;

function vect3d(x,y,z:Extended): TL;
begin
  Result[1]:=x;
  Result[2]:=y;
  Result[3]:=z;
  Result[4]:=0;
end;

function ort3d(x,y:TL):TL;
begin
  Result[1]:=x[2]*y[3]-x[3]*y[2];
  Result[2]:=x[3]*y[1]-x[1]*y[3];
  Result[3]:=x[1]*y[2]-x[2]*y[1];
  Result[4]:=0;
end;

function proj3d(x:TL; vp,dir:TL; dis:Extended; var y:TL): boolean;
 var k1,k2,k3:Extended;
     h0,h1,h2,h3,h4,h5,h6,h7, h4a, h5a:TL;
begin
 Result:=true;
 h0[1]:=0;h0[2]:=0;h0[3]:=0;
 h1:=add3d(dir,vp,1,-1);
 k1:=Scal3d(h1,h1);
 h2:=add3d(x,vp,1,-1);
 h3:=add3d(dir,vp,1,-1);
 k2:=scal3d(h2,h3);
 h6:=add3d(vp,h1,1,dis);
 if k2<=0.0001 then result:=False else
  begin
   k3:=dis*k1/k2;
   y:=add3d(vp,h2,1,k3);
   h0[3]:=1;
   h4:=ort3d(h3,h0);
   h0[3]:=0;
   h5:=ort3d(h4,h3);
   h4a:=add3d(h0,h4,0,1/dist3d(h4,h0));
   h5a:=add3d(h0,h5,0,1/dist3d(h5,h0));
   k1:=scal3d(add3d(y,h6,1,-1),h4a);
   k2:=scal3d(add3d(y,h6,1,-1),h5a);
   y[1]:=k1; y[2]:=k2;
  end;
end;

procedure rot(var x:TL; ang:Extended);
begin
  x[3]:=x[1]*cos(ang)-x[2]*sin(ang);
  x[4]:=x[2]*cos(ang)+x[1]*sin(ang);
end;


function dist3d(x,y:TL):Extended;
 var t:Extended;
begin
 t:=(y[1]-x[1])*(y[1]-x[1])+(y[2]-x[2])*(y[2]-x[2])+(y[3]-x[3])*(y[3]-x[3]);
 if t<=0 then Result:=0 else Result:=Power(t,1/2);
end;




procedure line3d(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);
 var i:Integer;
     bb:Boolean;
     t,k,k1,k2,k3,wid1,col1:Extended;
     g1,g2,g3,g4,g5,g6: TL;
begin
 t:=tmin; k:=(tmax-tmin)/d;
 k1:=dis*dist3d(vp,dir);
 for i:=0 to d do begin
  bb:=true;
  g1[1]:=x(t); g1[2]:=y(t); g1[3]:=z(t);
  bb:=bb and (proj3d(g1,vp,dir,dis,g3));
  if bb then rot(g3,ang);
  t:=t+k;
  g2[1]:=x(t); g2[2]:=y(t); g2[3]:=z(t);
  bb:= bb and (proj3d(g2,vp,dir,dis,g4));
  if bb then rot(g4,ang);
  if bb then
   begin
     k2:=dis*scal3d(add3d(dir,vp,1,-1),add3d(dir,vp,1,-1))/scal3d(add3d(g1,vp,1,-1),add3d(dir,vp,1,-1));
     Trans(a,b,g3); Trans(a,b,g4);
     g5[1]:=g3[1]; g5[2]:=g3[2]; g5[3]:=g4[1]; g5[4]:=g4[2];

     wid1:= wid*k2;{if wid1<0.2 then wid1:=0.2; }

     col1:= col+0.3/k2; if col1>1 then col1:=1;


     if (a.xl<g5[1])and(g5[1]<a.xr)and
        (a.yl<g5[2])and(g5[2]<a.yr)and
        (a.xl<g5[3])and(g5[3]<a.xr)and
        (a.yl<g5[4])and(g5[4]<a.yr)

         then
             draw(f1,g5,wid1,col1,False);
   end;

 end;
end;

procedure line3dc(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);
 var i:Integer;
     bb:Boolean;
     t,k,k1,k2,k3,wid1,col1:Extended;
     g1,g2,g3,g4,g5,g6: TL;
begin
 t:=tmin; k:=(tmax-tmin)/d;
 k1:=dis*dist3d(vp,dir);
 for i:=0 to d do begin
  bb:=true;
  g1[1]:=x(t); g1[2]:=y(t); g1[3]:=z(t);
  bb:=bb and (proj3d(g1,vp,dir,dis,g3));
  if bb then rot(g3,ang);
  t:=t+k;
  g2[1]:=x(t); g2[2]:=y(t); g2[3]:=z(t);
  bb:= bb and (proj3d(g2,vp,dir,dis,g4));
  if bb then rot(g4,ang);
  if bb then
   begin
     k2:=dis*scal3d(add3d(dir,vp,1,-1),add3d(dir,vp,1,-1))/scal3d(add3d(g1,vp,1,-1),add3d(dir,vp,1,-1));
     Trans(a,b,g3); Trans(a,b,g4);
     g5[1]:=g3[1]; g5[2]:=g3[2]; g5[3]:=g4[1]; g5[4]:=g4[2];

     {wid1:= wid*k2;if wid1<0.2 then wid1:=0.2; }

     col1:= col+0.3/k2; if col1>1 then col1:=1;


     if (a.xl<g5[1])and(g5[1]<a.xr)and
        (a.yl<g5[2])and(g5[2]<a.yr) then
             draw(f1,g5,wid,col1,False);
   end;

 end;
end;

procedure line3dcw(var f1:TextFile;x,y,z:TF; tmin,tmax:Extended; vp,dir:TL; dis, ang:Extended;
                 a,b:TReps; d:integer;wid,col:Extended);
 var i:Integer;
     bb:Boolean;
     t,k,k1,k2,k3,wid1,col1:Extended;
     g1,g2,g3,g4,g5,g6: TL;
begin
 t:=tmin; k:=(tmax-tmin)/d;
 k1:=dis*dist3d(vp,dir);
 for i:=0 to d do begin
  bb:=true;
  g1[1]:=x(t); g1[2]:=y(t); g1[3]:=z(t);
  bb:=bb and (proj3d(g1,vp,dir,dis,g3));
  if bb then rot(g3,ang);
  t:=t+k;
  g2[1]:=x(t); g2[2]:=y(t); g2[3]:=z(t);
  bb:= bb and (proj3d(g2,vp,dir,dis,g4));
  if bb then rot(g4,ang);
  if bb then
   begin
     k2:=dis*scal3d(add3d(dir,vp,1,-1),add3d(dir,vp,1,-1))/scal3d(add3d(g1,vp,1,-1),add3d(dir,vp,1,-1));
     Trans(a,b,g3); Trans(a,b,g4);
     g5[1]:=g3[1]; g5[2]:=g3[2]; g5[3]:=g4[1]; g5[4]:=g4[2];

     {wid1:= wid*k2;if wid1<0.2 then wid1:=0.2; }

     {col1:= col+0.3/k2; if col1>1 then col1:=1; }


     if (a.xl<g5[1])and(g5[1]<a.xr)and
        (a.yl<g5[2])and(g5[2]<a.yr) then
             draw(f1,g5,wid,col,False);
   end;

 end;
end;









(*procedure compil(s:string);
 var
  Rlst: LongBool;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  s1:string;
  f: TextFile;
begin




  // mp.exe
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='mp.exe '+s+'.mp';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //metapostn.tex

   AssignFile(f,'metapostn.tex');
   Rewrite(f);
   Writeln(f,'\documentclass[12pt]{minimal}');
   Writeln(f,'\usepackage[koi8-r]{inputenc}');
   Writeln(f,'\usepackage[english,russian]{babel}');
   Writeln(f,'\usepackage{graphicx}');
   Writeln(f,'\DeclareGraphicsRule{*}{eps}{*}{}');
   Writeln(f,'\nofiles');
   Writeln(f,'\begin{document}');
   Writeln(f,'\thispagestyle{empty}');
   s1:='\includegraphics{'+s+'.0}';
   Writeln(f,s1);
   Writeln(f,'\end{document}');
   Writeln(f,'%dvips -E -o f1.eps metapost             (where you need metapost.dvi before)');
   CloseFile(f);



  //latex.exe
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'latex.exe metapostn.tex';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //dvips
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'dvips -E -o '+s+'.eps metapostn';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //epstopdf
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'epstopdf '+s+'.eps';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

end; *)

procedure compil(s:string);
 var
  Rlst: LongBool;
  StartUpInfo: TStartUpInfo;
  ProcessInfo: TProcessInformation;
  s1:string;
  f: TextFile;
begin




  // mp.exe
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='mpost.exe '+s+'.mp';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //metapostn.tex

   AssignFile(f,'metapostn.tex');
   Rewrite(f);
   Writeln(f,'\documentclass[12pt]{minimal}');
   Writeln(f,'\usepackage[koi8-r]{inputenc}');
   Writeln(f,'\usepackage[english,russian]{babel}');
   Writeln(f,'\usepackage{graphicx}');
   Writeln(f,'\DeclareGraphicsRule{*}{eps}{*}{}');
   Writeln(f,'\nofiles');
   Writeln(f,'\begin{document}');
   Writeln(f,'\thispagestyle{empty}');
   s1:='\includegraphics{'+s+'.1}';
   Writeln(f,s1);
   Writeln(f,'\end{document}');
   Writeln(f,'%dvips -E -o f1.eps metapost             (where you need metapost.dvi before)');
   CloseFile(f);



  //latex.exe
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'latex.exe metapostn.tex';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //dvips
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'dvips -E -o '+s+'.eps metapostn';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

  //epstopdf
  FillChar(StartUpInfo, SizeOf(TStartUpInfo), 0);
  with StartUpInfo do
  begin
    cb := SizeOf(TStartUpInfo);
    dwFlags := STARTF_USESHOWWINDOW or STARTF_FORCEONFEEDBACK;
    wShowWindow := SW_SHOWNORMAL;
  end;
  s1:='';
  s1:=s1+'epstopdf '+s+'.eps';
  Rlst := CreateProcess(nil, PChar(s1), nil, nil, false, NORMAL_PRIORITY_CLASS, nil, nil, StartUpInfo, ProcessInfo);
  WaitforSingleObject(ProcessInfo.hProcess, INFINITE);
  CloseHandle(ProcessInfo.hThread);
  CloseHandle(ProcessInfo.hProcess);

end;

procedure fillpath1(var f:TextFile; a:TPath; n:integer; line:boolean; cycle:boolean; cr,cg,cb:Extended);
 var i:integer;
     s,s1:string;
     sa: array [1..3] of string;
begin
 if line then s:='--' else s:='..';
 s1:='fill ';
 for i:=1 to n do
   begin
    s1:=s1+'('+floattostrf(a[i].x,ffFixed,7,4)+'cm,'+floattostrf(a[i].y,ffFixed,7,4)+'cm)';
    if i=n then else s1:=s1+s;
   end;
 if cycle then s1:=s1+s+'cycle';

 sa[1]:=floattostrf(cr,ffFixed,7,2);
 sa[2]:=floattostrf(cg,ffFixed,7,2);
 sa[3]:=floattostrf(cb,ffFixed,7,2);

 s1:=s1+' withcolor '+sa[1]+'red+'+sa[2]+'green+'+sa[3]+'blue;';

 writeln(f,s1);
end;

procedure path(var f:TextFile; name:string; a:TPath; n:integer; line:boolean; cycle:boolean);
 var i:integer;
     s,s1:string;
begin
 if line then s:='--' else s:='..';
 writeln(f,'path '+name+';');
 s1:=name+' = ';
 for i:=1 to n do
   begin
    s1:=s1+'('+floattostrf(a[i].x,ffFixed,7,4)+'cm,'+floattostrf(a[i].y,ffFixed,7,4)+'cm)';
    if i=n then else s1:=s1+s;
   end;
 if cycle then s1:=s1+s+'cycle;' else s1:=s1+';';
 writeln(f,s1);
end;

procedure drawpath(var f:TextFile; name:string; wid,cr,cg,cb:Extended; dash:boolean);
 var s: array [1..4] of string;
     rs:string;
begin
 rs:='';
 s[1]:=floattostrf(wid,ffFixed,7,2);
 s[2]:=floattostrf(cr,ffFixed,7,2);
 s[3]:=floattostrf(cg,ffFixed,7,2);
 s[4]:=floattostrf(cb,ffFixed,7,2);
 rs:=rs+'draw '+name;
 rs:=rs+' withpen pencircle scaled '+s[1]+'pt';
 rs:=rs+' withcolor '+s[2]+'red+'+s[3]+'green+'+s[4]+'blue';
 if dash then rs:=rs+' dashed evenly;' else rs:=rs+';';
 Writeln(f,rs);
end;

procedure fillpath(var f:TextFile; name:string; cr,cg,cb:Extended);
 var s: array [1..3] of string;
     rs:string;
begin
 rs:='';
 s[1]:=floattostrf(cr,ffFixed,7,2);
 s[2]:=floattostrf(cg,ffFixed,7,2);
 s[3]:=floattostrf(cb,ffFixed,7,2);
 rs:=rs+'fill '+name;
 rs:=rs+' withcolor '+s[1]+'red+'+s[2]+'green+'+s[3]+'blue;';
 Writeln(f,rs);
end;

function transpath(a,b:TReps; pb:TPath; n:integer):TPath;
 var i:integer;
     x:TL;
begin
 for i:=1 to n do begin
   x[3]:=pb[i].x; x[4]:=pb[i].y;
   trans(a,b,x);
   result[i].x:=x[1]; result[i].y:=x[2];
 end;
end;

function Transv(a,b:TReps; xb:TL):TL;
 var x:TL;
begin
 x[3]:=xb[1]; x[4]:=xb[2];
 trans(a,b,x);
 result[1]:=x[1]; result[2]:=x[2];
 x[3]:=xb[3]; x[4]:=xb[4];
 trans(a,b,x);
 result[3]:=x[1]; result[4]:=x[2];
end;


end.
