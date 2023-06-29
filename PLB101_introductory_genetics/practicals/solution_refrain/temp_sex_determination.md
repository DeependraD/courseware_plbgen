## Solution 4

The combination XXY of sex chromosome results in klinefelter syndrome. We treat the question differently for different births. The details are presented diagrammatically below:

\underline{1st birth}

- Parents obtained normal vision klinefelter
- Following possibilities remain during fertilization.

Case of 1st birth showing parental combinations producing klinefelter offspring.

\begin{figure*}[t!]
    \centering
    \begin{subfigure}[t]{0.5\textwidth}
        \centering
```{r first-birthi, out.width="50%"}
# mer_first_birthi <- DiagrammeR::mermaid(
#   "
#   graph TB
#
#   x11[X<sup>E</sup>X<sup>e</sup><br>Female] --> x21(Non disjunction of<br> sister chromatids<br> during meiosis I)
#   x12[X<sup>e</sup>Y<br>Male] --> x21
#   x21 --> x31[X<sup>E</sup>X<sup>e</sup>Y<br>Normal vision klinefelter]
#
#   "
# )
#
# htmltools::html_print(mer_first_birthi) %>%
#   webshot2::webshot("../images/mer_first_birthi.png", vwidth = 260, vheight = 540, zoom = 2)

knitr::include_graphics("../images/mer_first_birthi.png")
```
        \caption{Case I (Non-disjunction)}
    \end{subfigure}%
    ~
    \begin{subfigure}[t]{0.5\textwidth}
        \centering
```{r first-birthii, out.width="50%"}
# mer_first_birthii <- DiagrammeR::mermaid(
#   "
#   graph TB
#
#   subgraph Female
#   x11((X<sup>E</sup>)) --> x21((X<sup>E</sup>X<sup>e</sup><br>Fusion of<br> egg gametes))
#   x12((X<sup>e</sup>)) --> x21
#   end
#
#   subgraph Male
#   x13[X<sup>e</sup>Y<br>Male]
#   end
#
#   x13 --> x31((X<sup>E</sup>X<sup>e</sup>Y))
#   x21 --> x31
#   "
# )
#
# htmltools::html_print(mer_first_birthii) %>%
#   webshot2::webshot("../images/mer_first_birthii.png", vwidth = 450, vheight = 540, zoom = 2)

knitr::include_graphics("../images/mer_first_birthii.png")
```
        \caption{Case II (Double fusion of egg gametes)}
    \end{subfigure}
    \caption{Cases for klinefelter development for 1st birth.}
\end{figure*}


\underline{2nd birth}

- Parent obtained colorblind daughter
- Following event occured during fertilization

```{r second-birth, fig.align='center', out.width="20%", fig.cap="Case of 2nd birth showing parental combinations producing colorblind offspring", fig.pos="H"}

# second_birth_mer <- DiagrammeR::mermaid(
#   "
#   graph TB
#
#   x11[X<sup>E</sup>X<sup>e</sup><br>Female] --> x21((Hybridization))
#   x12[X<sup>e</sup>Y<br>Male] --> x21
#   x21 --> x31[X<sup>E</sup>X<sup>e</sup><br>Color blind female]
#
#   "
# )
#
# htmltools::html_print(second_birth_mer) %>%
#   webshot2::webshot("../images/second_birth_mer.png", vwidth = 250, vheight = 450, zoom = 2)

knitr::include_graphics("../images/second_birth_mer.png")
```
