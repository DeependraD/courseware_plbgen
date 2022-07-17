#!/bin/sh

set -ev

echo "Installing latex packages stolen from yuhui's collection and project specific custom"
tlmgr install atbegshi atveryend auxhook bigintcalc bitset catoptions charter eepic etexcmds extsizes filehook fontaxes gettitlestring grfext grffile hycolor infwarerr intcalc kvdefinekeys kvoptions kvsetkeys l3backend letltxmacro lettrine libertine lm-math ltxcmds ltxkeys ly1 makecell makecmds mathalpha mdframed modes mweights ncntrsbk needspace pdfescape pdflscape pdftexcmds polyglossia refcount rerunfilecheck roboto srcltx standalone stringenc sttools threeparttablex translator unicode-math uniquecounter units wallpaper xwatermark


echo "Running bookdown::pdf_book generation script"
# Rscript -e "bookdown::render_book('index.Rmd', output_format = 'bookdown::gitbook', new_session = FALSE, config_file = '_bookdown.yml', output_dir = '_book/')"
Rscript -e "bookdown::render_book('index.Rmd', output_format = 'bookdown::pdf_book', new_session = FALSE, config_file = '_bookdown.yml', output_dir = '_book/')"
# Rscript -e "bookdown::render_book('index.Rmd', output_format = 'bookdown::epub_book', new_session = FALSE, config_file = '_bookdown.yml', output_dir = '_book/')"
