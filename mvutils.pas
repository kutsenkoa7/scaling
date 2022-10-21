unit mvutils;

interface

uses
  System.SysUtils, System.Types,
  math387, MtxVec,
  metapost, statistics, probabilities, statrandom, vcl.Graphics, vcl.Imaging.jpeg;

type TF1D = function(x:Extended):Extended;


  TRGBRec = packed record R, G, B: Byte; end ;
  TRGBArray = ARRAY[Word] of TRGBRec;
  pRGBArray = ^TRGBArray;

  TF = function(x,y:Extended):Extended;

  TColfunc = procedure(c:Extended; var r,g,b:byte);

// save matrix as image

procedure jpgbmp(const m:TMtx; s:string);

// sum of squares for v  - both cplx and re

function energyv(const v:TVec):Extended;

// resize and average in 2, 2 times down  - re

procedure resize2(const v:Tvec; var v1:TVec);

// resize and average in ini, inj times down  - re

procedure reduce(const m:TMtx; ini,inj:integer; var m1:TMtx);

// the same as above for cplx

procedure reduce_cplx(const m:TMtx; ini,inj:integer; var m1:TMtx);


// resize and average to the new size: previousi + ini, prviousj + inj  - re

procedure changesize(const m:TMtx; ini,inj:integer; var m1:TMtx);

// the same as above for cplx

procedure changesize_cplx(const m:TMtx; ini,inj:integer; var m1:TMtx);


// resize and average to the new size nr, nc

procedure changesizee(const m:TMtx; nr,nc:integer; var m1:TMtx);


// sum of squares for m  - both cplx and re

function energym(const m:TMtx):Extended;

// show v - both cplx and re

procedure writev(v:TVec);

// show m  -  both cplx and re

procedure writem(const m:TMtx);

{0 + 0 -       0 + 0 - 0
 + + + -   to  + + + - -
 0 + 0 -       0 + 0 - 0
 - + - -       - + - - +
               0 + 0 - 0

Convert the standard Fourier into central symmetric
}

procedure symFT(const mf:TMtx; var m:TMtx);

// inverse for the previous one - from central symmetric to standard

procedure symIFT(const m:TMtx; var mf:TMtx);

// create the symmetric ring of the width from a*size/2 to b*size/2

procedure gensymring(var m:TMtx; len:integer; a,b:Extended);

// compute alpha using 2 times 2,2 reduction - both complex and Re

function alpha4(const m:TMtx; var t:Extended):Extended;

// analytic approximation of the alpha4

function mac2(a:Extended;len:integer):Extended;

// inverse mac2

function inv_mac2(a:Extended;len:integer):Extended;

// the same as alpha4 but uses asympt near -3 to recover alpha upto -4

function alpha4_4(const m:TMtx; var t:Extended):Extended;

// the same as mac2 but uses asympt near -3 to recover alpha upto -4

function mac2_4(a:Extended;len:integer):Extended;

// analytic integrals .....

procedure intarray(len:integer; alp:Extended; var val: array of Extended);
procedure intarray_norm(len:integer; alp:Extended; vval:TVec);
procedure intarray_norm_alpinterval(len:integer; alp1,alp2:Extended; var val:array of TVec);

// for given m, cumulative energies over [0,(m.size/2^(v.size))2^n] are placed in v[n]

procedure cum_energy_scales(const m:TMtx; var v:TVec);


// create a complex random uniform matrix in the symmetric Fourier space

procedure randflatFsym(var m:TMtx; len:integer);         // len is odd


// create a complex random uniform matrix in the Fourier space

procedure randflatsym(var m:TMtx; len:integer);   // len is even

// create |k|^2 matrix in the Fourier space

procedure symmsq(var m:TMtx; len:integer);   // len is even

// create |k|^2 matrix in the symmetric Fourier space

procedure symmsqF(var m:TMtx; len:integer);   // len is odd

// create real random matrix in x-space with the spectrum alpha (alpha in Fourier space)

procedure randmsp_re(var m:TMtx; len:integer; alpha:Extended);   // len is even

// create random complex matrix in the symmetric Fourier space (in x space it is real)

procedure randmspFsym_re(var m:TMtx; len:integer; alpha:Extended);  // len is odd

//generate mv.cols colums of recovered alpha, there are mv.rows random matrices for each alpha

procedure genmv(var mv:TMtx; be,en:Extended; sm:integer);

// the same as genmv but uses asympt near -3 to recover alpha upto -4

procedure genmv_4(var mv:TMtx; be,en:Extended; sm:integer);

// the same as genmv but uses asympt near -3 to recover alpha upto -4 and inverse
// to recover exact alpha

procedure genmv_4all(var mv:TMtx; be,en:Extended; sm:integer);

// generate v1.length analytic alpha from be to en

procedure genv1(var v1:TVec; be,en:Extended; sm:integer);

// the same as gev1 but uses asympt near -3 to recover alpha upto -4

procedure genv1_4(var v1:TVec; be,en:Extended; sm:integer);

// for fixed alpha and size of matrix sm, it generates v2.Length randomly computed alpha

procedure genv2(var v2:TVec; alp:Extended; sm:integer);

// for given m in Fourier space, it generates the random symmetric matrix
// in Fourier space, multiplies random on m and goes to the x-space
// with resulting real matrix

procedure spectorand(const m:TMtx; var m1:TMtx);

//for fixed alp, generates mv.rows random matrices of the size sm,
// compute m.cols cumulative energies and place them in mv

procedure genmv_fixed_alp(var mv:TMtx; sm:integer; alp:Extended);

// normalization of the previously obtained mv

procedure norm_mv_fixed_alp(const mv:TMtx; var mv1:TMtx);

// correction of the previously obtained mv

