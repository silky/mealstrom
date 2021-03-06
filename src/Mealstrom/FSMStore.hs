{-# LANGUAGE MultiParamTypeClasses #-}

{-|
Module      : Mealstrom.FSMStore
Description : Typeclass for FSMStores
Copyright   : (c) Max Amanshauser, 2016
License     : MIT
Maintainer  : max@lambdalifting.org
-}

module Mealstrom.FSMStore where

import Mealstrom.FSM

data Proxy k s e a = Proxy

-- |Even the Read method needs type parameters 'e' and 'a' because it needs to deserialise the entry from storage.
-- Implementations are expected to not throw exceptions in fsmRead/fsmCreate.
-- Throwing in fsmUpdate is OK.
class FSMStore st k s e a where
    fsmRead   :: st -> k -> Proxy k s e a -> IO (Maybe s)
    fsmCreate :: st -> Instance k s e a -> IO (Maybe String)
    fsmUpdate :: st -> k -> MachineTransformer s e a -> IO MealyStatus
