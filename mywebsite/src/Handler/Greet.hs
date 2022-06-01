{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE QuasiQuotes #-}
module Handler.Greet where

import Import
-- import Text.Balze.Html
-- blaze-html needs to be included in dependencies in package.html

-- this part is used to generate HTML
{-
getGreetR :: Text -> Handler Html
getGreetR name = do
  defaultLayout $ do
    setTitle "Mathematics"
    [whamlet| <p>Algebraic Topology #{name}|]
-- [whamlet| <p>Algebraic Topology #{preEscapedToHtml name}|] -- this will use url parameter as html
-- this is dangerous, attackers can insert stuff into your website
-- cross site scripting attack!
-- default is safe
-} 

-- this part instead is about JSON
{-
getGreetR :: Text -> Handler Value
getGreetR name = pure $ object
--["name" .= name]
-- this is actually. the operator .= means this
  [ ("name", toJSON name)
  ]
-}

-- this part is about using both Html and JSON
getGreetR :: Text -> Handler TypedContent
getGreetR name = selectRep $ do
  provideRep $ pure $ object
--["name" .= name]
-- this is actually. the operator .= means this
    [ ("name", toJSON name)
    ]

  provideRep $ defaultLayout $ do
    setTitle "Mathematics"
    [whamlet| <p>Algebraic Topology #{name}|]
