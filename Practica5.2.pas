Program Practica5.Dos;
Type    
    Autos = record  
        Patente: string[7];
        Anio: integer;        //PREGUNTAR COMO ACOTAR EL RANGO ENTRE 2010 Y 2018 ESTOY QUEMADO Y ME OLVIDE//
        Marca: string;
        Modelo: String;
    end;
    arbol1= ^NodoArbol1;
        NodoArbol1= record
            dato: Autos;
            HI: arbol1;
            HD: arbol1;
        end;
        Lista= ^nodo;
            Nodo= record
            dato: Autos;
            sig: Lista;
    end;
    Autos2 = record
        Marca: String;
        ListaAutos: Lista;
    end;
        
    Arbol2= ^NodoArbol2;
        NodoArbol2 = Record
            dato: Autos2;
            HI: Arbol2;
            HD: Arbol2;
        end;

Procedure LeerAuto (var A: Autos);   //Lee Los autos//
begin
    Writeln('Ingrese Marca Del auto: '); Readln(A.Marca);
    if (A.Marca <> 'MMM') then
    begin
        Writeln('Inserte Patente Del auto: '); Readln(A.Patente);
        Writeln('Inserte Anio Del Auto (Entre 2010 y 2018): '); Readln(A.Anio);
        Writeln('Inserte Modelo Del auto'); Readln(A.Modelo)
    end;
end;

Procedure InsertarElemento1 (var a1: arbol1; A:autos); //INSERTA ELEMENTO EN ARBOL 1 ORDENADO POR PATENTES
begin
    If (a1 = Nil) then  
    begin
        New (a1);
        a1^.dato:= A;
        a1^.HI:= Nil;
        a1^.HD:= Nil;
    end
    else
        if (a1^.dato.patente <= A.Patente) then
            InsertarElemento1(a1^.HD,a)
        else
            InsertarElemento1(a1^.HI,a);

end;

Procedure AgregarAdelante (Var L:Lista; A:Autos); //AGREGAR ADELANTE EN LA LISTA DE CADA NODO DEL ARBOL 2
var 
    aux:Lista;
begin
        New (aux);
        aux^.dato:= A;
        aux^.Sig:= Nil;
        if (L = Nil) then
            L:= aux
        else
        begin
            aux^.sig:= L;
            L:= aux;
        end;
end;


Procedure InsertarElemento2(var a2: Arbol2; A:Autos); //INSERTA EL ELEMENTO ORDENADO POR MARCA Y LLAMA A AGREGAR ADELANTE CUANDO ES DE LA MISMA MARCA
begin
    If (A2 = Nil) then
    begin
        New (a2);
        a2^.dato.marca:= A.Marca;
        A2^.dato.ListaAutos:= Nil;
        AgregarAdelante(a2^.dato.ListaAutos,A);
        a2^.HI:= Nil;
        a2^.HD:= Nil;
    end
    else
        if(a2^.dato.Marca = A.Marca) then
            AgregarAdelante(a2^.dato.ListaAutos,A)
        else
            If (a2^.dato.Marca < A.Marca) then
                InsertarElemento2(a2^.HD,a)
            else
                InsertarElemento2(a2^.HI,a);
end;

Procedure GenerarArboles (var A1:Arbol1; var A2:Arbol2); // LEE AUTOS Y VA CARGANDO LOS DOS ARBOLES
var
    A:Autos;
begin
    A1:= Nil;
    A2:= Nil;
    Writeln('--------Comienza Carga De Arboles--------');
    LeerAuto(A);
    While (A.marca <> 'MMM') do
    begin
        InsertarElemento1(A1,A);
        InsertarElemento2(A2,a); 
        LeerAuto(A);
    end;
end;

