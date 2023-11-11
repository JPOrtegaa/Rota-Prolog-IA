# Rota de menor preço Prolog
**1° Projeto da disciplina de Inteligência Artificial, UNIOESTE.**

Busca de trajeto de viagem, dada uma cidade inicial até determinada final, com menor preço.

**Discentes:** João Pedro Ortega, Enzo Bonfante.

**Doscentes:** Huei Diana Lee, Newton Spolaôr.

## Funcionamento
1. **Abra o terminal e mude o diretório onde o projeto foi instalado**
- cd path\to\project

2. **Inicie o interpretador SWI-Prolog**
- swipl

3. **Consulte o programa Prolog para o interpretador**
- consult('nomePrograma.pl').

4. **Leitura do arquivo de rotas (base de dados)**
- ler_arquivo('nomeArquivo.txt').

5. **Busca de menor caminho**
- menor_caminho(CidadeInicial,CidadeFinal).

6. **Resultado neste formato**
    Trajeto

    [cidadeInicial,cidade2,...,cidadeFinal]

    Preco: R$ X

    true.