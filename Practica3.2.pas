Program Practica3dos;
Type
	Ventas = record
		Codigo: integer;
		Fecha : 1..31;
		Cant:integer;
	end;
	Arbol= ^nodoArbol;
	NodoArbol= record
		dato: Ventas;
		HI: Arbol;
		Hd: Arbol;
	End;
	Producto = record
		Codigo: integer;
		CantTotal:integer;
	end;
	Arbol2= ^nodoArbol2;
	NodoArbol2= record
		dato: Producto;
		HI:Arbol2;
		HD: Arbol2;
	end;

Procedure LeerVenta (var V: Ventas); //Lee Ventas
begin
	Writeln('Escribir codigo del producto: '); Readln(V.Codigo);
	If (V.Codigo <> 0) then
	Begin
		V.Fecha:= 1 + random(31);
		V.Cant:= 1 + random(25);
	end;	
end;


Procedure InsertarElemento(var a: arbol; V: Ventas); //Inserta Elemento en el nodo
begin
	If (a = nil) then
	begin
		new(a);
		a^.dato:= V;
		a^.HI:= Nil;
		a^.HD:= Nil;
	end
	else
		if (V.codigo < a^.dato.codigo) then
			InsertarElemento(a^.HI,V)
		else
			InsertarElemento(a^.HD,V)
end;


Procedure CargarArbol(var a: arbol);  //Carga el arbol y lee ventas
var	
	V: ventas;
begin
 writeln ('----- Ingreso de ventas y armado del arbol ----->');
 a:= nil;
 LeerVenta(V);
 while (V.codigo <> 0)do
 begin
	InsertarElemento (a,V);
	LeerVenta(V);
  end;
 writeln ('//////////////////////////////////////////////////////////');
end;

procedure ImprimirArbol1 (a: arbol); 

  procedure Imprimir (a: arbol);
  begin
    if (a <> nil) then
    begin
		Imprimir (a^.HI);
		writeln ('Codigo producto: ', a^.dato.codigo, ' Fecha: ', a^.dato.Fecha, ' Cantidad vendida: ', a^.dato.Cant);
        Imprimir (a^.HD);
         end;
  end;

begin
  writeln ('----- Impresion Del Arbol 1 Ordenado de forma creciente ----->');
  if ( a = nil) then
	writeln ('Arbol vacio')
  else 
	Imprimir (a);
  writeln ('-----------------------------------------------');
end;

//-----------ACA ARRANCA TODO LO RELACIONADO AL SEGUNDO ARBOL------------
	
Procedure CargarProducto(Var P: producto; V:ventas);
begin
	If (v.codigo <> 0) then
	begin
		P.Codigo:= V.Codigo;
		P.CantTotal:= V.cant;
	end;
end;	
	
Procedure InsertarElemento2 (var a:arbol2; P:producto);
begin
	If (a = nil) then
	begin
		new(a);
		a^.dato:= P;
		a^.HI:= Nil;
		a^.HD:= Nil;
	end
	else
		if (P.codigo = a^.dato.codigo) then
			A^.dato.CantTotal:= a^.dato.CantTotal +P.CantTotal
		else
			if (P.Codigo < a^.dato.codigo)then
			InsertarElemento2(a^.HI,P)
		else
			InsertarElemento2(a^.HD,P)
end;

Procedure CargarArbol2(var a: arbol2);  //Carga el segundo arbol y lee ventas
var	
	V: ventas; P:producto;
begin
 writeln ('----- Ingreso de ventas y armado del arbol ----->');
 a:= nil;
 LeerVenta(V);
 CargarProducto(P,V);
 while (V.codigo <> 0)do
 begin
	InsertarElemento2 (a,p);
	LeerVenta(V);
	CargarProducto(P,V);
  end;
 writeln ('//////////////////////////////////////////////////////////');
end;


Procedure ImprimirArbol2 (a:arbol2);

 procedure Imprimir2 (a: arbol2);
  begin
    if (a <> nil) then
    begin
		Imprimir2 (a^.HI);
		writeln ('Codigo producto: ', a^.dato.codigo,' Cantidad vendida total: ', a^.dato.CantTotal);
        Imprimir2 (a^.HD);
         end;
  end;

begin
  writeln ('----- Impresion Del Arbol 2 Ordenado de forma creciente ----->');
  if ( a = nil) then
	writeln ('Arbol vacio')
  else 
	Imprimir2 (a);
  writeln ('-----------------------------------------------');
end;

var
	A: arbol; A2:Arbol2;
begin
	Randomize;
	CargarArbol(A);
	ImprimirArbol1(A);
	CargarArbol2(A2);
	ImprimirArbol2(A2)
end.
