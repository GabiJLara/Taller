Program Practica4Ejercicio2;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
  End;

var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if (a <> nil) then begin 
		InformarDatosSociosOrdenCreciente (a^.HI);
		writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
		InformarDatosSociosOrdenCreciente (a^.HD);
	end;		
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

     procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
  function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
  end;

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


function SocioMasGrande (a: arbol):integer;
begin
    if (a = Nil) then 
        SocioMasGrande:= -1
    else
        Begin
        SocioMasGrande:= SocioMasGrande(a^.HD);
        if (a^.dato.numero > SocioMasGrande) then
            SocioMasGrande:= a^.dato.numero
        else
            SocioMasGrande:= SocioMasGrande(a^.HD)
        end
        
end;

Procedure SocioMasChico (a: arbol);

begin
    if (a = Nil) then 
        Writeln('----ARBOL VACIO-----')
    else
        if (a^.HI = Nil) then
            writeln ('Socio Numero: ',a^.dato.numero,' Nombre: ',a^.dato.nombre,' Edad: ',a^.dato.edad)
        else
            SocioMasChico(a^.HI)
        
end;

function BuscarNumero (a: arbol; Num: integer ): boolean;
begin
    If (a = Nil) then
        BuscarNumero:= false
    else
        If (a^.dato.numero = num) then  
            BuscarNumero:= true 
        else
        BuscarNumero:= BuscarNumero(a^.HI,num) or BuscarNumero(A^.HD,num)
end;

Procedure Busqueda (a: arbol);
    var n:integer;
begin
    Writeln('Inserte un codigo a buscar: '); Readln(n);
    if(BuscarNumero(a,n)) then
        writeln('El socio buscado existe ',BuscarNumero(a,n))
    else
        Writeln('El socio buscado no existe ',BuscarNumero(a,n))
end;

Function CuentaDentroDeRango (a: arbol; Bajo:integer; Alto:integer): integer;
begin
    if (a = Nil) then
        CuentaDentroDeRango:= 0
    else
        if (a^.dato.numero > Bajo) and (a^.dato.numero < Alto) then
            CuentaDentroDeRango:= CuentaDentroDeRango(a^.HI,Bajo,Alto) + CuentaDentroDeRango(a^.HD,Bajo,Alto) + 1
        else
            if (a^.dato.numero <= Bajo) then
                CuentaDentroDeRango:= CuentaDentroDeRango(a^.HD,Bajo,Alto)
            else
                if(a^.dato.numero >= Alto ) then
                CuentaDentroDeRango:=  CuentaDentroDeRango(a^.HI,Bajo,Alto)
end;

procedure Rango (a:arbol);
    var Bajo:integer; Alto:integer;
begin
    Writeln('Inserte un numero de socio: '); Readln(Bajo);
    Writeln('Inserte un numero de socio mayor al anterior:'); Readln(Alto);
    Writeln('Cantidad de socios dentro del rango: ',CuentaDentroDeRango(a,Bajo,Alto))
end;


var a: arbol; 
Begin
  randomize;
  GenerarArbol (a);
  If (a <> Nil) then begin

  InformarSociosOrdenCreciente (a);
  InformarNumeroSocioConMasEdad (a);
  Writeln('El numero de socio mas grande es: ', SocioMasGrande(a));
  SocioMasChico(a);
  Busqueda(a);
  Rango(a);
  AumentarEdadNumeroImpar (a);

    end
  else
  writeln('-----arbol vacio--------');  
End.