procedure norm_mv_fixed_alp_cor(const mv1:TMtx; var mv2:TMtx; alp1, alp2:Extended; sm,st:integer);

// generate random matrix in Walsh basis with 0 average over 2x2 submatrices
// new size is sm x sm (sm even) for 1st procedure and 4m.rows x 4m.cols for the 2st
// (alp is a spectral slope)
// RandUniform(-t,t) is used

procedure rand_Walsh(var m:TMtx; sm:integer; t:Extended);
procedure addnoise2_Walsh(const m:TMtx; alp,t:Extended; var m1:TMtx);

procedure genmv_Walsh(var mv:TMtx; be,en:Extended; sm:integer);
procedure genv2_Walsh(var v2:TVec; alp:Extended; sm:integer);

procedure addnoise3_Walsh(const m:TMtx; alp,t:Extended; var m1:TMtx);

procedure genv2_Walsh3(var v2:TVec; alp:Extended; sm:integer);

procedure genv2_Walsh3a(var v2:TVec; alp:Extended; sm:integer);

procedure genmv3_Walsh(var mv:TMtx; be,en:Extended; sm:integer);

procedure testsym;

procedure symmPareto(var m:TMtx; t:Extended);  // t >= 1 ; random distrib density = 1/x^t


///////////////////////////////////////////////
///  very experimental ////////////////////////
///  //////////////////////////////////////////

procedure symf(var m:TMtx; len:integer; f:TF1D);

procedure energysymF(const symf:TMTx;  ev:TVec);

procedure testv;



implementation

procedure col(c:Extended; var r,g,b:byte);
 var r1,g1,b1:Extended;
begin
  r1:=0; g1:=0; b1:=0;
  if (c<0.3)and(c>-0.3) then
   begin
     if c>0 then
      begin
        r1:=c/0.6; g1:=1-2*r1; b1:=0;
      end
     else
      begin
        b1:=-c/0.6; g1:=1-2*b1; r1:=0;
      end
   end;
  if (c>=0.3)and(c<=1) then
   begin
     r1:=c*5/7+2/7; g1:=0; b1:=0;
   end;
  if (c<=-0.3)and(c>=-1) then
   begin
     b1:=-c*5/7+2/7; g1:=0; r1:=0;
   end;
  if (c>=1) then
   begin
     r1:=1; g1:=0; b1:=0;
   end;
  if (c<=-1) then
   begin
     b1:=1; g1:=0; r1:=0;
   end;
  r:=ceil(254*r1); g:=ceil(254*g1); b:=ceil(254*b1);
end;

procedure writeim1(const fd:TMtx; var image:TBitmap; scale:Extended; cf:TColFunc);
 var i,j,n,m:integer;
     sc: prgbarray;
     r,g,b:byte;
begin
  n:=fd.Rows; m:=fd.Cols;
  for j:=0 to m-1 do
    begin
     sc := image.ScanLine[j];
     for i:=0 to n-1 do
      begin
       cf(fd.Values[i,n-1-j]*scale,r,g,b);
       sc^[i].b := r; sc^[i].g := g; sc^[i].r := b;
      end;
    end;
end;

procedure jpgbmp(const m:TMtx; s:string);
 var
   image:TBitmap;
     vJpg:TJPEGImage;
   mmax:Extended;
begin
    image:=TBitmap.Create;
   image.Width:=m.Cols; image.Height:=m.Rows;
   image.PixelFormat := pf24bit;

   mmax:=m.Max;

   writeim1(m,image,2/abs(mmax),col);   image.SaveToFile(s+'.bmp');

    vJpg:=TJPEGImage.Create;
    vJpg.Assign(image); //Transfer the image of bmp to jpg here
      vJpg.SaveToFile(s+'.jpg');
      FreeAndNil(image);
      FreeAndNil(vJpg);
end;

procedure writev(v:TVec);
 var i:integer;
begin
  for i:=0 to v.Length-1 do
    if not v.Complex then writeln(i,': ',v.Values[i]:3:3)
                     else writeln(i,': ',CPlxToStr(v.CValues[i],3,3));
end;

procedure resize2(const v:Tvec; var v1:TVec);
 var i:integer;
     v2:TVec;
begin
 CreateIt(v2);
  v1.DownSample(v,2,1);
  v2.DownSample(v,2);
  v1.Add(v2); v1.Scale(1/2);
 FreeIt(v2);
end;

function energyv(const v:TVec):Extended;
 var i:integer;
begin
  if v.Complex then Result:=sqr(v.NormL2)/v.Length
               else Result:=v.SumOfSquares/v.Length;
end;

procedure writem(const m:TMtx);
 var i,j:integer;
begin
  for i:=0 to m.Rows-1 do
   begin
     writeln;
     for j:=0 to m.Cols-1 do
      if m.Complex then write(CPlxToStr(m.CValues[i,j],3,3),' ')
                   else write(m.Values[i,j]:3:3,' ');
   end;
  writeln;
end;

function energym(const m:TMtx):Extended;
 var i:integer;
begin
  if m.Complex then Result:=sqr(m.NormL2)/(m.Cols*m.Rows)
               else Result:=m.SumOfSquares/(m.Cols*m.Rows);
end;

procedure changesize(const m:TMtx; ini,inj:integer; var m1:TMtx);
begin
  m1.Size(m.Rows + ini, m.Cols + inj, false);
  m.PixelResample(m1,rect(0,0,m.Cols-1,m.Rows-1),pdsAverage);
end;

procedure changesizee(const m:TMtx; nr,nc:integer; var m1:TMtx);
begin
  m1.Size(nr, nc, false);
  m.PixelResample(m1,rect(0,0,m.Cols-1,m.Rows-1),pdsAverage);
end;

