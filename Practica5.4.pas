Program Practica5.Cuatro;
Type
	Reclamos = Record
		Codigo:integer;
		DNI: integer;
		Ano: integer;
		Tipo: String;
	end;
	ReclamosLista= Record
		Codigo: integer;
		Ano: integer;
		Tipo: string;
	end;
	Lista=^nodo;
		nodo=record
			Dato:ReclamosLista;
			Sig:Lista;
		end;
	ReclamosArbol = Record
		DNI: integer;
		TotalReclamos: integer;
		ListaReclamos: Lista;
	end;
	Arbol=^NodoArbol;
		NodoArbol= record
			Dato:ReclamosArbol;
			HI:Arbol;
			HD:Arbol;
	end;

Procedure LeerReclamo(Var R:Reclamos); // LEE LOS RECLAMOS
begin
	Write('Ingrese Codigo Del Reclamo: '); Readln(R.Codigo);
	If (R.Codigo <> 0) then
	begin
		Writeln('Ingrese DNI Del Reclamante: '); Readln(R.DNI);
		Writeln('Ingrese Anio Del Reclamo: '); Readln(R.Ano);
		Writeln ('Ingrese Tipo De Reclamo: '); Readln(R.Tipo);
	end;
end;


Procedure CargarLista (var L: Lista; R:Reclamos); //CARGA LA LISTA DEL NODO DEL ARBOL
var
	aux: Lista;
begin
	new (aux);
	aux^.dato.Codigo:= R.Codigo;
	aux^.dato.Ano:= R.Ano;
	Aux^.Dato.Tipo:= R.Tipo;
	If ( L = Nil)then
	begin
		L:= aux;
		L^.sig:= Nil;
	end
	else begin
		aux^.sig:= L;
		L:= aux;
	end;
end;


Procedure InsertarElemento (var A:Arbol; R:Reclamos); //INSERTA ELEMENTO EN NUEVO NODO O LLAMA A CARGAR EN LISTA CUANDO COINCIDEN DNI
begin
	If (a = nil) then
	begin
		new(a);
		a^.Dato.ListaReclamos:= Nil;
		a^.dato.DNI:= R.DNI;
		A^.Dato.TotalReclamos:= 1;
		CargarLista(A^.dato.ListaReclamos,R);
		A^.HI:= Nil;
		A^.HD:= Nil;
	end
	else
		if(a^.dato.DNI = R.DNI) then
		begin
			CargarLista(A^.dato.ListaReclamos,R);
			a^.dato.TotalReclamos:= a^.dato.TotalReclamos + 1;
		end
		else
			if(a^.dato.Dni < R.DNI) then
				InsertarElemento(A^.HD,R)
			else
				InsertarElemento(A^.HI,R);
end;


Procedure CargarArbol (var a: arbol); //CARGA EL ARBOL
var
	R:Reclamos;
begin
	A:=Nil;
	Writeln ('--------------COMIENZA LA CARGA DEL ARBOL----------');
	LeerReclamo(R);
	While (R.Codigo <> 0 )do
	begin
		InsertarElemento(A,R);
		LeerReclamo(R);
	end;
end;


Procedure ImprimirLista(L:Lista); //IMPRIME LA LISTA DE RECLAMOS POR CADA DNI
begin
	While (L <> Nil) do
	begin
		Writeln ('Reclamo Codigo:', L^.dato.Codigo, ' Ano Del Reclamo: ', L^.Dato.Ano, ' Tipo De Reclamo: ',L^.Dato.Tipo);
		L:= L^.Sig;
	end;
end;


Procedure ImprimirArbol(A:Arbol); //IMPRIME EL ARBOL DE FORMA CRECIENTE POR DNI
begin
	if (a <> nil) then
	begin
		ImprimirArbol(A^.HI);
		Writeln(' El Usuario Con DNI: ', A^.dato.DNI,' Tiene ', a^.dato.TotalReclamos, ' Reclamos. ');
		ImprimirLista(A^.dato.ListaReclamos);
		ImprimirArbol(A^.HD);
	end;
