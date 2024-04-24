module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Lamdera exposing (ClientId, SessionId)
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    , count : Int
    }


type alias BackendModel =
    { count : Int }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | Plus1
    | Minus1


type ToBackend
    = NoOpToBackend
    | Plus1ToBackend
    | Minus1ToBackend


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected SessionId ClientId


type ToFrontend
    = NoOpToFrontend
    | ClientConnectedToFrontend Int
