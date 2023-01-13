module Pages.Home_ exposing (Model, Msg, page)

import Gen.Params.Home_ exposing (Params)
import Gen.Route exposing (Route)
import Html
import Html.Attributes as Attr
import Page
import Request
import Shared
import UI exposing (Html)
import UI.Layout
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page =
    UI.Layout.pageFullWidth
        { view = view
        }


type alias Model =
    UI.Layout.Model


type alias Msg =
    UI.Layout.Msg


view : View Msg
view =
    { title = "Tycho brouwer"
    , body =
        [ Html.div [ Attr.class "row center-x" ]
            [ UI.hero
                { title = "Tycho Brouwer"
                , description = "A site for showcasing my projects"
                , subdescription = "current, never finished, and finished"
                }
            ]
        , alternatingMarkdownSections
            [ ( "laptop"
              , """
## Build reliable applications with Elm
With __elm-spa__, you can create production-ready applications with one command:
```terminal
npx elm-spa new
```
No need to configure webpack, gulp, or any other NPM dev tools. This __zero-configuration__ CLI comes with a live-reloading dev server, production-ready build commands, and even a few scaffolding commands for new and existing applications.
"""
              , [ 
                ]
              )

            --             , ( "magic"
            --               , """
            -- ## Automatic routing
            -- With __elm-spa__, routing is automatically generated for you based on a standard file-structure convention. This means you'll be able to navigate any project, making it great for onboarding new hires or collaborating with a team!
            -- """
            --               , [ ( "Learn how routing works", Gen.Route.Projects__Section_ { section = "02-routing" } )
            --                 ]
            --               )
            --             , ( "lock"
            --               , """
            -- ## User authentication
            -- The latest release comes with a simple way to setup user authentication. Use the `Page.protected` API to easily guarantee only logged-in users can view certain pages.
            -- """
            --               , [ ( "See it in action", Gen.Route.Examples__Section_ { section = "04-authentication" } )
            --                 ]
            --               )
            --             , ( "brain"
            --               , """
            -- ## Ready to learn more?
            -- Awesome! Check out the official guide to learn the concepts, or start by looking at a collection of examples.
            --         """
            --               , [ ( "Read the guide", Gen.Route.Projects )
            --                 , ( "View examples", Gen.Route.Examples )
            --                 ]
            --               )
            ]
        ]
    }


alternatingMarkdownSections : List ( String, String, List ( String, Route ) ) -> Html msg
alternatingMarkdownSections sections =
    let
        viewSection i ( emoji, str, buttons ) =
            Html.section [ Attr.class "home__section" ]
                [ Html.div [ Attr.class "home__section-row container relative row", Attr.classList [ ( "align-right", modBy 2 i == 1 ) ] ]
                    [ Html.img [ Attr.class "home__section-icon", Attr.src ("/images/icons/" ++ emoji ++ ".svg"), Attr.alt emoji ] []
                    , Html.div [ Attr.class "col gap-lg" ]
                        [ UI.markdown { withHeaderLinks = False } str
                        , Html.div [ Attr.class "row gap-md" ]
                            (List.map
                                (\( label, route ) -> Html.a [ Attr.class "button", Attr.href (Gen.Route.toHref route) ] [ Html.text label ])
                                buttons
                            )
                        ]
                    ]
                ]
    in
    Html.main_ [ Attr.class "col" ]
        (List.indexedMap viewSection sections)
