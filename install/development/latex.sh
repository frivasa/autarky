#!/bin/bash

# install everything, it's about 600 MB (texlive-fontsextra is 2 GB. Avoid at all costs)
sudo pacman -S --noconfirm --needed \
  python-pylatexenc texlive-basic texlive-latex texlive-latexextra \
  texlive-latexrecommended texlive-fontsrecommended texlive-mathscience texlive-xetex

