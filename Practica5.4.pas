Program Practica5.Cuatro;
Type
	Reclamos = Record
		Codigo:integer;
		DNI: integer;
		Ano: integer;
		Tipo: String;
	end;
		Lista=^nodo;
		nodo=record
			Dato:Reclamos;
			Sig:Lista;
		end;
	ReclamoArbol=record 
		DNI: integer;
		ListaReclamos: lista;
	end;
	Arbol=^NodoArbol;
	NodoArbol= record
		Dato:ReclamoArbol;
		HI:Arbol;
		HD:Arbol;
	end;

begin
end.
