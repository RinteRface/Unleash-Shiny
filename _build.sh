#!/bin/sh

Rscript -e "rmarkdown::render('./slides/index.Rmd')"
rm -rf ./website/slides
cp -r ./slides ./website/slides
cd ./website && Rscript -e "rmarkdown::render_site()" && cd -
