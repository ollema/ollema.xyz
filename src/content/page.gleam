import content/post.{type Post}
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn homepage(posts: List(Post)) {
  page(
    [
      html.p([], [
        html.text(
          "This is a dead simple demo repo to show you how to get started ",
        ),
        html.em([], [html.text("today")]),
        html.text(" with "),
        html.a([attribute.href("https://hexdocs.pm/lustre/lustre.html")], [
          html.code([], [html.text("lustre")]),
        ]),
        html.text(" and "),
        html.a([attribute.href("https://hexdocs.pm/lustre_ssg/index.html")], [
          html.code([], [html.text("lustre_ssg")]),
        ]),
        html.text("."),
      ]),
      html.p([], [
        html.text("This template uses the markup syntax "),
        html.a([attribute.href("https://djot.net/")], [
          html.code([], [html.text("djot")]),
        ]),
        html.text(" which is parsed with "),
        html.a(
          [attribute.href("https://hexdocs.pm/lustre_ssg/lustre/ssg/djot.html")],
          [html.code([], [html.text("lustre_ssg/djot")])],
        ),
        html.text(" which is in turn powered by "),
        html.a([attribute.href("https://hexdocs.pm/jot/")], [
          html.code([], [html.text("jot")]),
        ]),
        html.text(" to render content."),
      ]),
      html.p([], [
        html.text("We use "),
        html.a([attribute.href("https://picocss.com/")], [html.text("PicoCSS")]),
        html.text(" as a sensible drop-in CSS framework."),
      ]),
      html.p([], [
        html.text(
          "The page you are viewing right now is constructed with lustre elements, but the following pages are dynamically built from djot syntax:",
        ),
      ]),
      post.to_preview_list(posts),
    ],
    "Home",
    "lustre_ssg_starter homepage.",
  )
}

pub fn from_post(post: Post) {
  page(
    list.concat([
      [html.a([attribute.href("/")], [html.h5([], [html.text("← go back")])])],
      post.content,
    ]),
    post.metadata.title,
    post.metadata.description,
  )
}

fn page(content: List(Element(Nil)), title: String, description: String) {
  html.html([attribute.attribute("lang", "en")], [
    head(title, description),
    body(content),
  ])
}

fn head(title: String, description: String) {
  html.head([], [
    html.title([], title),
    html.meta([attribute.attribute("charset", "utf-8")]),
    html.meta([
      attribute.attribute("name", "viewport"),
      attribute.attribute("content", "width=device-width, initial-scale=1"),
    ]),
    html.meta([
      attribute.name("description"),
      attribute.attribute("content", description),
    ]),
    html.link([attribute.href("/reset.css"), attribute.rel("stylesheet")]),
    html.link([attribute.href("/style.css"), attribute.rel("stylesheet")]),
  ])
}

fn body(content: List(Element(Nil))) {
  html.body([], [
    html.header([], [
      html.nav([], [
        html.ul([], [
          html.li([], [
            html.a([attribute.href("/")], [html.text("Olle Månsson")]),
          ]),
        ]),
      ]),
    ]),
    html.main([], content),
  ])
}
