# Genetics practical

## Building

- Build book as bookdown project.
- Package notes:
  - DiagrammeR package usage requires `webshot::is_phantomjs_installed()` == `TRUE`
  - Also mermaid graphics (rendered with DiagrammeR) is best saved manually with "rsvg" and "DiagrammeRsvg" packages
  - Among all, most comfortable way to render a mermaid is by using webshot:
  
```
some_mermaid_diagram %>%
  htmltools::html_print() %>%
  webshot::webshot(file = "some_mermaid_diagram.png")
```


