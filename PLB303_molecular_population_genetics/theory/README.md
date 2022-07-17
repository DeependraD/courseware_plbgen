# Instructions and best practices while editing the slides

- Monash theme is hosted inside binb package
- In order to customize the theme, best way is to tinker with 'template.tex' file. This is usually found in (for example):

```
/home/deependra/R/x86_64-pc-linux-gnu-library/4.0/binb/rmarkdown/templates/monash/resources/template.tex
```

- Just rename the original to something else and place your custom template.tex
- Creating new .sty files inside current working directory seems superfluous (not useful)
- Point to titlepage image using 'titlepage: ' in yaml header