Procedure ImprimirArbol1(a1:arbol1);    //IMPRIME EL ARBOL 1 ORDENADO DE FORMA CRECIENTE POR PATENTE
begin
    If (A1 <> nil) then
    begin
        ImprimirArbol1(a1^.HI);
        Writeln('Patente del Auto: ', a1^.dato.Patente, ' Anio del auto: ', a1^.dato.anio, ' Marca del Auto: ', a1^.dato.Marca, ' Modelo Del auto: ',a1^.dato.Modelo);
        ImprimirArbol1(a1^.HD)
    end;
end;

Procedure ImprimirLista (L:lista); //IMPRIME LA LISTA DE CADA NODO DE MARCA DEL ARBOL2
begin
    While (l <> Nil) do
    begin
        Writeln('Patente del auto: ', L^.dato.patente, ' Anio del Auto: ', L^.dato.anio, ' Modelo Del Auto: ', L^.dato.modelo);
        L:= L^.sig;
    end;
end;

Procedure ImprimirArbol2 (A2: arbol2); //IMPRIME EL ARBOL 2 DE FORMA CRECIENTE POR MARCA
begin
    If(a2 <> Nil) then
    begin
        ImprimirArbol2(A2^.HI);
        Writeln('-----> Marca: ', a2^.dato.marca);
        ImprimirLista(a2^.dato.ListaAutos);
        ImprimirArbol2(A2^.HD);
    end;
end;

Function CantMarcasArbol1 (A1:arbol1; Marca:string): integer;  //CUENTA LA CANTIDAD DE AUTOS DE LA MISMA AMRCA EN EL ARBOL 1
begin
    if (a1 = Nil) then  
        CantMarcasArbol1:= 0
    else
    begin
        cantMarcasArbol1:= + CantMarcasArbol1(a1^.HI, Marca) + CantMarcasArbol1(a1^.HD, Marca);
        If (a1^.dato.marca = Marca ) then
            CantMarcasArbol1:= CantMarcasArbol1 + 1;
    end;
end;

{Function CantMarcasArbol1 (A1:arbol1; Marca:string): integer;  //PREGUNTAR POR QUE NO FUNCIONA
begin
    if (a1 = Nil) then  
        CantMarcasArbol1:= 0
    else
        if (a1^.dato.Marca = marca) then
            CantMarcasArbol1:= CantMarcasArbol1 + CantMarcasArbol1(a1^.HI, Marca) + CantMarcasArbol1(a1^.HD, Marca) + 1
        else
            if(a1^.dato.Marca <= Marca) then
                CantMarcasArbol1:= CantMarcasArbol1(a1^.HD, Marca)
            else
                CantMarcasArbol1:=CantMarcasArbol1(a1^.HI, Marca);
end;}

Function ContarElementos (L:lista):integer; //CUENTA LOS ELEMENTOS DE LA LISTA DEL NODO DEL ARBOL 2
begin
    ContarElementos:= 0;
    While (L <> NiL) DO
    Begin
        ContarElementos:= ContarElementos + 1;
        L:= L^.sig;
    end;    
end;

Function CantMarcasArbol2 (A2: Arbol2; Marca: String): integer; //RECORRE DE MANERA RECURSIVA EL ARBOL 2 PARA ENCONTRAR EL NODO CON LA MARCA Y LLAMA A CONTAR LOS ELEMENTOS DE LA LISTA
begin
    if (a2 = Nil) then
        CantMarcasArbol2:= 0
    else
        if (a2^.dato.marca = Marca) then
            CantMarcasArbol2:= ContarElementos(a2^.dato.ListaAutos)
        else
            if(a2^.dato.marca < Marca) then
                CantMarcasArbol2(a2^.HD, Marca)
            else
                CantMarcasArbol2(a2^.HI, Marca)
end;

Procedure BuscarCantidadPorMarca(a1:arbol1; a2:arbol2); // PIDE QUE INGRESES UNA MARCA Y CUENTA LA CANTIDAD DE AUTOS DE ESA MARCA EN LAS DOS LISTAS
var
    Marca:String;
