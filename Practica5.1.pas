Program Practica5uno;
const
    DimF= 300;
Type
    Oficinas = record
        Codigo: integer;
        DNI: integer;
        Expensa: real;
    end;
    Vector = array [1..DimF] of Oficinas;

procedure LeerOficina (var O: Oficinas);  //Lee Oficinas
begin
    Writeln('Inserte codigo de oficina: ');Readln(O.Codigo);
    if (O.codigo <> 0) then
    begin
        Writeln('Inserte DNI del propietario: '); readln(O.DNI);
        Writeln('Inserte monto a pagar: '); Readln(O.Expensa);
    end;
end;

Procedure CargarVector (var V: Vector; var DimL: integer); //Carga el vector desordenado
    var
        O: Oficinas;
begin
    DimL:= 0;
    LeerOficina(O);
    While (O.Codigo <> 0) do
    begin
        DimL:= DimL + 1;
        V[DimL]:= O;
        LeerOficina(O);
    end;
end;

Procedure ImprimirVector (V:vector; DimL: integer); //Imprime cualquier tipo de vector
var
    i: integer;
begin
    For i:= 1 to DimL do
    Writeln('Codigo de oficina: ',V[i].codigo, ' DNI propietario: ', V[i].DNI, ' Expensa a pagar: ', V[i].Expensa:2:2);
end;

Procedure InsercionVector (var V:Vector; DimL:integer);  // Ordena el vector por insercion
var
    i,j: integer; actual: Oficinas;
begin
    for i := 2 to DimL do
    begin
        actual:= V[i];
        j:= i-1;
        While (j > 0) and (v[j].Codigo > actual.Codigo) do
        begin
            v[j+1]:= v[j];
            j:=j-1
        end;
        v[j+1]:= actual;
    end;
end;

Function BusquedaDicotomica (v:vector; DimL: integer; Valor:integer): integer; // Busuqeda Dicotomica (Partis al a mitad y te moves desde ese punto)
var
    Pri,medio,ult: integer;
begin
    BusquedaDicotomica:= 0;
    pri:= 1;
    Ult:= DimL;
    Medio:= (pri + Ult) div 2;
    While (Pri <= ult) and (valor <> v[medio].Codigo) do
    begin
        if (valor < v[medio].Codigo) then
            ult:= medio - 1
        else
            Pri:= medio + 1;
        medio:= (pri + ult) div 2;
    end;
    if (pri <= ult) and (Valor = v[medio].codigo) then
        BusquedaDicotomica:= medio
end;

Procedure BuscarValor (v: vector; DimL:integer) ; // Llama a leer una valor a buscar y a la funcion de busqueda dicotomica
var 
    valor: integer;
begin
    writeln('Inserte un codigo a buscar: '); Readln(Valor);
    if (BusquedaDicotomica(V,DimL,Valor) > 0) then
        Writeln('DNI del Propietario: ',v[BusquedaDicotomica(V,DimL,Valor)].Dni)
    else
        Writeln ('-----------NO se encontro la oficina buscada------------')

end;

Function MontoTotal (v: vector; DimL: integer): real; // Suma el monto total de todas las expensas de forma recursiva
begin
    if (DimL=0)then
        MontoTotal:= 0
    else
        MontoTotal:= V[DimL].Expensa + MontoTotal(v,DimL-1)
end;


// Arranca el programa principal//

var
    V: vector; DimL: integer;
begin
    CargarVector(V,DimL);
    if (DimL > 0 ) then
    begin
        Writeln('-----------Imprimir Vector Desordenado----------');
        ImprimirVector(V,DimL);
        Writeln('////////////////////////////////////////////////////////');
        InsercionVector(V,DimL);
        Writeln('-----------Imprimir Vector Ordenado--------------');
        ImprimirVector(V,DimL);
        Writeln('////////////////////////////////////////////////////////');
        Writeln('-----------Busqueda De Oficina-------------------');
        BuscarValor(V,DimL);
        Writeln('////////////////////////////////////////////////////////');
        Writeln('-----------Sumamos El Total De Las Expensas------');
        Writeln (MontoTotal(V,DimL):2:2);
    end    
    else
        Writeln('---------- VECTOR VACIO-------------')

end.
