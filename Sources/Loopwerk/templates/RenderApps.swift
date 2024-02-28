import Saga
import HTML

func renderApps(context: ItemsRenderingContext<AppMetadata>) -> Node {
  baseLayout(section: .apps, title: "Apps") {
    article {
      div(class: "page_content") {
        p {
          "我开发过的Web和iOS应用程序。最新的应用程序首先显示。"
        }

        context.items.map { app in
          div(class: "app") {
            h2 { app.title }

            div(class: "screenshots\(app.metadata.roundOffImages ?? true ? " rounded" : "") break_\(app.metadata.breakImages ?? (app.metadata.images.count % 2 == 0 ? 2 : app.metadata.images.count))") {
              app.metadata.images.map { src in
                %span { %img(src: "/apps/images/\(src)" )}
              }
            }

            Node.raw(app.body)

            if let url = app.metadata.url {
              a(href: url, rel: "nofollow", target: "_blank") {
                if url.contains(".apple.com") {
                  img(src: "/static/images/apple.svg")
                } else {
                  "Website"
                }
              }
            }
          }
        }
      }
    }
  }
}
