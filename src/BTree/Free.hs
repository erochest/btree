module BTree.Free
    ( insert
    , delete
    , find
    , next
    , commit
    , rollback
    ) where


import           Control.Monad.Trans.Free

import           BTree.Types


insert :: Monad m => k -> v -> Op k v m ()
insert k v = liftF (Insert k v ())

delete :: Monad m => k -> Op k v m ()
delete k = liftF (Delete k ())

find :: Monad m => k -> Op k v m v
find k = liftF (Find k id)

next :: Monad m => v -> Op k v m v
next v = liftF (Next v id)

commit :: Monad m => Op k v m ()
commit = liftF Commit

rollback :: Monad m => Op k v m ()
rollback = liftF Rollback