procedure changesize_cplx(const m:TMtx; ini,inj:integer; var m1:TMtx);
 var m2,m3,m4:TMtx;
begin
  CreateIt(m2,m3,m4);
    m.CplxToReal(m2,m3);
    changesize(m2,ini,inj,m4);
    changesize(m3,ini,inj,m2);
    m1.RealToCplx(m4,m2);
  FreeIt(m2,m3,m4);
end;

procedure reduce(const m:TMtx; ini,inj:integer; var m1:TMtx);
begin
  m1.Size(m.Rows div ini, m.Cols div inj, false);
  m.PixelResample(m1,rect(0,0,m.Cols-1,m.Rows-1),pdsAverage);
end;

procedure reduce_cplx(const m:TMtx; ini,inj:integer; var m1:TMtx);
 var m2,m3,m4:TMtx;
begin
  CreateIt(m2,m3,m4);
    m.CplxToReal(m2,m3);
    reduce(m2,ini,inj,m4);
    reduce(m3,ini,inj,m2);
    m1.RealToCplx(m4,m2);
  FreeIt(m2,m3,m4);
end;



procedure gensymring(var m:TMtx; len:integer; a,b:Extended);
 var i,j,N:integer;
begin
  N:=(len-1) div 2;
  m.Size(len,len,false);
  for i:=0 to len-1 do
    for j:=0 to len-1 do
      if (sqr(N-i)+sqr(N-j)<=sqr(b*N))and
          (sqr(N-i)+sqr(N-j)>=sqr(a*N)) then m.Values[i,j]:=1 else
                                             m.Values[i,j]:=0;
end;




procedure symFT(const mf:TMtx; var m:TMtx);
 var N:integer;
begin
  N:=mf.Rows div 2;
  m.Size(mf.Rows+1,mf.Cols+1,mf.Complex);
  m.Copy(mf,0,0,N,N,N+1,N+1);
  m.Copy(mf,0,N,N,0,N+1,N);
  m.Copy(mf,N,0,0,N,N,N+1);
  m.Copy(mf,N,N,0,0,N,N);
end;

procedure symIFT(const m:TMtx; var mf:TMtx);
 var N:integer;
begin
  N:=(m.Rows-1) div 2;
  mf.Size(m.Rows-1,m.Cols-1,m.Complex);
  mf.Copy(m,N,N,0,0,N,N);
  mf.Copy(m,0,N,N,0,N,N);
  mf.Copy(m,N,0,0,N,N,N);
  mf.Copy(m,0,0,N,N,N,N);
end;






function alpha2(a,b,c:Extended):Extended;
begin
  Result:=(a-b)/(b-c);
  Result:=ln(Result)/ln(2)-1;
end;

function alpha4(const m:TMtx; var t:Extended):Extended;
 var m1,m2:TMtx;
     e1,e2,e3:Extended;
begin
  CreateIt(m1,m2);

   e1:=Energym(m);  t:=e1;

   reduce(m,2,2,m1);

   e2:=Energym(m1);

   reduce(m1,2,2,m2);

   e3:=Energym(m2);

   Result:=alpha2(e1,e2,e3);

  FreeIt(m1,m2)
end;

procedure cum_energy_scales(const m:TMtx; var v:TVec);
 var m1,m2:TMtx;
     e1,e2,e3:Extended;
     i:integer;
begin
  CreateIt(m1,m2);

  m1.copy(m);

  for i:=v.Length-1 downto 0 do
    begin
      v.Values[i]:=Energym(m1);

      reduce(m1,2,2,m2);  m1.copy(m2);
    end;

  FreeIt(m1,m2)
end;


function alpha4_4(const m:TMtx; var t:Extended):Extended;
 var m1,m2:TMtx;
     e1,e2,e3:Extended;
     len:integer;
begin
  CreateIt(m1,m2);

   e1:=Energym(m);  t:=e1;

   reduce(m,2,2,m1);

   e2:=Energym(m1);

   reduce(m1,2,2,m2);

   e3:=Energym(m2);

   Result:=alpha2(e1,e2,e3);

   len:=m.Cols;

   if -Result>mac2(3,len div 2) then Result:=-3+ln(3+Result)/ln(len);

  FreeIt(m1,m2)
end;

procedure genn(var m1,m2,m3:TMtx; len:integer);
 var v,v1:TVec;
begin
  CreateIt(v,v1);
  m1.Size(len,len,false);
  m2.Size(len,len,false);
  m3.Size(len,len,false);
    v.Size(len,false);
    v1.Size(len,false);  v1.Scale(0); v1.Add(1);
    v.Ramp;
    m1.TensorProd(v1,v); m2.Transp(m1); m3.Copy(m2);
    m3.RealToCPlx(m2,m1); //m3.abs;
  FreeIt(v,v1);
end;

procedure mintg1g2(len:integer; alp:Extended; var ratio:Extended);
  var m1,m2,m3,m4,m5,m6:TMtx;
      fg1int,fg2int:Extended;
      i:integer;
begin
  CreateIt(m1,m2,m3,m4); CreateIt(m5,m6);

    genn(m1,m2,m3,len);

  m2.Scale(pi/(2*len)); m2.Cos;

  m4.copy(m2); m2.Transp; m4.MulElem(m2); m4.Sqr;

  m5.Copy(m4);

  m4.Scale(-1); m4.Add(1);

  m3.Abs; m3.Values[0,0]:=1; m3.Power(-2*alp);



  m4.MulElem(m3);    //null1(m4,m4.Rows div 5);

  for i:=0 to m4.Rows-1 do m4.Values[i,0]:=0;

  fg1int:=m4.Sum{*power(len,2*alp-2)};

  m5.MulElem(m3);  // up to scales contains cos^2(\pi x/2)cos^2(\pi y/2)/(x^2+y^2)^{alp}

  m1.Scale(pi/(len)); m1.Cos;

  m4.copy(m1); m1.Transp; m4.MulElem(m1); m4.Sqr;
  m4.Scale(-1); m4.Add(1);

  m4.MulElem(m5);   //null1(m4,m4.Rows div 5);

  for i:=0 to m4.Rows-1 do m4.Values[i,0]:=0;

  fg2int:=m4.Sum{*power(len,2*alp-2)};

  ratio:=fg1int/fg2int;



  FreeIt(m1,m2,m3,m4); FreeIt(m5,m6);
