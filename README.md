
# CV LaTeX template

This LaTeX template creates a full job application plus attached CV when provided
complete input .tex files (for personal and recipient data).
It uses `pdflatex` and targets the **german recipients only**!

## Usage

To customize the PDF to your needs, you have to provide two files:
* `my_data.tex` -- contains your data and CV information
* `recipient_file.tex` -- contains contact informarmation of the recipient

You can use these `data_example/*.tex` files for a test run, to produce a dummy
PDF and as guidance to adapt the input .tex files to your real data.

To pass these file to `pdflatex` you have to define them as environment variables.

`export CV=data_example/my_data.tex RECP=data_example/recp_file.tex`

Then you can start the PDF creation with

`make clean && make`

You can use [nix-shell](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html)
to replicate the required dependencies (see `shell.nix`).

## Customization

You can provice any number of images of scanned documents to attach in the `data folder`
like `data_example/*.{png,jpg}`. Please mind a propper format and ratio.  
Once all required and wanted images are present you can refer to them in your
`my_data.tex` file in a relative fashion.

```tex
\subsubsection{School Certificate}
\PageFillImage{cert_example.png} % page 1
% page 2 ...
```
