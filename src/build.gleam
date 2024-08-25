import content/page
import content/post.{type Post}
import gleam/dict
import gleam/list
import lustre/ssg
import simplifile

const out_dir = "./dist"

const static_dir = "./static"

const posts_dir = "./content"

pub fn main() {
  let posts = read_posts()
  let id_to_post =
    list.map(posts, fn(post) { #(post.metadata.id, post) })
    |> dict.from_list

  ssg.new(out_dir)
  |> ssg.add_static_route("/", page.homepage(posts))
  |> ssg.add_dynamic_route("/posts", id_to_post, page.from_post)
  |> ssg.add_static_dir(static_dir)
  |> ssg.use_index_routes
  |> ssg.build
}

fn read_posts() -> List(Post) {
  let assert Ok(paths) = simplifile.read_directory(posts_dir)
  use file <- list.map(paths)
  post.parse(from: posts_dir <> "/" <> file)
}