end;

function mac2(a:Extended;len:integer):Extended;
 var b,t:Extended;
begin
  b:=(1+a)/2;

  mintg1g2(len,b,t);

  Result:=1-ln(t)/ln(2);


end;

function inv_mac2(a:Extended;len:integer):Extended;
 var tmin,tmax,t,talp:Extended;
begin
  tmin:=a-3; tmax:=a+3;
  repeat
    t:=(tmin+tmax)/2;
    talp:=mac2(t,len);
    if talp>a then tmax:=t else tmin:=t;
  until tmax-tmin<0.0001;
  Result:=(tmax+tmin)/2;
end;

function mac2_4(a:Extended;len:integer):Extended;
 var b,t:Extended;
begin
  b:=(1+a)/2;

  mintg1g2(len,b,t);

  Result:=1-ln(t)/ln(2);

  if Result>mac2(3,len) then Result:=3-ln(3-Result)/ln(2*len);
end;

procedure intarray(len:integer; alp:Extended; var val: array of Extended);
  var m1,m2,m3,m4,m5,m6:TMtx;
      v1, v2, v3:TVec;
      bet:Extended;
      i,len1,k:integer;
begin
  CreateIt(m1,m2,m3,m4); CreateIt(m5,m6);  CreateIt(v1,v2,v3);

  len1:=len+1;

  m1.Size(len1,len1,false);
  m2.Size(len1,len1,false);
  m3.Size(len1,len1,false);
    v3.Size(len1,false);  v2.Size(len1,false);
    v1.Size(len1,false);  v1.Scale(0); v1.Add(1);
    v3.Ramp;  v2.copy(v3);
    v3.scale(1/(2*len)); v3.sqr;
    m1.TensorProd(v1,v3); m2.Transp(m1); m3.Add(m1,m2);   m3.Values[0,0]:=1;

    bet:=-(1+alp)/2;   m3.power(bet);

    v3.Scale(0); v3.Add(1);

  for i:=0 to Length(val)-2 do
     begin

      m2.TensorProd(v3,v3);

      m2.MuleLem(m3);       m2.scale(1/(m2.rows));

      for k:=0 to m2.rows-1 do begin m2.Values[0,k]:=0; {m2.Values[k,0]:=0} end;

      val[i]:=m2.sum;


      v1.copy(v2);

      v1.Scale(pi/(2*len)); v1.scale(intpower(2,i));  v1.cos;

      v1.sqr;  v3.mul(v1);
     end;

      m2.TensorProd(v3,v3);

      m2.MuleLem(m3);      m2.scale(1/sqr(m2.rows));

      for k:=0 to m2.rows-1 do begin m2.Values[0,k]:=0; {m2.Values[k,0]:=0} end;

      val[Length(val)-1]:=m2.sum;


  FreeIt(m1,m2,m3,m4); FreeIt(m5,m6); FreeIt(v1,v2,v3);
end;


procedure intarray_norm(len:integer; alp:Extended; vval:TVec);
 var
   val: array of Extended;
   i,N:integer;
   t:Extended;
begin
  N:=vval.Length;

  SetLength(val,N+1);
  intarray(len,alp,val);



  for i:=0 to vval.Length-1 do
    begin
       vval.Values[i]:=val[N-i]-val[N-i-1];
       vval.Values[i]:=log2(vval.Values[i]/(val[1]-val[0]));
       vval.Values[i]:=(N-1-i)+vval.Values[i];
    end;



  SetLength(val,0);
end;

procedure intarray_norm_alpinterval(len:integer; alp1,alp2:Extended; var val:array of TVec);
 var i,j:integer;
     v1:TVec;
     h:Extended;
begin
  CreateIt(v1);
    v1.Complex:=true; v1.Length:=Length(val);
    h:=(alp2-alp1)/val[0].Length;
    for i:=0 to val[0].Length-1 do
      begin
         intarray_norm(len,alp1+i*h,v1);
         for j:=0 to v1.Length-1 do val[j].Values[i]:=v1.Values[j];
      end;
  FreeIt(v1);
end;

procedure randflatFsym(var m:TMtx; len:integer);         // len is odd
 var m1:TMtx;
     t:Extended;
     n:integer;
begin
  t:=1; n:=(len-1) div 2;
  m.Size(len,len,true); m.Scale(0);
  CreateIt(m1);
    m1.Size(n+1,n+1,true); m1.RandUniform(-t,t);
    m.Copy(m1,0,0,0,0,n+1,n+1);
    m1.FlipHor; m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n,n,n+1,n+1);

    m1.Size(n,n,true); m1.RandUniform(-t,t);
    m.Copy(m1,0,0,0,n+1,n,n);
    m1.FlipHor; m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n+1,0,n,n);

    m1.Size(1,n,true);
    m1.Copy(m,0,0,0,0,1,n);
    m1.FlipHor; m1.Conj;
    m.Copy(m1,0,0,0,n+1,1,n);
    m1.FlipHor; m1.Conj;
    m.Copy(m1,0,0,2*n,0,1,n);

    m1.Size(n,1,true);
    m1.Copy(m,0,0,0,0,n,1);
    m1.FlipVer; m1.Conj;
    m.Copy(m1,0,0,n+1,0,n,1);
    m1.FlipVer; m1.Conj;
    m.Copy(m1,0,0,0,2*n,n,1);

    m.CValues[n,n]:=CPlx(0);

    m.CValues[0,0]:=CPlx(0);
    m.CValues[0,n]:=CPlx(0);
    m.CValues[0,2*n]:=CPlx(0);
    m.CValues[n,0]:=CPlx(0);
    m.CValues[2*n,0]:=CPlx(0);
    m.CValues[2*n,n]:=CPlx(0);
    m.CValues[2*n,2*n]:=CPlx(0);


  FreeIt(m1);
