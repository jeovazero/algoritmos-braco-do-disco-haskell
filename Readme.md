###### Autor: Jeova

### Algoritmos de Escalonamento do Braço do Disco em Haskell

#### Requisitos para linux

- haskell-platform

#### Como instalar no debian e derivados

``` sudo apt-get install haskell-platform```

### Formas de executar

1. #### Interpretado

   ``` runhaskell algoritmos_braco.hs < arquivo_de_entrada```

2. #### Compilado

   - Compilando

     ```ghc algoritmos_braco.hs -o nome_do_executavel```

   - Executando

     ```./nome_do_executavel < arquivo_de_entrada```

##### Formato arquivo de entrada

A entrada é composta por uma série de números inteiros, um por linha:
O primeiro inteiro é o número do último cilindro no disco (os cilindros variam de 0 até este número); o segundo inteiro é número do cilindro sobre o qual a cabeça de leitura está inicialmente posicionada; os outros inteiros em seguida, representam uma sequência de requisições de acesso.
