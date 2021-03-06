module Exercises exposing (withProgress)

import Html exposing (..)
import Html.Attributes exposing (..)
import Types exposing (..)


{- README
   Denne filen inneholder oppgavene i workshopen.
   Det eneste du skal gjøre i denne filen er å tikke boksene etterhvert
   som du løser oppgavene. Det gjør du ved å endre `[ ]` til `[x]`.
   Dette gjør at progresjonsindikatoren i toppen av appen din viser hvor langt
   du har kommet.
-}


exercises : List String
exercises =
    [ """ [ ] Vis frem innholdet i modellen.
      """
    , """ [ ] Lag en `Cmd` som henter data fra en nettside,
              f.eks. https://httpbin.org/get.
              Send denne kommandoen til Elm, og putt responsen i modellen.
      """
    , """ [ ] Endre kommandoen du lagde til å hente fra
              ../offline_data/stops/stops.json istedet.
      """
    , """ [ ] Lag en record-type for stopp-informasjon.
      """
    , """ [ ] Lag en JSON-parser som parser stopp-informasjon og bruker
              record-typen fra forrige oppgave.
      """
    , """ [ ] Hent inn stopp ved oppstart av applikasjonen, og vis frem informasjon om stoppene.
      """
    , """ [ ] Utvid modelltypen til å holde på et valgt stopp.
              Legg til en knapp på hver stoppested-rad hvor man kan velge
              stoppet.
      """
    ]



-- Du kan ignorere all koden under denne linja, eller se på den og kanskje lære noe :-)


withProgress : (Model -> Html Msg) -> Model -> Html Msg
withProgress viewFunction model =
    div []
        [ exercises
            |> List.map parseExercise
            |> viewProgress
        , viewFunction model
        ]


type alias Exercise =
    { isCompleted : Bool
    , description : String
    }


parseExercise : String -> Exercise
parseExercise string =
    let
        prefix =
            string
                |> String.trim
                |> String.left 4
                |> String.trim

        suffix =
            string
                |> String.trim
                |> String.dropLeft 4
                |> String.trim
    in
        { isCompleted = prefix == "[x]"
        , description = suffix
        }


viewProgress : List Exercise -> Html Msg
viewProgress exercises =
    let
        totalExercises =
            exercises
                |> List.length

        completedExercises =
            exercises
                |> List.filter .isCompleted
                |> List.length

        txt =
            (toString completedExercises)
                ++ "/"
                ++ (toString totalExercises)

        mouseOver =
            txt
                ++ " oppgaver er løst!"
    in
        p [ style [ ( "text-align", "center" ) ] ]
            [ progress
                [ value (toString completedExercises)
                , Html.Attributes.max (toString totalExercises)
                , title mouseOver
                ]
                []
            , span [ style [ ( "margin-left", "1em" ) ] ] [ text txt ]
            ]
