qsort :: (Ord t) => [t] -> [t]
qsort [] = []
qsort (pivo:outros)  = (qsort menores) ++ [pivo] ++ (qsort maior_eq)
    where   menores  = [x | x <- outros, x < pivo]
            maior_eq = [x | x <- outros, x >= pivo]

ler_entrada :: IO [Int]
ler_entrada = do
    entrada <- getContents -- Ler toda a entrada do usuario
    let linhas = lines entrada -- Cria uma lista com as linhas da entrada
    let lista = [ x | p <- linhas, let x = read p :: Int ]
    return lista

-- ------------------------------------------------- |
-- ELEVADOR
-- ------------------------------------------------- |
diferencas_elevador :: Int -> [Int] -> [Int]
diferencas_elevador _ [] = []
diferencas_elevador atual (proximo:outros) =
    abs(proximo - atual):(diferencas_elevador proximo outros)


elevador :: Int -> [Int] -> Int
elevador inicio requisicoes = sum diferencas
    where   requisicoes_sort = qsort requisicoes
            maiores = filter (>= inicio) requisicoes_sort
            menores = filter (< inicio) requisicoes_sort
            requisicoes_elevador = maiores ++ (reverse menores)
            diferencas = diferencas_elevador inicio requisicoes_elevador


main = do
    lista_entrada <- ler_entrada
    print lista_entrada
    let (total:inicio:requisicoes) = lista_entrada
    print (elevador inicio requisicoes)

