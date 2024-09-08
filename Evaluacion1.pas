Program Evaluacion;
Type
	Pasajes = record
		CodigoVuelo:integer;
		CodigoCliente: integer;
		CodigoCiudad: integer;
		MontoPasaje: real;
	end;
	PasajesLista = Record
		CodigoVuelo: integer;
		CodigoCliente: Integer;
		MontoPasaje: Real;
	end;
	Lista=^nodo;
		Nodo=record
			Dato:PasajesLista;
			Sig:Lista;
		end;
	ArbolDeListas= Record
		CodigoCiudad:integer;
		ListaArbol:Lista;
	end;
	Arbol=^NodoArbol;
		NodoArbol= Record
			Dato:ArbolDeListas;
			HI:Arbol;
			HD:Arbol;
		end;
		

Procedure LeerPasaje (Var P: Pasajes);   //LEE PASAJES POR TECLADO
begin
	Writeln('Ingrese Monto De Pasaje: '); Readln(P.MontoPasaje);
	If (P.MontoPasaje <> 0 ) then
	begin
		Writeln('Ingrese Codigo De Vuelo: '); Readln(P.CodigoVuelo);
		Writeln('Ingrese Codigo De Cliente: '); Readln(P.CodigoCliente);
		Writeln('Ingrese Codigo De Ciudad: ');Readln(P.CodigoCiudad);
	end;
end;		
		

Procedure AgregarLista (var L:Lista; P:Pasajes); // AGREGA A LA LISTA LOS PASAJES 
var
	aux: Lista;
begin
	New (aux);
	Aux^.dato.CodigoVuelo:= P.CodigoVuelo;
	Aux^.dato.CodigoCliente:= P.CodigoCliente;
	Aux^.dato.MontoPasaje:= P.MontoPasaje;
	if (L= Nil) then
	begin
		L:= aux;
		L^.sig:= Nil;
	end
	else
	begin
		Aux^.Sig:= L;
		L:=Aux;
	end;
end;

Procedure InsertarElemento (var A: Arbol; P:Pasajes); //INSERTA ELEMENTO EN UN NUEVO NODO O SI ES DE LA MISMA CIUDAD LLAMA A AGREGAR A LA LISTA DE ESE NODO
Begin
	If (a = nil) then
	begin
		New (a);
		a^.dato.CodigoCiudad:= P.CodigoCiudad;
		A^.dato.ListaArbol:= Nil;
		AgregarLista (a^.dato.ListaArbol,P);
		A^.HD:= Nil;
		A^.HI:= Nil;
	end
	else 
		if(a^.dato.CodigoCiudad = P.CodigoCiudad) then
			AgregarLista(a^.dato.ListaArbol,P)
		else
			if(a^.dato.CodigoCiudad < P.CodigoCiudad)then
				InsertarElemento(A^.HD,P)
			else
				InsertarElemento(A^.HI,P)
end;	
	
	
Procedure CargarArbol (var A:Arbol); //CARGA EL ARBOL Y LEE PASAJES
var
	p:pasajes;
begin
	Writeln('-------------COMIENZA CARGA DEL ARBOL-----------');
	LeerPasaje(P);
	While (P.MontoPasaje <> 0 ) do	
	begin
		InsertarElemento(A,P);
		LeerPasaje(P);
	end;
end;


Procedure ImprimirLista (L:Lista); //IMPRIME LA LISTA
begin
	While (L <> Nil) do
	begin
		Writeln('Codigo De Vuelo: ', L^.dato.CodigoVuelo, ' Codigo De Cliente: ', L^.dato.CodigoCliente, ' Monto Del Pasaje: ', L^.dato.MontoPasaje:2:2);
		L:=L^.sig;
	end;
end;

Procedure ImprimirArbol(a: arbol); //IMPRIME EL ARBOL DE FORMA CRECIENTE
begin
	If (a <> Nil) then
	begin
		ImprimirArbol (a^.HI);
		Writeln ('---------Pasajes A La Ciudad Con Codigo: ', a^.dato.CodigoCiudad,' ----------');
		ImprimirLista (a^.dato.ListaArbol);
		ImprimirArbol(a^.HD);
	end

end;


Procedure ImprimirCiudad (A:Arbol; Codigo:Integer); //IMPRIME LOS VUELOS DE DICHA CIUDAD
begin
	If (a <> nil)then
	begin
		if(a^.dato.CodigoCiudad = Codigo) then
			ImprimirLista(A^.dato.ListaArbol)
		else
			if(a^.dato.CodigoCiudad < Codigo) then
				ImprimirCiudad(a^.HD,codigo)
			else
				ImprimirCiudad (a^.HI,Codigo)
	end
	else
		Writeln('-------CIUDAD SIN VUELOS-----------');
end;
	
		
Procedure IngreseCodigo (A:arbol); //LLAMA A INGRESAR CODIGO DE CIUDAD PARA BUSCAR SI TIENE VUELOS Y LLAMA A IMPRIMIRLOS
var
	C1:integer;
begin
	Writeln ('Ingrese Codigo De Ciudad Que Quiera Imprimir: '); Readln(C1);
	Writeln('-----ARRANCA A IMPRIMIR PASAJES A LA CIUDAD DESTINO----');
	ImprimirCiudad(A,C1);
end;
		

Function ContarLista (L:Lista):Integer; //CUENTA LA CANTIDAD DE ELEMENTOS DE UNA LISTA
begin
	ContarLista:= 0;
	While (L <> NIl) do
	begin
		ContarLista:= ContarLista + 1;
		L:= L^.sig;
	end;
end;


Function MaxPasajes (a:Arbol; var Max:integer):Integer; //ANALIZA EL MAXIMO Y LLAMA A CONTAR ELEMTNOS DE LA LISTA
var
	MaxAct,MaxIzq,MaxDe, MaxIzqCiudad, MaxDeCiudad:integer;
begin
	If (a = Nil) then
	begin
		MaxPasajes:= -1;
		Max:= -1
	end
	else
	begin
		MaxAct:= ContarLista (a^.dato.ListaArbol);
		MaxIzqCiudad:= MaxPasajes(A^.HI,maxIzq);
		MaxDeCiudad:= MaxPasajes(A^.HD,maxDe);
		if (MaxAct >= MaxIzq) and (MaxAct >= MaxDe) then
		begin
			MaxPasajes := a^.dato.CodigoCiudad;
			Max:= MaxAct;
		end
		else if (MaxIzq >= MaxAct) and (MaxIzq >= MaxDe) then
		begin
			MaxPasajes := MaxIzqCiudad;
			Max := MaxIzq;
		end
		else
		begin
			MaxPasajes := MaxDeCiudad;
			Max := MaxDe;
		end;
  end;
end;


	
		
		//PROGRAMA PRINCIPAL
var
	a:Arbol; maxCant:integer;
begin
	CargarArbol(a);
	If (a <> Nil )then
	begin
		ImprimirArbol (a);
		Writeln('///////////////////////////////////////////////////');
		IngreseCodigo(A);
		Writeln('///////////////////////////////////////////////////');
		MaxCant:=-1;
		Writeln ('La Ciudad Que Mas Pasajes Vendio Es La Del Codigo : ', MaxPasajes(A,maxCant));
		Writeln('///////////////////////////////////////////////////');
	end
	else
	Writeln('---------------ARBOL VACIO-------------')
	
end.	
