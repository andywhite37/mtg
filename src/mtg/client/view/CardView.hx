package mtg.client.view;

import doom.html.Html.*;
import mtg.client.api.AppApi;
import mtg.core.model.*;

class CardView extends doom.html.Component<{ api : AppApi, state: Card }> {
  override function render() {
    var card = props.state;
    var imageInfo = card.getDefaultImage();
    return div(["class" => "ui card"], [
      div(["class" => "content"], [
        div(["class" => "right floated meta"], [
          span(card.cost),
        ]),
        div(["class" => "header"], card.name),
      ]),
      div(["class" => "image"], [
        img(["src" => imageInfo.src, "alt" => imageInfo.alt])
      ]),
      div(["class" => "content"], [
        div(["class" => "description"], card.text)
      ])
    ]);
  }
}
