Program Evaluacion;
Type
	Pasajes = record
		CodigoVuelo:integer;
		CodigoCliente: integer;
		CodigoCiudad: integer;
		MontoPasaje: real;
	end;
	Lista=^nodo;
		Nodo=record
			Dato:Pasajes;
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
begin
	
end.
