{
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.

}

Program ImperativoClase3;

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

procedure GenerarArbol(var a: arbol; S: socio);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

Begin
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 a:= nil;
 CargarSocio (s);
 while (s.numero <> 0)do
  begin
   InsertarElemento (a,s);
   CargarSocio (s);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;




procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
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

procedure InformarSociosOrdenDecreciente (a: arbol);
{ Informar los datos de los socios en orden decreciente. }
  
  procedure InformarDatosSociosOrdenDecreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenDecreciente (a^.HD);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenDecreciente (a^.HI);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenDecreciente (a);
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

procedure BusquedaSocio (a: arbol);
var nom: string;


Function InformarExistenciaNombreSocio(a: arbol; Nom:string):boolean;

begin
		if (a = nil) then
			InformarExistenciaNombreSocio:= False
		else 
			if (Nom = A^.dato.nombre)then
				InformarExistenciaNombreSocio:= True
			else
				InformarExistenciaNombreSocio := InformarExistenciaNombreSocio(a^.HI,nom) or InformarExistenciaNombreSocio(a^.HD,nom);
end;

begin
	Writeln('Ingrese nombre de socio a buscar: ');Readln(Nom);
	Writeln(InformarExistenciaNombreSocio(a,nom));
end;

Function InformarCantidadSocios (a: arbol):integer;

begin
	if (A = nil) then
		InformarCantidadSocios:= 0
	else begin
		InformarCantidadSocios:= InformarCantidadSocios(a^.HI)+InformarCantidadSocios(a^.HD) + 1;
	end;
end;


function SumaEdades (a: arbol):integer;

begin
	if (A = nil) then
		SumaEdades:= 0
	else begin
		SumaEdades:= SumaEdades(a^.HI)+ SumaEdades(a^.HD) + a^.dato.edad;
	end;
end;

Procedure InformarPromedioDeEdad (a: arbol);
	var cant: integer ; prom: real;
begin
	cant:= InformarCantidadSocios(a);
	Prom:= SumaEdades(a) / cant;
	Writeln('Promedio de edades: ', Prom)
end;


var a: arbol; s: socio;
Begin
	randomize;
	GenerarArbol (a,s);
	If (A = Nil) then
		Writeln('-----Arbol vacio-----')
	Else
		Begin
		InformarSociosOrdenCreciente (a);
		InformarSociosOrdenDecreciente (a);
		InformarNumeroSocioConMasEdad (a);
		Writeln('Cantidad de socios en el arbol: ', InformarCantidadSocios (a));
		Writeln('Suma de las edades de los socios: ', SumaEdades(a));
		InformarPromedioDeEdad (a);  
		AumentarEdadNumeroImpar (a);
		BusquedaSocio(a);
		end;
End.
