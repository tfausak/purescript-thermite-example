module Main where

import Prelude

import qualified Control.Monad.Eff as Eff
import qualified Control.Monad.Eff.Console as Console
import qualified Data.Maybe as Maybe
import qualified Data.Nullable as Nullable
import qualified DOM as DOM
import qualified DOM.HTML as DOM
import qualified DOM.HTML.Document as DOM
import qualified DOM.HTML.Types as DOM
import qualified DOM.HTML.Window as DOM
import qualified DOM.Node.NonElementParentNode as DOM
import qualified DOM.Node.Types as DOM
import qualified React as React
import qualified React.DOM as React
import qualified Thermite as Thermite
import qualified Thermite.Action as Thermite

main :: forall e. Eff.Eff (console :: Console.CONSOLE, dom :: DOM.DOM | e) Unit
main = do
  let containerId = "container"
  maybeContainer <- getElementById containerId
  case maybeContainer of
    Maybe.Nothing -> do
      Console.error ("Could not find container element #" ++ containerId)
    Maybe.Just container -> do
      void (React.render component container)

getElementById :: forall e. String -> Eff.Eff (dom :: DOM.DOM | e) (Maybe.Maybe DOM.Element)
getElementById elementId = do
  window <- DOM.window
  htmlDocument <- DOM.document window
  let document = DOM.htmlDocumentToDocument htmlDocument
  let node = DOM.documentToNonElementParentNode document
  element <- DOM.getElementById (DOM.ElementId elementId) node
  return (Nullable.toMaybe element)

newtype State = State {}
newtype Props = Props {}
newtype Action = Action Unit

component :: React.ReactElement
component = React.createFactory componentClass (Props {})

componentClass :: React.ReactClass Props
componentClass = Thermite.createClass spec

spec :: Thermite.Spec _ State Props Action -- TODO
spec = Thermite.simpleSpec (State {}) perfAction render

perfAction :: Thermite.PerformAction _ State Props Action -- TODO
perfAction _ _ = Thermite.modifyState id

render :: Thermite.Render _ State Props Action -- TODO
render _ _ _ _ = React.div' [React.text "Hello from PureScript!"]
