-- perceptron simulation code 
-- git@github.com:TomohiroKida/perceptron.git
-- created by Tomohiro KIDA 2018/05/08/Tue 

module Main 
    ( main
    , linearFunc
    , linearFunc'
    , lossFunc
    , gradientDescent 
    , plotDataPng
    , simPerceptron
    ) where

import Graphics.Gnuplot.Simple
import System.Random           
import Numeric.LinearAlgebra  

xxs :: [[Double]]
xxs = [[1,4,6],[1,1,4],[1,3,2],[1,7,3]]
ts :: [Int]
ts = [-1,-1,1,1]
a :: (Fractional frac) => frac
a  = 0.1

-- f (x) = w (tr x)
linearFunc :: Matrix R -> Matrix R -> Double
linearFunc w x 
    | fst (size w) == 1 && fst (size x) == 1 = head . head . toLists $ w <> (tr x)
    | otherwise                              = -1 -- error

-- linear function for plot 
-- the left hand side is x2
linearFunc' :: Matrix R -> Double -> Double
linearFunc' ws x = 
    let w = (toLists ws)!!0
    in (-x)*(w!!1)/(w!!2) - ((w!!0)/(w!!2))

lossFunc :: Double -> Double -> Double
lossFunc t f = max 0.0 (-t*f)


-- return one itaration of gradientDescent
gradientDescent :: Int -> Matrix R -> Matrix R
gradientDescent rn ws =
    let ti      = realToFrac $ ts !! rn
        xi      = fromLists [xxs!!rn] :: Matrix R
        li      = lossFunc ti $ linearFunc ws xi
        wsn     = if li > 0 then ws - ( a*(realToFrac (-ti))*xi ) else ws
    in wsn

-- plot data and png
plotDataPng :: Matrix R -> IO ()
plotDataPng ws = do 
    plotPathsStyle atribute plotstyle
    where 
        lines     = map (\x->(x,(linearFunc' ws x))) [0..10]
        points_t  = map ((\[x,y]->(x,y)).tail) $ (\xs->[(xs!!0),(xs!!1)]) xxs
        points_f  = map ((\[x,y]->(x,y)).tail) $ (\xs->[(xs!!2),(xs!!3)]) xxs
        label     = [(XLabel "x"), (YLabel "y")]
        range     = [(XRange (0,8)), (YRange (0,8))]
        size      = [Aspect (Ratio 0.7)]
        title     = [(Title "simPerceptron")]
        png       = [(PNG   "simPerceptron.png")]
        atribute  = (label++range++title++png)
        plotstyle = [(defaultStyle {plotType = Points }, points_t),
                     (defaultStyle {plotType = Points }, points_f),
                     (defaultStyle {plotType = Lines  }, lines )]


-- simulation perceptron by grandient descent 
simPerceptron :: StdGen -> Matrix R -> Int -> IO () 
simPerceptron gen ws count = do
    let (rn,ng) = randomR (0,3) gen :: (Int, StdGen) -- get one rand data of 4
    let wsn = gradientDescent rn ws -- update ws
    putStrLn $ show count ++ show wsn
    if (count > 0) 
        then simPerceptron ng wsn (count-1) -- return recursion
        else plotDataPng wsn -- plot

main :: IO ()
main = do
    gen <- getStdGen
    let ws = (1><3) [-1,2,3] :: Matrix R
    simPerceptron gen ws 100 -- gradientDescent simulation
