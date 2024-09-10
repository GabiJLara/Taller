Program Evaluacion4;
const
    DimF= 15;
Type
    Atencion= record
        DNI: integer;
        Mes: integer;
        Codigo: 1..dimF;
    end;
    ASD= record
        DNI: INTEGER;
        CantTotal: integer;
    end;
    Arbol= ^NodoArbol;
        NodoArbol= record
            dato: ASD;
            HI: ARBOL;
            HD: Arbol;
        end;
    Vector = array [1..DimF] of integer;


Procedure LeerAtencion (Var At:Atencion);
begin
    Writeln('Ingrese Mes De Atencion (Entre 1 y 12): '); Readln(At.Mes);
    if(At.Mes <> 0) then
    begin
        Writeln('Ingrese DNI Del Paciente: '); Readln(At.DNI);
        Writeln('Ingrese Codigo De Diagnostico (Entre 1 y 15): '); Readln(At.Codigo);
    end;
end;


Procedure InsertarElemento (var A: Arbol; At:Atencion);
begin
    If(a = Nil) then
    begin
        new(a);
        a^.dato.DNI := At.DNI;
        A^.dato.CantTotal:= 1;
        a^.HI:= Nil;
        A^.HD:= Nil;
    end
    else
        if (a^.dato.DNI = At.DNI) then
            a^.dato.CantTotal:= a^.Dato.CantTotal + 1
        else 
            if(a^.dato.Dni < At.Dni)then
                InsertarElemento (A^.HD,At)
            else
                InsertarElemento (a^.HI,At);
end;


Procedure InicializarVector (var Vec: vector; var DimL:integer);
var
    i: integer;
begin
    DimL:= 15;
    for i:= 1 to 15 do
    begin
        vec[i]:= 0;
    end
end;


Procedure CargarArbolYvector (var a:arbol; Var vec:vector);
var
    At: Atencion;
begin
    A:= Nil;
    Writeln('-----------COMIENZA LA CARGA DEL ARBOL-------------');
    LeerAtencion(At);
    While (At.Mes <> 0) do
    begin
        Vec[At.Codigo]:= Vec[At.Codigo] + 1;
        InsertarElemento(A,At);
        LeerAtencion(At);
    end;
end;


Function EntreDosDNI (A:Arbol; Cod1:integer; Cod2:integer; X:integer):Integer;
begin
    If(a= nil) then
        EntreDosDNI:= 0
    else
        if(a^.dato.Dni > Cod1) and (a^.dato.DNI < cod2) then
        begin
            if (a^.dato.CantTotal > X) then
                EntreDosDNI:= 1 + EntreDosDNI (A^.HD,Cod1,Cod2,X) + EntreDosDNI (A^.HI,Cod1,Cod2,X)
            else
                EntreDosDNI:= EntreDosDNI (A^.HD,Cod1,Cod2,X) + EntreDosDNI (A^.HI,Cod1,Cod2,X);
        End
        else
            if(a^.dato.DNI <= COD1) then
                EntreDosDNI:= EntreDosDNI (A^.HD,Cod1,Cod2,X)
            else
                EntreDosDNI:= EntreDosDNI (A^.HI,Cod1,Cod2,X);
end;


Procedure IngreseDNISYX (A:Arbol);
Var 
    DNI1,DNI2,X:integer;
begin
    Writeln('Ingrese DNI Parte Baja Del Rango: ');readln(DNI1);
    Writeln('Ingrese DNI Parte Alta Del Rango: ');readln(DNI2);
    Writeln('Ingrese Mas De Cuantas Atenciones Debe Tener Cada Paciente: '); Readln(X);
    Writeln('La Cantidad De Personas Que Estan Dentro Del Rango Y Tienen Mas de ', x, ' Atenciones Es: ', EntreDosDNI(A,DNI1,DNI2,X));
end;


Function Cantidad0 (Vec: vector; DimL:integer): integer;
begin
    if (dimL < 0) then
        Cantidad0:= 0
    else
        if(vec[DimL] = 0) then
            Cantidad0:= 1 + Cantidad0(vec, (DimL-1))
        else
            Cantidad0:= Cantidad0(Vec, (dimL-1));
    
end;


// PROGRAMA PRINCIPAL
var
    A:arbol; vec: vector; DimL:integer;
begin
    InicializarVector(vec,DimL);
    CargarArbolYvector(a,vec);
    If(a <> nil) then
        IngreseDNISYX(A)
    else
        Writeln('-----------ARBOL VACIO-----------');
    Writeln('La Cantidad Diagnosticos Con 0 Atenciones es de :', Cantidad0(Vec,DimL));

end.