end;


procedure randflatsym(var m:TMtx; len:integer);   // len is even
 var m1:TMtx;
     t:Extended;
     n:integer;
begin
  t:=1;  n:=(len-2)div 2;
  m.Size(2*n+2,2*n+2,true); m.Scale(0);
  CreateIt(m1);
    m1.Size(n,n,true); m1.RandUniform(-t,t);
    m.Copy(m1,0,0,1,1,n,n);
    m1.FlipHor; m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n+2,n+2,n,n);

    m1.RandUniform(-t,t);
    m.Copy(m1,0,0,1,n+2,n,n);
    m1.FlipHor; m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n+2,1,n,n);

    m1.Size(n,1,true); m1.RandUniform(-t,t);
    m.Copy(m1,0,0,1,0,n,1);
    m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n+2,0,n,1);

    m1.RandUniform(-t,t);
    m.Copy(m1,0,0,1,n+1,n,1);
    m1.FlipVer; m1.conj;
    m.Copy(m1,0,0,n+2,n+1,n,1);

    m1.Size(1,n,true); m1.RandUniform(-t,t);
    m.Copy(m1,0,0,0,1,1,n);
    m1.FlipHor; m1.conj;
    m.Copy(m1,0,0,0,n+2,1,n);

    m1.RandUniform(-t,t);
    m.Copy(m1,0,0,n+1,1,1,n);
    m1.FlipHor; m1.conj;
    m.Copy(m1,0,0,n+1,n+2,1,n);

  FreeIt(m1);
end;

procedure symv(var v:TVec; len:integer);    // len is even
begin
  v.Complex:=false; v.Length:=len;
  v.Ramp; v.Sub(v.Length div 2); v.Abs;
  v.Sub(v.Length div 2); //v.Abs; v.Add(1);
end;

procedure symvF(var v:TVec; len:integer);        // len is odd
begin
  v.Complex:=false; v.Length:=len;
  v.Ramp; v.Sub((v.Length - 1) div 2);
end;


procedure symmsq(var m:TMtx; len:integer);   // len is even
 var v,v1:TVec;
begin
  CreateIt(v,v1);
     symv(v,len);
     v.Sqr;
     v1.Complex:=false; v1.Length:=len; v1.Scale(0); v1.Add(1);
     m.TensorProd(v,v1); m.AddTensorProd(v1,v);
     m.Values[0,0]:=1;
  FreeIt(v,v1)
end;

procedure symmsqF(var m:TMtx; len:integer);   // len is odd
 var v,v1:TVec;
begin
  CreateIt(v,v1);
     symvf(v,len);
     v.Sqr;
     v1.size(len,false); v1.Scale(0); v1.Add(1);
     m.TensorProd(v,v1); m.AddTensorProd(v1,v);
     m.Values[(len-1) div 2,(len-1) div 2]:=1;
  FreeIt(v,v1)
end;

