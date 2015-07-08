{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE DeriveFunctor      #-}
{-# LANGUAGE DeriveGeneric      #-}


module BTree.Types
    ( Record
    , OpF(..)
    , Op
    , BRecord
    , Node(..)
    , BTree(..)
    ) where


import           Control.Monad.Trans.Free
import           Data.Data
import           GHC.Generics


-- Eq k
-- Ord k
-- Serialize k
-- Serialize v
type Record k v = (k, v)

data OpF k v a
        = Insert k v a
        | Delete k a
        | Find k (v -> a)
        | Next v (v -> a)
        | Commit
        | Rollback
        deriving (Functor, Typeable, Generic)

type Op k v m = FreeT (OpF k v) m

type BRecord k v = Either (Record k v) (BTree k v)
data Node k v    = Node k (BRecord k v)
data BTree k v   = BTree [Node k v] (BRecord k v)
