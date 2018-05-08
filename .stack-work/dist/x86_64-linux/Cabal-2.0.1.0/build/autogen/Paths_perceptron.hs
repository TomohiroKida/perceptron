{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_perceptron (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/bin"
libdir     = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/lib/x86_64-linux-ghc-8.2.2/perceptron-0.1.0.0-Hb4Ed1AJwZl4YFSpu74GJZ"
dynlibdir  = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/lib/x86_64-linux-ghc-8.2.2"
datadir    = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/share/x86_64-linux-ghc-8.2.2/perceptron-0.1.0.0"
libexecdir = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/libexec/x86_64-linux-ghc-8.2.2/perceptron-0.1.0.0"
sysconfdir = "/home/users/kida/work/programming/haskell/perceptron/.stack-work/install/x86_64-linux/lts-11.6/8.2.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "perceptron_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "perceptron_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "perceptron_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "perceptron_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "perceptron_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "perceptron_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
