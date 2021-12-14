import qualified Data.Text as T

split :: String -> String -> [String]
split sep str = filter (\s -> length s > 0) $ map T.unpack $ T.splitOn (T.pack sep) (T.pack str)

strToBoard :: String -> [[Integer]]
strToBoard b = map (map read . split " ") $ split "\n" b

strToSeq :: String -> [Integer]
strToSeq = map read . split ","

transpose :: [[a]] -> [[a]]
transpose [] = []
transpose [m] = map return m
transpose (m:ms) = zipWith (:) m (transpose ms)

done :: [Integer] -> [[Integer]] -> Bool
done s m = doneh s m || doneh s (transpose m)
  where
    doneh seq = any $ all $ flip elem seq

score :: [Integer] -> [[Integer]] -> Integer
score seq = (head seq *) . sum . filter (not . flip elem seq) . concat

task1 :: [Integer] -> [[[Integer]]] -> Integer
task1 nums boards = t1 [] nums
  where
    t1 :: [Integer] -> [Integer] -> Integer
    t1 p f = case filter (done p) boards of {
      [] -> t1 (head f : p) (tail f);
      (b:_) -> score p b
    }

task2 :: [Integer] -> [[[Integer]]] -> Integer
task2 nums boards = t2 [] nums boards
  where
    t2 :: [Integer] -> [Integer] -> [[[Integer]]] -> Integer
    t2 _ _ [] = undefined
    t2 p f [board] 
      | done p board = score p board
      | otherwise = t2 (head f : p) (tail f) [board]
    t2 p f boards = 
      let p' = (head f : p) in
      let f' = tail f in
      t2 p' f' $ filter (not . done p) boards

main = do
  s <- readFile "in.txt"
  let c = split "\n\n" s
  let seq = strToSeq $ head c
  let boards = map strToBoard $ tail c
  let t1 = task1 seq boards
  let t2 = task2 seq boards
  putStrLn $ "Task 1: " ++ show t1
  putStrLn $ "Task 2: " ++ show t2
