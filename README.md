# tex-image-creator

This repository provides an opinionated script to build `tikz` images.

## Usage

- **`make.sh`**: Run this script to build all images. It processes the source files in `src/` and generates output files in the appropriate directories (`pdf/` and `svg/`).
- **`clean.sh`**: Run this script to remove all generated files, cleaning up the workspace.

## Requirements

The script calls out to `pdflatex` to create a PDF file from your `tex`. It then calls out to `inkscape` to create an SVG from the PDF.

I'm uncertain which versions work -- these are mine, and are confirmed working:

```shell
pdflatex --version
# pdfTeX 3.141592653-2.6-1.40.27 (TeX Live 2026/dev/Arch Linux)
inkscape --version
# Inkscape 1.4.2 (ebf0e940d0, 2025-05-08)
```

## Source File Format

All LaTeX source files are located in the `src/` directory.
The filename of the `tex` file is used to generate the output file, e.g. `my-image.tex` becomes `my-image.svg` and `my-image.pdf`.
Each `tex` file should follow approximately this format:

```tex
% Any comments for yourself; I like the following:

%
%  Name: A descriptive name of your image
%  For: What I made it for
%  Created: YYYY-MM-DD
%
\documentclass{standalone}
\input{setup.tex}
\begin{document}
\begin{tikzpicture}
%% Your tikz code here %%
\end{tikzpicture}
\end{document}
```


## Contributing

This is mostly for myself, but if you would like to contribute anyway:

1. **Create an issue**. Don't just immediately start work and PR -- it would be a shame if I don't intend to merge your work.
2. **Make a PR**. Once I acknowledged the thing you want to contribute, go ahead and make a PR!

This process helps keep the project focused and maintainable.

## License

This project is MIT licensed; see `LICENSE.md` for the actual content.