procedure genv1(var v1:TVec; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
begin

  h:=(en-be)/v1.Length;

  for i:=0 to v1.Length-1 do
     begin
      v1.Values[i]:=mac2(be+i*h,sm);
      //writeln(i/100:3:3,' ',v.Values[i]:3:3);
     end;
end;

procedure genv1_4(var v1:TVec; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
begin

  h:=(en-be)/v1.Length;

  for i:=0 to v1.Length-1 do
     begin
      v1.Values[i]:=mac2_4(be+i*h,sm);
      //writeln(i/100:3:3,' ',v.Values[i]:3:3);
     end;
end;

procedure spectorand(const m:TMtx; var m1:TMtx);
 var m2:TMtx;
begin
  CreateIt(m2);
    randflatsym(m2,m.rows);
    m2.MulElem(m);

           m2.FFT2D;

           m1.RealPart(m2);
  FreeIt(m2);
end;

procedure genmv(var mv:TMtx; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
     m,m1,m2,m3:TMtx;
begin
  CreateIt(m,m1{,m2},m3);

  symmsq(m1,sm);

  h:=(en-be)/mv.Cols;
  for j:=0 to mv.Cols-1 do
       begin
         alp:=be+h*j; alp:=-alp;

         m.Copy(m1); m.Power((alp-1)/4);

          for i:=0 to mv.Rows-1 do begin


          spectorand(m,m3);

           {randflatsym(m2,sm);

           m2.MulElem(m);

           m2.FFT2D;

           m3.RealPart(m2);}


           mv.Values[i,j]:=-alpha4(m3,t);


          end;
       end;
  FreeIt(m,m1{,m2},m3);
end;

procedure genmv_4(var mv:TMtx; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
     m,m1,m2,m3:TMtx;
begin
  CreateIt(m,m1{,m2},m3);

  symmsq(m1,sm);

  h:=(en-be)/mv.Cols;
  for j:=0 to mv.Cols-1 do
       begin
         alp:=be+h*j; alp:=-alp;

         m.Copy(m1); m.Power((alp-1)/4);

          for i:=0 to mv.Rows-1 do begin


          spectorand(m,m3);

           {randflatsym(m2,sm);

           m2.MulElem(m);

           m2.FFT2D;

           m3.RealPart(m2);}


           mv.Values[i,j]:=-alpha4_4(m3,t);


          end;
       end;
  FreeIt(m,m1{,m2},m3);
end;

procedure genmv_4all(var mv:TMtx; be,en:Extended; sm:integer);
 var i,j,k:integer;
     h,alp,t:Extended;
     m,m1,m2,m3:TMtx;
     v:TVec;
begin
  CreateIt(m,m1{,m2},m3);   CreateIt(v);

  symmsq(m1,sm);

  v.Size(mv.Cols*2,false); genv1{_4}(v,be,en,sm div 2);

  h:=(en-be)/mv.Cols;
  for j:=0 to mv.Cols-1 do
       begin
         alp:=be+h*j; alp:=-alp;

         m.Copy(m1); m.Power((alp-1)/4);

          for i:=0 to mv.Rows-1 do begin


          spectorand(m,m3);

           {randflatsym(m2,sm);

           m2.MulElem(m);

           m2.FFT2D;

           m3.RealPart(m2);}

           v.BinarySearch(-alpha4{_4}(m3,t),k);

           mv.Values[i,j]:=be+(en-be)*k/v.Length;


          end;
       end;
  FreeIt(m,m1{,m2},m3);  FreeIt(v);
end;

procedure genmv_fixed_alp(var mv:TMtx; sm:integer; alp:Extended);
 var i,j:integer;
     h,t:Extended;
     m,m1,m2,m3:TMtx;
     v:TVec;
begin
  CreateIt(m,m3);    CreateIt(v);

  v.Complex:=false; v.Length:=mv.Cols;

  symmsq(m,sm);






         m.Power((alp-1)/4);

          for i:=0 to mv.Rows-1 do begin


            spectorand(m,m3);
                        // m3.copy(m);
           {randflatsym(m2,sm);

           m2.MulElem(m);

           m2.FFT2D;

           m3.RealPart(m2);}

           cum_energy_scales(m3,v);

           //v.scale(1/v.Values[v.Length-1]);

            for j:=0 to mv.Cols-1 do mv.Values[i,j]:=v.Values[j];


          end;

  FreeIt(m,m3);   FreeIt(v);
end;

procedure norm_mv_fixed_alp(const mv:TMtx; var mv1:TMtx);
 var i,j:integer;
begin
  mv1.Complex:=mv.Complex; mv1.Rows:=mv.Rows; mv1.cols:=mv.cols-1;
  for i:=0 to mv1.Rows-1 do
    for j:=0 to mv1.Cols-1 do
      begin
        mv1.Values[i,j]:=mv.values[i,j+1]-mv.values[i,j];
        mv1.Values[i,j]:=mv1.Values[i,j]/intpower(2,j);
      end;
  mv1.Log2;
  for i:=0 to mv1.Rows-1 do
    for j:=0 to mv1.Cols-1 do
      begin
        mv1.Values[i,j]:=mv1.values[i,j]-mv1.values[i,mv1.cols-1];

      end;
end;

procedure norm_mv_fixed_alp_cor(const mv1:TMtx; var mv2:TMtx; alp1, alp2:Extended; sm,st:integer);
 var val:array of Tvec;
     i,j,k:integer;
begin
  SetLength(val,mv1.cols);

  for i:=0 to Length(val)-1 do CreateIt(val[i]);

  for i:=0 to Length(val)-1 do begin val[i].Complex:=false; val[i].Length:=st; end;

  intarray_norm_alpinterval(sm,alp1,alp2,val);

  mv2.size(mv1);

  for i:=0 to mv1.rows-1 do
    for j:=0 to mv1.cols-1 do
      begin
        val[j].BinarySearch(mv1.Values[i,j],k);
        mv2.Values[i,j]:=(alp1+k*(alp2-alp1)/st)*(mv2.cols-1-j);
        //write(k,' ');
      end;


  for i:=0 to Length(val)-1 do FreeIt(val[i]);
end;

procedure randmsp_re(var m:TMtx; len:integer; alpha:Extended);  // len is even
 var m1,m2:TMtx;
     n:integer;
begin
  CreateIt(m1);



   randflatsym(m1,len);


   symmsq(m,len);

   m.Power((alpha-1)/4);

   M1.MulElem(M);

   m1.FFT2D;

   m.RealPart(m1);

  FreeIt(m1);
end;

procedure randmspFsym_re(var m:TMtx; len:integer; alpha:Extended);  // len is odd
 var m1,m2:TMtx;
     n:integer;
begin
  CreateIt(m1);



   randflatFsym(m1,len);


   symmsqF(m,len);

   m.Power((alpha-1)/4);

   M.MulElem(M1);

   //symift(m,m1); m1.FFT2D; m.RealPart(m1); // writeln(m.Max);

  FreeIt(m1);
end;

procedure genv2(var v2:TVec; alp:Extended; sm:integer);
 var i:integer;
     m,m1,m2:TMtx;
     t:Extended;
begin
  CreateIt(m,{m1,}m2);

    symmsq(m,sm);

    m.Power((alp-1)/4);

          for i:=0 to v2.Length-1 do begin

           {randflatsym(m1,sm);

           m1.MulElem(m);

           m1.FFT2D;

           m2.RealPart(m1);}

           spectorand(m,m2);

           v2.Values[i]:=-alpha4(m2,t){-alp};
           //writeln(alp:3:3,': ',v.Values[i-1]:3:3);
           //writeln(i);
          end;

  FreeIt(m,{m1,}m2);
end;


procedure rand_Walsh(var m:TMtx; sm:integer; t:Extended);
 var m1,m2:TMtx;
begin
  CreateIt(m1,m2);
    m.Size(sm,sm,false);
    m.RandUniform(-t,t);
    reduce(m,2,2,m1);
    changesize(m1,m1.Rows,m1.Cols,m2);
    m.Sub(m2);

  FreeIt(m1,m2);
end;

procedure addnoise2_Walsh(const m:TMtx; alp,t:Extended; var m1:TMtx);
 var m2,m3:TMtx;
     sm:integer;
begin
  CreateIt(m2,m3);

    sm:=m.rows;

    changesize(m,3*sm,3*sm,m1);

    rand_Walsh(m2,2*sm,t); changesize(m2,m2.Rows,m2.Cols,m3);

    m1.Add(m3);

    rand_Walsh(m2,4*sm,t); m2.Scale(power(2,(alp+1)/2));

    m1.Add(m2);

  FreeIt(m2,m3);
end;

procedure genmv_Walsh(var mv:TMtx; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
     m,m1,m2,m3:TMtx;
begin
  CreateIt(m,m1);

  m.Size(sm,sm,false);

  h:=(en-be)/mv.Cols;
  for j:=0 to mv.Cols-1 do
       begin
         alp:=be+h*j; alp:=-alp;



          for i:=0 to mv.Rows-1 do begin


           m.RandUniform(-10,10);

           addnoise2_Walsh(m,alp,1,m1);



           mv.Values[i,j]:=-alpha4(m1,t);


          end;
       end;
  FreeIt(m,m1);
end;

procedure genv2_Walsh(var v2:TVec; alp:Extended; sm:integer);
 var i:integer;
     m,m1,m2:TMtx;
     t:Extended;
begin
  CreateIt(m,m1);

    m.Size(sm,sm,false);

          for i:=0 to v2.Length-1 do begin

           m.RandUniform(-10,10);

           addnoise2_Walsh(m,alp,1,m1);

           v2.Values[i]:=-alpha4(m1,t)

          end;

  FreeIt(m,m1);
end;


{procedure Walsh_basis3(var m1,m2,m3:TMtx; sm:integer);
 var m:TMtx;
begin
  CreateIt(m);
    m.Size(2,2,false);
    m.Values[0,0]:=1;  m.Values[0,1]:=-1;
    m.Values[1,0]:=-1; m.Values[1,1]:=1;
    changesizee(m,sm, sm, m1);

    m.Values[0,0]:=1;  m.Values[0,1]:=-1;
    m.Values[1,0]:=1;  m.Values[1,1]:=-1;
    changesizee(m,sm, sm, m2);

    m3.Copy(m2); m3.Transp;
  FreeIt(m);
end; }

procedure Walsh_basis3(var m1,m2,m3:TMtx; sm:integer);
 var v1,v2,v3,v4:TVec;
     i:integer;
     j:Extended;
begin
  CreateIt(v1,v2,v3,v4);

    v1.Size(sm,false); v1.scale(0); v1.Add(1);

    {v2.Size(sm,false); j:=1;
    for i:=0 to v2.Length-1 do begin j:=-j; v2.Values[i]:=j end;  }
    v3.Size(sm div 2,false); v3.Scale(0); v3.Add(1);
    v4.Size(2,false); v4.Values[0]:=1; v4.Values[1]:=-1;
    v2.Kron(v3,v4);

    m1.TensorProd(v2,v2); m2.TensorProd(v1,v2);

    m3.Copy(m2); m3.Transp;
  FreeIt(v1,v2,v3,v4);
end;

procedure rand_Walsh3(var m:TMtx; sm:integer; t:Extended);   overload;
 var m1,m2,m3,m4:TMtx;
begin
  CreateIt(m1,m2,m3,m4);
    Walsh_basis3(m1,m2,m3,sm);

    m4.Size(sm div 2, sm div 2, false); m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m);
    m.MulElem(m1);

    m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m1);

    //m2.MulElem(m1); m.Add(m2);
    m.AddProduct(m1,m2);

    m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m1);

    //m3.MulElem(m1); m.Add(m3);
    m.AddProduct(m1,m3);

  FreeIt(m1,m2,m3,m4);
end;

procedure addnoise3_Walsh(const m:TMtx; alp,t:Extended; var m1:TMtx);  overload;
 var m2,m3:TMtx;
     sm:integer;
begin
  CreateIt(m2,m3);

    sm:=m.rows;

    changesize(m,3*sm,3*sm,m1);

    rand_Walsh3(m2,2*sm,t); changesize(m2,m2.Rows,m2.Cols,m3);

    m1.Add(m3);

    rand_Walsh3(m2,4*sm,t); m2.Scale(power(2,(alp+1)/2));

    m1.Add(m2);

  FreeIt(m2,m3);
end;

procedure genv2_Walsh3(var v2:TVec; alp:Extended; sm:integer);
 var i:integer;
     m,m1,m2:TMtx;
     t:Extended;
begin
  CreateIt(m,m1);

    m.Size(sm,sm,false);

          for i:=0 to v2.Length-1 do begin

           m.RandUniform(-10,10);

           addnoise3_Walsh(m,alp,1,m1);

           v2.Values[i]:=-alpha4(m1,t)

          end;

  FreeIt(m,m1);
end;

procedure rand_Walsh3(var m:TMtx; const m1,m2,m3:TMtx; t:Extended);   overload;
 var sm:integer;
     m4,m5:TMtx;
begin
  CreateIt(m4,m5);

    sm:=m1.Rows;

    m4.Size(sm div 2, sm div 2, false); m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m);
    m.MulElem(m1);

    m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m5);

    //m2.MulElem(m1); m.Add(m2);
    m.AddProduct(m5,m2);

    m4.RandUniform(-t,t);
    changesize(m4, m4.Rows, m4.cols, m5);

    //m3.MulElem(m1); m.Add(m3);
    m.AddProduct(m5,m3);

  FreeIt(m4,m5);
