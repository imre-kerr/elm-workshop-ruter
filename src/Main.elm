module Main exposing (..)

import Html
import Time exposing (every, second)
import State exposing (..)
import Types exposing (..)
import Views exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = ( initModel, getAllStopsInOslo )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


initModel : Model
initModel =
    { nameFilter = ""
    , stops = []
    , chosenStop = Nothing
    , departures = []
    , now = Nothing
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    every second Tick
