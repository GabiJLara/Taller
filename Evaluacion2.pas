Program Evaluacion2;
Type
	Recital = record
		Nombre: string;
		Fecha: String;
		CantCanciones: integer;
		Monto: Real;
	end;
	Arbol= ^NodoArbol;
		NodoArbol= Record
			Dato: Recital;
			HI: Arbol;
			HD: Arbol;
		end;
	Lista=^nodo;
		Nodo=record
			dato: recital;
			Sig: Lista;
		end;

Procedure LeerRecital (Var R:Recital); //LEE RECITALES
begin
	Writeln('Ingrese Nombre De La Banda: ');Readln(R.Nombre);
	If (R.Nombre <> 'ZZZ') then
	Begin
		Writeln ('Ingrese Fecha Del Recital: '); Readln (R.Fecha);
		Writeln('Ingrse Cantidada De Canciones Tocadas Por La banda: '); Readln(R.CantCanciones);
		Writeln('Ingrese Monto Recaudado: '); Readln(R.Monto);
	end;
end;


Procedure InsertarElemento (Var A:Arbol; R:Recital); //INSERTA ELEMENTOS EN NODOS ORDENADOS POR MONTO RECAUDADO
Begin
	If (A = Nil) then
	begin
		new(A);
		A^.dato:= R;
		A^.HI:=Nil;
		A^.HD:=Nil;
	end
	else
		If (A^.dato.Monto <= R.Monto) then
			InsertarElemento(A^.HD,R)
		else
			InsertarElemento(A^.HI,R);
end;


Procedure CargarArbol (var a:arbol); //CARGA EL ARBOL LEYENDO RECITALES
var
	R:Recital;
begin
	Writeln ('----------COMIENZA CARGA DEL ARBOL-------');
	A:=Nil;
	LeerRecital(R);
	While (R.Nombre <> 'ZZZ' ) do
	begin
		InsertarElemento(a, R);
		LeerRecital(R);
	end;
end;


Procedure ImprimirArbol(A:Arbol); //IMPRIME EL ARBOL ENTERO DE FORMA CRECIENTE
begin
	IF (a <> nil) then
	begin
		ImprimirArbol(a^.HI);
		Writeln ('Nombre De la banda: ', A^.dato.Nombre, ' Fecha Del Recital: ',a^.dato.Fecha, ' Cantidad De Canciones: ',A^.Dato.CantCanciones, ' Monto Total Recaudado: ',a^.dato.Monto:2:2);
		ImprimirArbol (a^.HD);
	end;
end;


Procedure AgregarListaOrdenada (Var L:Lista; R: Recital); //AGREGA LISTA ORDENADA DE MAYOR A MENOR
var 
	ant,act,nue: lista;
begin
	new(nue);
	nue^.dato:= R;
	act:= L;
	ant:= Nil;
	While (act<> Nil) and (act^.dato.Monto > nue^.dato.monto) do
		begin
			ant:=act;
			act:= act^.sig;
		end;
	If (act=L) then
		L:= nue
	else
		Ant^.sig:= nue;
	nue^.sig:=act;
end;


Procedure EntreDosRangos (A:arbol; valor1:Real; Valor2:Real; var L:Lista); // VERIFICA QUE ELELEMENTO ESTE DENTRO DEL RANGO Y LLAMA A CARGAR LA LISTA
begin
	If (a <> nil) then
	BEGIN
		If (a^.dato.monto >= Valor1) and (a^.dato.monto <= Valor2) then	
			AgregarListaOrdenada(L,a^.dato);
		EntreDosRangos(A^.HD,Valor1,Valor2,L);
		EntreDosRangos(A^.HI,Valor1,Valor2,L);
	end;

END;


Procedure Rango (a:arbol; var L:Lista); //LLAMA A PEDIR RANGO Y A ARMAR LA LISTA SI ESTA DENTRO DEL RANGO
var
	V1,V2: Real;
begin
	Writeln('Ingrese Parte Baja Del Rango: ');Readln(V1);
	Writeln('Ingrese Parte Alta Del Rango: ');Readln(V2);
	L:= Nil;
	EntreDosRangos(A,V1,V2,L);
end;


Procedure ImprimirLista (L:Lista); //IMPRIME LISTA ENTERA
begin
	Writeln ('------------IMPRESION DE LA LISTA COMPLETA----------');
	While (L<> NIL)DO
	begin
		Writeln ('Nombre De la banda: ', L^.dato.Nombre, ' Fecha Del Recital: ',L^.dato.Fecha, ' Cantidad De Canciones: ',L^.Dato.CantCanciones, ' Monto Total Recaudado: ',L^.dato.Monto:2:2);
		L:=l^.sig;
	end;
end;


Function CantRecitales12 (L:Lista):integer; //DEVUELVE CANTIDAD DE RECITALES CON MAS DE 12 CANCIONES DENTRO DE LA LISTA
begin
	IF (L = nil) then
		CantRecitales12:= 0
	else
		If (L^.Dato.CantCanciones > 12) then
			CantRecitales12:= 1 + CantRecitales12(L^.sig)
		else
			CantRecitales12:= CantRecitales12(L^.sig);
end;


 //PROGRAMA PRINCIPAL
var
	a:arbol;L:Lista;
begin
	CargarArbol(A);
	if(a <> Nil) then
	Begin
		ImprimirArbol(A);
		Writeln('///////////////////////////////////////////////////');
		Rango(A,L);
		ImprimirLista(L);
		Writeln('///////////////////////////////////////////////////');
		Writeln('Cantidad De Recitales Que Cantaron Mas De 12 Canciones: ', CantRecitales12(L));
		Writeln('///////////////////////////////////////////////////');
	end
	else
		Writeln('-------------ARBOL VACIO------------');
end.