end;

procedure addnoise3_Walsh(const m,m1,m2,m3,m21,m22,m23:TMtx;
                                alp,t:Extended; var m4:TMtx);  overload;
 var m32,m33:TMtx;
     sm:integer;
begin
  CreateIt(m32,m33);

    sm:=m.rows;

    changesize(m,3*sm,3*sm,m4);

    rand_Walsh3(m32,m1,m2,m3,t); changesize(m32,m32.Rows,m32.Cols,m33); //m1 - 2sm

    m4.Add(m33);

    rand_Walsh3(m32,m21,m22,m23,t); m32.Scale(power(2,(alp+1)/2));      // m21 - 4sm

    m4.Add(m32);

  FreeIt(m32,m33);
end;


procedure genv2_Walsh3a(var v2:TVec; alp:Extended; sm:integer);
 var i:integer;
     m,m1,m11,m12,m13,m21,m22,m23:TMtx;
     t:Extended;
begin
  CreateIt(m,m1,m11,m12);  CreateIt(m13,m21,m22,m23);

    m.Size(sm,sm,false);

    Walsh_basis3(m11,m12,m13,2*sm);

    Walsh_basis3(m21,m22,m23,4*sm);

          for i:=0 to v2.Length-1 do begin

           m.RandUniform(-10,10);

           addnoise3_Walsh(m,m11,m12,m13,m21,m22,m23,alp,1,m1);

           v2.Values[i]:=-alpha4(m1,t)

          end;

  FreeIt(m,m1,m11,m12);  FreeIt(m13,m21,m22,m23);
