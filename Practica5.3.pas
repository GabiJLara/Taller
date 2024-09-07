Program Practica5.Tres;
Const
	Dimf= 10;
Type
	Producto = Record
		Codigo: integer;
		Rubro: integer;
		Stock: integer;
		PrecioUnitario: Real;
	end;
	Arbol=^NodoArbol;
	NodoArbol = Record
		Dato: Producto;
		HI:Arbol;
		HD:Arbol;
	End;
	Vector = array [1..DimF] of Arbol;


Procedure LeerProducto (Var P: Producto);   //LEE EL PRODUCTO
Begin
	Writeln('Ingrese Codigo De Producto: '); Readln(P.Codigo);
	If(P.Codigo <> 0 )then
	begin
		Writeln('Ingrese Rubro (Numero entre 1 y 10):'); Readln(P.Rubro);
		Writeln('Ingrese stock: '); Readln(P.Stock);
		Writeln('Ingrse Precio Por Unidad: '); Readln(P.PrecioUnitario);
	end;
end;


Procedure InsertarElemento (Var A: Arbol; P:Producto); //INSERTA ELEMENTO EN EL NODO DEL ARBOL
begin
	if(a = Nil) then
	Begin
	New(a);
	A^.dato:= P;
	A^.HI:= Nil;
	A^.HD:=Nil;
	end
	Else
		If(a^.dato.Codigo <= P.Codigo) then
			InsertarElemento(A^.HD,P)
		Else
			InsertarElemento(A^.HI,P)
end;


Procedure InicializarVector(var vec:Vector; var A:Arbol); //INICIALIZA EL VECTOR
var
	i:Integer;
begin
	For i:=1 to DimF Do Begin
	Vec[i]:= Nil;
	End;
end;


Procedure CargarVectorDeArboles(Var Vec:Vector; var A:Arbol); //CARGA EL VECTOR DE ARBOLES
var
	P:Producto;
begin
	Writeln('-----COMIENZA LA CARGA DE LA ESTRUCTURA----');
	LeerProducto(P);
	While (P.codigo <> 0 )do
	begin
		InsertarElemento(Vec[P.Rubro],P);
		LeerProducto(P);
	end;
end;


Procedure ImprimirArbol(A: Arbol); //IMPRIME EL ARBOL
begin
	If( A <> Nil) then
	begin
		ImprimirArbol(A^.HI);
		Writeln('Codigo De Producto: ',A^.dato.codigo, ' Stock: ',a^.Dato.Stock, ' Precio Por Unidad: ', A^.dato.PrecioUnitario:2:2);
		ImprimirArbol(A^.HD);
	end;
end;


Procedure ImprimirVector(Vec:Vector); //POR CADA POSICION DEL VECTOR LLAMA A IMPRIMIR EL ARBOL
var
	i:integer;
begin
	For i:= 1 to DimF do
	begin
		Writeln ('Rubro Numero: ', i); 
		If (vec[i] <> NiL) then
			ImprimirArbol(Vec[i])
		Else
			Writeln('-------No Hay Productos En el Rubro-------')
	end;
end;


Function BuscarCodigoArbol(A:Arbol; codigo:integer):integer; //BUSCAR CODIGO DE FORMA RECURSIVA
begin
	If(A = nil) then
		BuscarCodigoArbol := 0
	else
		if(a^.dato.codigo = Codigo)then
			BuscarCodigoArbol:= Codigo
		else
			BuscarCodigoArbol:= (BuscarCodigoArbol(a^.HI,Codigo)) or (BuscarCodigoArbol(a^.HD,Codigo))
end;


Procedure SolicitarCodigoYRubro (Var R:Integer; var C:Integer); //PIDE INGRESAR RUBRO Y CODIGO
begin
	Writeln('Inserte Rubro En El Que Buscar: '); Readln(R);
	Writeln('Inserte Codigo De Producto A Buscar: '); Readln(C);
end;


