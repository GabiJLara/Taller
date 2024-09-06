program Practica4.tres;
type
    Producto = record
        Codigo: integer;
        CantTotalVendido: integer;
        PrecioUnitario: integer;
    end;
    Ventas = record
        CodigoV: integer;
        CodigoP: integer;
        CantidadVendida: integer;
        PrecioUnidad: integer;
    end;    
    arbol = ^nodoArbol;
    nodoArbol = record
        dato: Producto;
        HI: arbol;
        HD: arbol;
    end;    

{Procedure LeerVentas (var v: ventas);    // PARA PROBAR
begin
    Randomize;
    Writeln('Inserte Codigo de venta: '); Readln(v.CodigoV);
    If (v.CodigoV <> -1 ) then
    begin
        Writeln('codigo producto: ');Readln(v.CodigoP); 
        Writeln('cantidad vendida'); Readln(v.CantidadVendida);
        v.PrecioUnidad:= 5 + Random (20); 
    end;
end;}

Procedure LeerVentas (var v: ventas); 
begin
    Randomize;
    Writeln('Inserte Codigo de venta: '); Readln(v.CodigoV);
    If (v.CodigoV <> -1 ) then
    begin
        v.CodigoP:= Random(51) * 100;
        v.CantidadVendida:= 1 + Random (100);
        v.PrecioUnidad:= 5 + Random (20);{ PREGUNTAR COMO HAGO PARA QUE EL PRECIO POR UNIDAD SIEMPRE SEA EL MISMO Y HACER REALES RANDOMS} {HACIENDOLO ASI SOLO GUARDO EL PRIMER PRECIO UNITARIO LEIDO}
    end;
end;

Procedure CopiarProducto (V: ventas; var P: Producto);
begin
    If (v.CodigoV <> -1) then
        P.Codigo:= V.CodigoP;
        P.CantTotalVendido:= V.CantidadVendida;
        P.PrecioUnitario:= V.PrecioUnidad;
end;

Procedure InsertarProducto (var a: arbol; P: Producto);
begin
    if (a = Nil) then
    begin
        new(a);
        a^.dato:= P;
        a^.HI:= Nil;
        a^.HD:= Nil;
    end
    else
        if(a^.dato.codigo = P.codigo) then
            a^.dato.CantTotalVendido:= a^.dato.CantTotalVendido + P.CantTotalVendido
        else
            if (a^.dato.codigo < P.codigo) then 
                InsertarProducto(a^.HD,P)
            else
                InsertarProducto(a^.HI,P)    
end;

Procedure CargarArbol (var a: arbol);
    var P: producto; V: ventas;
begin
    writeln ('----- Ingreso de productos y armado del arbol ----->');
    
    LeerVentas(V);
    CopiarProducto(V,P);
    While (v.codigoV <> -1) do
    begin
        InsertarProducto(a,P);
        LeerVentas(V);
        CopiarProducto(V,P);
    end;
    writeln ('//////////////////////////////////////////////////////////');
end;

Procedure ImprimirOrdenCreciente(a: arbol);
begin
    If (a <> Nil) then
    begin
        ImprimirOrdenCreciente(A^.HI);
        Writeln('Codigo Producto: ', a^.dato.Codigo, ' Cantidad vendida: ', a^.dato.CantTotalVendido, ' Precio por unidad: ', a^.dato.PrecioUnitario);
        ImprimirOrdenCreciente(A^.HD);
    end;    
end;

Procedure ImprimirArbol( a: arbol);
begin
    Writeln('-----Productos en orden creciente por codigo de producto---');
    ImprimirOrdenCreciente(a);
    writeln ('//////////////////////////////////////////////////////////');
end;

{Function ProductoMasvendido (a: arbol): integer;
    var max: integer;
begin
    if (a = nil) then
        ProductoMasvendido:= 0
    else
    begin
        max:=a^.dato.CantTotalVendido
        if(max > )
    end;
end;}

{function CodigoConCantidadMaxima(a: arbol): integer;
var
    codigoHI, codigoHD: integer;
    cantHI, cantHD: integer;
begin
    if (a = nil) then
    begin
        CodigoConCantidadMaxima := -1;
    end
    else
    begin
        if (a^.HI <> nil) then
        begin
            codigoHI := CodigoConCantidadMaxima(a^.HI);
            cantHI:= a^.HI^.dato.CantTotalVendido;
        end
        else
        begin
            codigoHI := -1;
            cantHI:= -MaxInt;
        end;

        if (a^.HD <> nil) then
        begin
            codigoHD := CodigoConCantidadMaxima(a^.HD);
            cantHD := a^.HD^.dato.CantTotalVendido;
        end
        else
        begin
            codigoHD := -1;
            cantHD := -MaxInt;
        end;

        if (a^.dato.CantTotalVendido > cantHI) and (a^.dato.CantTotalVendido > cantHD) then
        begin
            CodigoConCantidadMaxima := a^.dato.Codigo;
        end
        else if (cantHI >= cantHD) then
        begin
            CodigoConCantidadMaxima := codigoHI;
        end
        else
        begin
            CodigoConCantidadMaxima := codigoHD;
        end;
    end;
end;}

function CantDeCodigosMenores (a:arbol; N:integer):integer;
begin
    if(a = nil) then
        CantDeCodigosMenores:= 0
    else
        if( a^.dato.Codigo < N) then
            CantDeCodigosMenores:= CantDeCodigosMenores(a^.HI, N) + CantDeCodigosMenores(a^.HD, N) + 1
        else
            CantDeCodigosMenores:= CantDeCodigosMenores(a^.HI,N)
end;

procedure BuscarMenores (a: arbol);
    var N: integer;
begin
    Writeln('Inserte un numero para buscar cantidad de codigos menores al mismo: '); 
    Readln(N);
    Writeln('Cantidad de codigos por debajo de ese numero: ',CantDeCodigosMenores(a, N));
end;


function MontoEntreValores (a:arbol; codigo1:integer; codigo2:integer):integer;
begin
    if(a = NiL) then
        MontoEntreValores:= 0
    else   
        if(a^.dato.codigo > codigo1) and (a^.dato.codigo < codigo2) then
        MontoEntreValores:= MontoEntreValores(a^.HI,codigo1,codigo2) + MontoEntreValores(a^.HD,codigo1,codigo2) + (a^.dato.CantTotalVendido * a^.dato.PrecioUnitario)
        else
            if (a^.dato.codigo <= codigo1) then
                MontoEntreValores:= MontoEntreValores(a^.HD,codigo1,codigo2)
            else
                if(a^.dato.codigo >= codigo2) then
                    MontoEntreValores:= MontoEntreValores(a^.HI,codigo1,codigo2)
end;


Procedure BuscarMontoEntreValores (a: arbol);
    var C1,C2:integer;
begin
    Writeln('Inserte numero(Parte baja del rango): '); Readln(C1);
    Writeln('Inserte numero mayor al ingresado recien(parte alta del rango): '); Readln(C2);
    Writeln('Monto total dentro del rango: ', MontoEntreValores(a,C1,C2))
end;


    var a:arbol;
begin
    a:= nil;
    CargarArbol(a);
    ImprimirArbol(a);
    BuscarMenores(a);
    BuscarMontoEntreValores(a);


    //Writeln('El producto mas vendido es el del codigo: ', CodigoConCantidadMaxima(a));
end.