end;

Procedure CantReclamos (A: Arbol; N: integer); //RECORRE RECURSIVAMENTE EL ARBOL EN BUSQUEDA DEL DNI SI ENCUENTRA IMPRIME SUS DATOS SINO NO TIENE DATOS
begin
	if (a = nil) then
		Writeln('La persona no tiene Reclamos')
	else
		if(a^.dato.dni = N)Then
			writeln('La persona tiene ', a^.dato.TotalReclamos,' Reclamos') 
		else
			if (A^.Dato.Dni < N)then
				CantReclamos(A^.HD,N)
			else
				CantReclamos(A^.HI,N);
end;


Procedure PreguntarDNI (a:arbol); //PREGUNTA DNI Y LLAMA A BUSCAR SUS RECLAMOS
var
	dni:integer;
begin
	Writeln('Ingrese DNI A Buscar: '); Readln(Dni);
	CantReclamos(A,Dni)
end;


Function DentroRango (A:Arbol; N1: Integer; N2: integer):integer; //DEVUELVE LA CANTIDAD DE RECLAMOS QUE HAY DENTRO DEL RANGO DE DNI'S
begin
	If(a = nil)then
		DentroRango:= 0
	else
		if(a^.dato.dni >= N1) and (a^.dato.dni <= N2) then
			DentroRango:= A^.dato.TotalReclamos + DentroRango(A^.HI, N1, N2) + DentroRango(A^.HD, N1, N2)
		Else
			if (a^.dato.dni < N1) then
				DentroRango:= DentroRango(a^.HD, N1, N2)
			Else
				DentroRango:= DentroRango (a^.HI, N1 ,N2);
end; 


Procedure PreguntarRango (a: arbol); //PIDE QUE INGRESES DNI'S PARA RANGO Y TE DICE EL TOTAL DE RECLAMOS DENTRO DE ESE RANGO
var
	DNI1:INTEGER; DNI2:integer;
begin
	Writeln ('Ingrese DNI Para Rango (Parte Baja): '); Readln(DNI1);
	Writeln ('Ingrese DNI Para Rango (Parte Alta): '); Readln(DNI2);
	Writeln('Cantidad De Reclamos Dentro De Ese Rango Es: ',DentroRango(a,DNI1,DNI2));
end;


procedure RecorrerLista (L: lista; num: integer; var Total: integer);
begin
	While (L <> nil) do
	begin
		if (L^.Dato.ano = Num) then
		begin
			Total:= Total + 1;
			L:= L^.sig;
		end
		else
			L:=L^.Sig;
	end;
end;


Procedure BuscarAno (a: arbol; Num: integer; var Total:Integer);
begin
	if (a <> nil) then
	begin
		BuscarAno (a^.HI, Num, Total);
		RecorrerLista(a^.dato.ListaReclamos, Num, Total);
		BuscarAno (a^.HD, Num, Total);
	end
end;


Procedure PedidoDeAno(a:arbol);
var
	Num: integer; Total: integer;
begin
	Total:= 0;
	Writeln ('Ingrese Anio Para Buscar Cantidad De Reclamos Dentro De Ese Anio: '); Readln(Num);
	BuscarAno(a,Num,Total);
	Writeln('Cantidad De Reclamos En El Anio: ', Num, ' Es De: ', Total);
end;


// INICIA EL PROGRAMA PRINCIPAL
var
	A:Arbol;
begin
	CargarArbol(A);
	Writeln('////////////////////////////////////////////////');
	If (a <> Nil) then
	begin
		ImprimirArbol(A);
		Writeln('////////////////////////////////////////////////');
		PreguntarDNI(A);
		Writeln('////////////////////////////////////////////////');
		PreguntarRango(a);
		Writeln('////////////////////////////////////////////////');
		PedidoDeAno(a);
		Writeln('////////////////////////////////////////////////');
	end
	else
		Writeln('----------------ARBOL VACIO---------------')
end.