begin
    Writeln('Inserte Una Marca:'); Readln(Marca);
    Writeln('Cantidad de autos de la marca ingresada : ',CantMarcasArbol1(a1,Marca));
    Writeln('Cantidad de autos de la marca ingresada : ',CantMarcasArbol2(a2,Marca));

end;

Procedure BuscarPatenteA1 (a1: arbol1; Pat: string);  // BUSCA LA PATENTE EN EL ARBOL 1 DE MANERA RECURSIVA Y NORMAL
begin
    if(a1 = Nil)then
        writeln('------Patente No encontrada----')
    else
        if(A1^.Dato.Patente = Pat) then
            Writeln('Modelo del auto con dicha patente: ', a1^.dato.Modelo)
        else
            if(a1^.dato.Patente < Pat ) then
                BuscarPatenteA1(a1^.HD, Pat)
            else
                BuscarPatenteA1 (A1^.HI, Pat);
end;


Function BuscarPatenteEnLista (L:lista; pat:String): boolean; //BUSCA EN LA LISTA DENTRO DE CADA NODO DEL ARBOL 2 E IMPRIME MODELO DE PANTENTE EN "MODE"
var 
    Mode:String;
begin
    BuscarPatenteEnLista:= False;
    while (L <> nil) and (BuscarPatenteEnLista = False) do
    Begin
        If(L^.dato.Patente = Pat) then
        begin
            BuscarPatenteEnLista:= true;
            Mode:= L^.dato.Modelo;
        end;
        L:= L^.sig;
    end;
    if (BuscarPatenteEnLista = true) then
        Writeln('Modelo del auto con dicha patente: ', Mode);
end;


Procedure BuscarPatente2 (a2:arbol2; Pat: String); // RECORRE DE MANERA RECURSIVA EL ARBOL Y HACE LLAMADO A RECORRER LISTA EN CADA NODO
begin
    If(a2 <> NiL) then   
    begin
        Buscarpatente2(a2^.HI,Pat);
        BuscarPatenteEnLista(a2^.dato.ListaAutos,Pat);
        BuscarPatente2(a2^.HD,Pat);
    end;
end;


Procedure BuscarPatente (a1:arbol1; a2:arbol2); //LLAMA A INGRESAR UNA PATENTE A BUSCAR Y A BUSCARLA EN LOS DOS ARBOLES LLAMANDO A LOS DOS MODULOS
var 
    Patente:String;
begin
    Writeln('Ingrese patente del auto a buscar: '); Readln(Patente);
    Writeln('--------BUSQUEDA EN ABOL 1---------');
    BuscarPatenteA1(a1,Patente);
    Writeln('--------BUSQUEDA EN ABOL 2---------');
    BuscarPatente2(A2,Patente);
end;


{FALTA Invoque a un módulo que reciba el árbol generado en a) i y retorne una estructura con
la información de los autos agrupados por año de fabricación.}


/// ARRANCA EL PROGRAMA PRINCIPAL///
var
    a1:arbol1; a2:arbol2;
begin
    GenerarArboles(a1,a2);
    If (a1 <> Nil) and (a2 <> Nil) then 
    Begin
        writeln('-----------------IMPRESION ARBOL 1------------------');
        ImprimirArbol1(a1);
        Writeln('/////////////////////////////////////////////////////');
        Writeln('-----------------IMPRESION ARBOL 2------------------');
        ImprimirArbol2(a2);
        Writeln('/////////////////////////////////////////////////////');
        Writeln('QUEREMOS SABER LA CANTIDAD DE AUTOS POR MARCA');
        BuscarCantidadPorMarca(a1,a2);
        Writeln('/////////////////////////////////////////////////////');
        Writeln('QUEREMOS SABER EL MODELO DE LA PATENTE BUSCADA');
        BuscarPatente(a1,a2);
    end
    else
    Begin
        writeln('--------------------ARBOL 1 SE ENCUENTRA VACIO----------------------');
        writeln('------------------ARBOL 2 SE ENCUENTRA VACIO------------------------------'); 
    end;
end.
