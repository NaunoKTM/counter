module Backend exposing (..)

import Html
import Lamdera exposing (ClientId, SessionId)
import Types exposing (..)


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : BackendModel -> Sub BackendMsg
subscriptions backendModel =
    Lamdera.onConnect ClientConnected


init : ( BackendModel, Cmd BackendMsg )
init =
    ( { count = 0 }
    , Cmd.none
    )


update : BackendMsg -> BackendModel -> ( BackendModel, Cmd BackendMsg )
update msg backendModel =
    case msg of
        NoOpBackendMsg ->
            ( backendModel, Cmd.none )

        ClientConnected _ clientId ->
            ( backendModel, Lamdera.sendToFrontend clientId (ClientConnectedToFrontend backendModel.count) )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> BackendModel -> ( BackendModel, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg backendModel =
    case msg of
        NoOpToBackend ->
            ( backendModel, Cmd.none )

        Plus1ToBackend ->
            ( { backendModel | count = backendModel.count + 1 }, Lamdera.broadcast (ClientConnectedToFrontend backendModel.count) )

        Minus1ToBackend ->
            ( { backendModel | count = backendModel.count - 1 }, Lamdera.broadcast (ClientConnectedToFrontend backendModel.count) )
