import gleam/list
import gleam/result
import lustre/attribute
import lustre/element/html
import lustre/ssg/djot
import tom

import lustre/element.{type Element}

import simplifile

pub type Post {
  Post(metadata: Metadata, content: List(Element(Nil)))
}

pub type Metadata {
  Metadata(id: String, title: String, description: String)
}

pub fn parse(from filepath: String) -> Post {
  let post = {
    use file <- result.try(
      simplifile.read(filepath) |> result.replace_error(Nil),
    )
    use metadata <- result.try(
      parse_metadata(file) |> result.replace_error(Nil),
    )
    let content = djot.render(file, djot.default_renderer())

    Ok(Post(metadata:, content:))
  }
  case post {
    Ok(post) -> post
    Error(_) -> {
      let error_message = "could not parse content from file: " <> filepath
      panic as error_message
    }
  }
}

fn parse_metadata(file: String) -> Result(Metadata, Nil) {
  use metadata <- result.try(djot.metadata(file) |> result.replace_error(Nil))
  use id <- result.try(
    tom.get_string(metadata, ["id"])
    |> result.replace_error(Nil),
  )
  use title <- result.try(
    tom.get_string(metadata, ["title"])
    |> result.replace_error(Nil),
  )
  use description <- result.try(
    tom.get_string(metadata, ["description"])
    |> result.replace_error(Nil),
  )
  Ok(Metadata(id:, title:, description:))
}

pub fn to_preview_list(posts: List(Post)) {
  html.ul([], list.map(posts, to_preview))
}

fn to_preview(post: Post) -> Element(a) {
  let post_link = "/posts/" <> post.metadata.id <> ".html"
  let title_attributes = [attribute.href(post_link)]
  let title =
    html.a(title_attributes, [html.strong([], [html.text(post.metadata.title)])])
  html.li([], [title])
}
