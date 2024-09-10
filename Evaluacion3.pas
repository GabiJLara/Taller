Program Evaluacion3;
Type    
    Prestamo = Record   
        Numero: integer;
        ISBN: integer;
        CodigoSocio: Integer;
    end;
    ListaArbol = record
        Numero: integer;
        CodigoSocio: integer;
    end;
    Lista= ^Nodo;
        Nodo = record
            dato: ListaArbol;
            sig: Lista;
        end;
    PrestamosLibro = Record
        ISBN: integer;
        ListaPrestamos: Lista;
    end;
    Arbol=^NodoArbol;
        NodoArbol= record
            Dato: PrestamosLibro;
            HI:Arbol;
            HD:Arbol;
        end;
    Socios = record
        CodigoSocio: integer;
        CantPrestamos: integer;
    end;
    ListaSocios = ^NodoSocio;
        NodoSocio = record
            Dato: Socios;
            Sig: listaSocios;
        end;

Procedure LeerPrestamo (var P: Prestamo);
begin
    Writeln('Ingrese Codigo De Socio: '); Readln (P.CodigoSocio);
    If (P.CodigoSocio <> 0 ) then
    begin
        Writeln('Ingrese Numero De Prestamo: '); Readln(P.Numero);
        Writeln('Ingrese ISBN: '); Readln(P.ISBN);
    end;
end;


Procedure AgregarLista (Var L:Lista; P:Prestamo);
var 
    aux:lista;
begin
    new(aux);
    aux^.dato.numero:= P.Numero;
    aux^.dato.CodigoSocio:= P.CodigoSocio;
    if(L = Nil) then
    begin
        L:= aux;
        L^.sig:= Nil;
    end
    else
    begin
        aux^.sig:= L;
        L:= aux;
    end;
end;


Procedure IngresarElemento (Var a:arbol; P:Prestamo);
begin
    If (a = nil) then
    begin
        new(a);
        a^.dato.ListaPrestamos:= Nil;
        a^.dato.ISBN := P.ISBN;
        AgregarLista (a^.dato.ListaPrestamos,P);
        A^.HI:= Nil;
        A^.HD:= Nil;
    end
    else
        if(a^.dato.ISBN = P.ISBN) then
            AgregarLista (a^.dato.ListaPrestamos, P)
        else
            if( a^.dato.ISBN < P.ISBN) then
                IngresarElemento(a^.HD, P)
            else
                IngresarElemento(a^.HI, P);
end;


Procedure CargarListaSocios (var LS:ListaSocios; cod:integer; cantidad: integer);
var 
    Aux:ListaSocios;
begin
    new(aux);
    aux^.dato.CodigoSocio:= cod;
    aux^.dato.CantPrestamos:= Cantidad;
    if( LS = Nil) then
    begin
        LS:= Aux;
        LS^.sig:= Nil;
    end
    else
        Aux^.sig:= LS;
        LS:= Aux;
end;


Procedure CargarArbolYLista (var A:Arbol; var LS:listaSocios);
var
    P:Prestamo; h:integer; CantPrestamos:integer;
begin
    a:=Nil;
    Writeln('-----------COMIENZA CARGA DEL ARBOL-----------');
    LeerPrestamo(P);
    While (P.CodigoSocio <> 0 )do
    begin
        h:=P.CodigoSocio;
        CantPrestamos:= 0;
        While(P.CodigoSocio <> 0) and (h = P.CodigoSocio) do
        begin 
            CantPrestamos:= CantPrestamos + 1;
            IngresarElemento(A,P);
            LeerPrestamo(P);
        end;
        CargarListaSocios(ls,H,CantPrestamos);
    end;
end;


Function ContarCantidadLista (L: Lista):integer;
begin
    ContarCantidadLista:= 0;
    while(L <> NIL) DO
    begin
        ContarCantidadLista:= ContarCantidadLista + 1;
        L:= L^.sig;
    end;
end;


Function CantidadISBN (A:arbol; Num: integer):integer;
begin
    if(a = nil) then
        CantidadISBN:= 0
    else
        if(a^.dato.ISBN = Num) then
            CantidadISBN:= ContarCantidadLista(a^.dato.ListaPrestamos)
        else
        if(a^.dato.ISBN < Num) then
            CantidadISBN:= CantidadISBN(A^.HD,Num)
        else
            CantidadISBN:= CantidadISBN(A^.HI,Num);
end;


Procedure IngresarNum (a:arbol);
var
    ISBN:Integer;
begin
    Writeln('Ingrese ISBN A Buscar:'); Readln (ISBN);
    Writeln('La Cantidad De Prestamos De Ese Libro Es De:',CantidadISBN(A,ISBN));
end;


function CantidaPrestamosMayor (LS:ListaSocios; x:integer): integer;
begin
    if(LS = nil ) then
        CantidaPrestamosMayor:= 0
    else
        If( LS^.dato.CantPrestamos > x) then
            CantidaPrestamosMayor:= 1 + CantidaPrestamosMayor(LS^.sig, X)
        else
            CantidaPrestamosMayor:= CantidaPrestamosMayor(LS^.sig, X);
end;

Procedure IngresarX (LS:ListaSocios);
var
    Num:integer;
begin
    Writeln('Ingrese Numero:'); Readln(num);
    Writeln('La Cantidad De Socios Con Mas De ', num, ' Prestamos Es De: ', CantidaPrestamosMayor(LS,Num));
end;
//PROGRAMA PRINCIPAL
var
    a:arbol; LS:ListaSocios;
begin
    CargarArbolYLista(A,LS);
    If(a <> nil) then
        IngresarNum (a)
    else
        Writeln('------------ARBOL VACIO--------------');
    IF( LS <> NIL) then
        IngresarX(LS)
    else
        writeln('----------LISTA VACIA---------');
    
end.    