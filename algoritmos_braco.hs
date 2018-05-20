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

calc_diferencas :: Int -> [Int] -> [Int]
calc_diferencas _ [] = []
calc_diferencas atual (proximo:outros) =
    abs(proximo - atual):(calc_diferencas proximo outros)


-- -------------------------------------------------
-- First Come, First Serve
-- -------------------------------------------------
fcfs :: Int -> [Int] -> Int
fcfs _ [] = 0
fcfs inicio requisicoes = sum diferencas_fcfs
    where diferencas_fcfs = calc_diferencas inicio requisicoes

-- -------------------------------------------------
-- Shortest Seek-Time First
-- -------------------------------------------------

-- Calcula a proxima requisicao apartir da posicao da cabeca
-- as requisicoes tem que estar ordenadas
calc_prox_sstf :: Int -> Int -> Int -> [Int] -> [Int] -> (Int, [Int])
calc_prox_sstf _ atual _ [] requisicoes_faltantes = (atual, requisicoes_faltantes)
calc_prox_sstf cabeca atual dif_atual requisicoes requisicoes_faltantes
  | dif_prox > dif_atual = (atual, requisicoes_faltantes ++ requisicoes)
  | otherwise = calc_prox_sstf cabeca prox dif_prox prox_requisicoes (requisicoes_faltantes ++ [atual])
     where  (prox:prox_requisicoes) = requisicoes
            dif_prox = abs(cabeca - prox)

-- Calcula a lista de requisicoes do SSFT
-- A lista de requisicoes tem que estar ordenada
calc_requisicoes_sstf :: Int -> [Int] -> [Int]
calc_requisicoes_sstf _ [] = []
calc_requisicoes_sstf cabeca requisicoes = prox : (calc_requisicoes_sstf prox req')
    where   (prox, req') = calc_prox_sstf cabeca atual dif_atual req []
            (atual:req) = requisicoes
            dif_atual = abs(cabeca - atual)

-- SSTF
sstf :: Int -> [Int] -> Int
sstf _ [] = 0
sstf inicio requisicoes = sum diferencas_sstf
    where   diferencas_sstf = calc_diferencas inicio req
            req = calc_requisicoes_sstf inicio (qsort requisicoes)
-- ======================================================================

-- -----------------------------------------------------------------------
-- ELEVADOR
-- -----------------------------------------------------------------------
elevador :: Int -> [Int] -> Int
elevador _ [] = 0
elevador inicio requisicoes = sum diferencas_elevador
    where   requisicoes_sort = qsort requisicoes
            maiores = filter (>= inicio) requisicoes_sort
            menores = filter (< inicio) requisicoes_sort
            requisicoes_elevador = maiores ++ (reverse menores)
            diferencas_elevador = calc_diferencas inicio requisicoes_elevador
-- =======================================================================

-- --------------
-- MAIN
-- --------------
main = do
    lista_entrada <- ler_entrada
    let (total:inicio:requisicoes) = lista_entrada
    putStrLn $ "FCFS " ++ show (fcfs inicio requisicoes)
    putStrLn $ "SSTF " ++ show (sstf inicio requisicoes)
    putStrLn $ "ELEVADOR " ++ show (elevador inicio requisicoes)