end;


procedure genmv3_Walsh(var mv:TMtx; be,en:Extended; sm:integer);
 var i,j:integer;
     h,alp,t:Extended;
     m,m1,m11,m12,m13,m21,m22,m23:TMtx;
begin
  CreateIt(m,m1,m11,m12);  CreateIt(m13,m21,m22,m23);

  m.Size(sm,sm,false);

  Walsh_basis3(m11,m12,m13,2*sm);

    Walsh_basis3(m21,m22,m23,4*sm);

  h:=(en-be)/mv.Cols;
  for j:=0 to mv.Cols-1 do
       begin
         alp:=be+h*j; alp:=-alp;

          writeln('alp number:',' ',j);

          for i:=0 to mv.Rows-1 do begin


           m.RandUniform(-10,10);


           addnoise3_Walsh(m,m11,m12,m13,m21,m22,m23,alp,1,m1);



           mv.Values[i,j]:=-alpha4(m1,t);


          end;
       end;
  FreeIt(m,m1,m11,m12);  FreeIt(m13,m21,m22,m23);
end;

procedure testsym;
 var m,m1:TMtx;
     t:Extended;
begin
  CreateIt(m,m1);

    randmsp_re(m,560,-2);

    writeln(alpha4(m,t));

  FreeIt(m,m1); readln;
end;


procedure symmPareto(var m:TMtx; t:Extended);  // t >= 1
 var m1:TMtx;
begin
  CreateIt(m1);
   RandomGenPareto(1/(t-1),0,1,m);
   m1.Size(m);
   RandomGenPareto(1/(t-1),0,1,m1);
   m.Sub(m1);
  FreeIt(m1);
end;

/////////////////////////////////////////
/////////////////////////////////////////
//////////// very experimental //////////

procedure symmsq12(var m:TMtx; len:integer);
 var v,v1:TVec;
begin
  CreateIt(v,v1);
     symv(v,len);
     v.Sqr;
     v1.Complex:=false; v1.Length:=len; v1.Scale(0); v1.Add(1);
     m.TensorProd(v,v1); m.AddTensorProd(v1,v);
     m.Values[0,0]:=1;
     m.Sqrt;
  FreeIt(v,v1)
end;


procedure symf(var m:TMtx; len:integer; f:TF1D);
 var i,j,N:integer;
begin

  m.Size(len+1,len+1,false);

  N:=(m.Rows-1) div 2;

  for i:=0 to m.Rows-1 do
    for j:=0 to m.Cols-1 do
      begin
        m.Values[i,j]:=f(sqrt(sqr(i-N)+sqr(j-N)));
      end;

end;


procedure symsymFT_re(const mf:TMtx; var m:TMtx);
 var N:integer;
     m2:TMtx;
begin
    CreateIt(m2);
    m.Copy(mf); m.FlipHor; m.Add(mf);

    m2.Copy(m); m2.FlipVer; m.Add(m2);
    FreeIt(m2);
end;

procedure energysymF(const symf:TMTx;  ev:TVec);
 var i,j,N,p:integer;
     el:Extended;
begin
  N:=(symf.Rows-1) div 2;
  ev.size(N+1,false); ev.Scale(0);
  for i:=0 to symf.Rows-1 do
    for j:=0 to symf.Cols-1 do
      begin
        p:=ceil(sqrt(sqr(i-N)+sqr(j-N)));
        if symf.Complex then el:=norm(symf.CValues[i,j]) else
                             el:=sqr(symf.Values[i,j]);
        if p<=ev.Length-1 then ev.Values[p]:=ev.Values[p]+el;
      end;
end;




procedure testv;
 var v,v1,v2:TVec;
begin
  CreateIt(v,v1,v2);
    v.Size(100,false);
    v.RandUniform(-10,10);
    histogram(v,10,v1,v2);
    writev(v2);
    writeln;
    writeln(v.Sum/v.length:4:4);
    writeln(v.Min:4:4);
    writeln(v.Max:4:4);
  FreeIt(v,v1,v2);           readln;
end;

end.
