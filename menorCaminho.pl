% Talvez descobrir um comando para resetar a base de dados do prolog ao chamar esta funcao!!!
% ler_arquivo(NomeArquivo): ler um arquivo texto no NomeArquivo passado
% ler_arquivo(+NomeArquivo)
ler_arquivo(NomeArquivo) :-
    retractall(rota(_,_,_)),
    absolute_file_name(NomeArquivo, CaminhoArquivo),
    open(CaminhoArquivo, read, Stream),
    ler_linhas(Stream),
    close(Stream).

% ler_linhas(Stream): conforme Stream (fluxo de dados) passado, afirme as linhas do arquivo como fatos/regras
% ler_linhas(+Stream)
ler_linhas(Stream) :-
    read(Stream, Termo),
    (   Termo \== end_of_file
    ->  assert(Termo),
        ler_linhas(Stream)
    ;   true
    ).

% pertence(X, Lista): checa se elemento X pertence a Lista
% pertence(?X, +Lista)
pertence(X,[X|_]).
pertence(X,[_|Cauda]) :- 
    pertence(X,Cauda).

% caminho(Inicio,Fim,Distancia,Cidades): percorre caminho da cidade Inicio ate Fim, calcula a distancia e o trajeto percorrido
% caminho(+Inicio,+Fim,-Distancia,-Cidades)
caminho(Inicio,Fim,Distancia,Cidades) :-
    caminho1(Inicio,[Fim],0,Distancia,Cidades).

% caminho1(Cid, ListaFim, Dist, DistF, CidadesF): percorre caminho da cidade Cid ate ListaFim, 
%                                                 distancia final armazenada em DistF e
%                                                 lista de cidades em CidadesF
% caminho1(+Cid, +ListaFim, +Dist, -DistF, -CidadesF)
caminho1(Cid,[Cid|Cids],Dist,Dist,[Cid|Cids]).
caminho1(Inicio,[Adj|Cids],Dist,DistF,CidadesF) :-
    rota(Interm,Adj,Dist1),
    \+ pertence(Interm,[Adj|Cids]),
    Dist2 is Dist + Dist1,
    caminho1(Inicio,[Interm,Adj|Cids],Dist2,DistF,CidadesF).

% encontra_caminhos(Inicio,Fim,Trajetos): encontra caminhos entre cidade Inicio e Fim, armazena o resultado em Trajetos
% encontra_caminhos(+Inicio,+Fim,-Trajetos)
encontra_caminhos(Inicio,Fim,Trajetos) :-
    findall([Distancia, Trajeto], caminho(Inicio,Fim,Distancia,Trajeto), Trajetos).

% primeiro_elemento(Lista, Elemento): primeiro elemento de Lista eh Elemento
% primeiro_elemento(+Lista, -Elemento)
primeiro_elemento([[Distancia, Trajeto]|_], [Distancia, Trajeto]).

% print_resultado(Elemento): imprime Elemento resultante do menor caminho
% print_resultado(+Elemento)
print_resultado([Distancia, Trajeto]) :-
    writeln('Trajeto'),
    writeln(Trajeto),
    write('Preco: R$ '),
    writeln(Distancia).

% menor_caminho(Inicio, Fim): realizar o menor_caminho a partir da cidade Inicio ate Fim
% menor_caminho(+Inicio, +Fim)
menor_caminho(Inicio, Fim) :-
    encontra_caminhos(Inicio, Fim, Trajetos),
    sort(0, @<, Trajetos, Ordenado),
    primeiro_elemento(Ordenado, [Distancia, Trajeto]),
    print_resultado([Distancia, Trajeto]).