Procedure RubroCodigo (Vec:vector; Rubro:Integer; Codigo: Integer);// LLAMA A INGRESAR RUBRO Y CODIGO E IMPRIME RESULTADO
begin
	If (BuscarCodigoArbol(Vec[rubro],Codigo) <> 0) then
		Writeln ('El Codigo Buscado Si Fue Encontrado')
	Else
		Writeln('------EL CODIGO BUSCADO NO SE ENCUENTRA EN EL RUBRO------');
end;


Procedure MaximoArbol( A:Arbol; var Max:integer; var Stock:integer); //BUSCA EL MAXIMO CODIGO DENTRO DEL ARBOL Y DEVUELVE EL CODIGO + EL STOCK
begin

	if(a <> nil)then
		if (A^.dato.codigo >= Max)then
		begin
			Max:= a^.dato.codigo;
			Stock:= A^.dato.stock;
			MaximoArbol(A^.HD,Max,Stock);
		end
		Else
			MaximoArbol(A^.HD,Max,Stock);
end;


Procedure MaximosVector (Vec:vector); //LLAMA A BUSCAR MAXIMOS EN ARBOL POR CADA POSICION DEL VECTOR
var
	i,CodMax,Stock :integer;
begin
	CodMax:= -1;
	for i:= 1 to DimF do
	begin
		MaximoArbol(Vec[i],CodMax,Stock);
		if (vec[i] <> nil)then
			Writeln('En El Rubro: ',i, ' El Producto De Mayor Codigo Es: ', CodMax, ' Con Un Stock de: ',Stock)
		Else
			Writeln('------No Hay Maximos Por Que El Vector En La Posicion: ',i,' No Esta Cargado-----');
	end;
end;

Function BuscarEnArbol (a:Arbol; C1: integer; C2:integer):integer; //RECORRE EL ARBOL Y BUSCA DENTRO DEL RANGO
begin
	If(A = Nil) then
		BuscarEnArbol:= 0
	else
		If(a^.dato.codigo > C1) and (A^.dato.Codigo < C2) then
			BuscarEnArbol:= 1 + BuscarEnArbol(A^.HI,c1,c2) + BuscarEnArbol(A^.HD,c1,c2)
		else
			If (a^.dato.codigo <= C1) then
				BuscarEnArbol:= BuscarEnArbol(a^.HD,C1,C2)
			else
				BuscarEnArbol:= BuscarEnArbol(a^.HI,C1,C2);
end;


Procedure RecorrerVector(Vec:vector; Codigo1:integer; codigo2:integer); //RECORRE EL VECTOR LLAMANDO A RECORRER EL ARBOL E IMPRIMIR
var
	i: integer;
begin
	For i:= 1 to DimF do
	begin
		if (vec[i] <> Nil) then
			Writeln('La cantidad de codigos comprendidos en la posicion:', i, ' dentro del rango es: ',BuscarEnArbol(Vec[i],Codigo1,Codigo2))
		else
			writeln('-----El Vector En La Posicion:', i, ' Se Encuentra Vacio------')
	end;
end;


Procedure Rango (Vec: vector; var c1:integer; var c2: integer);
begin
	Writeln('Ingrese Parte baja del rango: '); Readln(C1);
	Writeln('Ingrese Parte alta del rango: '); Readln(C2);
	RecorrerVector(Vec,c1,c2);

//PROGRAMA PRINCIPAL
Var
	a:arbol; Vec:Vector; R,C:Integer;
Begin
	InicializarVector(Vec,A);
	CargarVectorDeArboles(Vec,A);
	Writeln('/////////////////////////////////////////////////////');
	 Writeln('-----IMPRESION DE LA ESTRUCTURA-----');
	ImprimirVector(Vec);
	Writeln('/////////////////////////////////////////////////////');
	SolicitarCodigoYRubro(R,C);
	RubroCodigo(Vec,R,C);
	Writeln('/////////////////////////////////////////////////////');
	MaximosVector(Vec);
	Writeln('/////////////////////////////////////////////////////');
End.
