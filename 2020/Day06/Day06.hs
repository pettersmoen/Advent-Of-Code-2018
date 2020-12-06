module Main where

import Text.Parsec
  ( alphaNum,
    letter,
    char,
    choice,
    count,
    digit,
    many1,
    skipMany1,
    parse,
    string,
    try,
    sepBy,
    endBy,
    ParseError,
    (<|>)
  )
import Text.Parsec.Char (newline)
import Data.Either (fromRight)
import Data.List (nub)

parser :: String -> [[String]]
parser = fromRight (error "bad") . parse fileParser "file parser" 
    where
        fileParser = groupParser `sepBy` newline
        groupParser = lineParser `endBy` newline
        lineParser = many1 letter

part1 :: [[String]] -> Int
part1 groups = sum $ fmap (length . nub . joinGroup) groups 
    where 
        joinGroup = foldl (++) []

main :: IO ()
main = do
    file <- readFile "input.txt"
    let groups = parser file
    print $ part1 groups
