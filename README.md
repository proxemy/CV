# CV LaTeX template

This LaTeX template creates a full job application and attached CV when provided
2 complete input .tex files for personal and recipient data.
It uses `pdflatex` and targets **german recipients only**!

## Usage

To customize the PDF to your needs, you have to provide these two files:
* `my_data.tex` -- contains your data and CV information
* `recipient_file.tex` -- contains contact informarmation of the recipient

You can use the `data_example/*.tex` files to create a dummy PDF
and as guidance to adjust the input .tex files to your real data.

To pass these files to ´make´/`pdflatex` you have to define the pathes to them
as environment variables `CV` and `RECP`.  
Then you can start the PDF creation. The code below will generate a test PDF and
put it into the locally created ´build´ folder.

´´´bash
export CV=data_example/my_data.tex RECP=data_example/recp_file.tex
make clean && make
´´´

You can use [nix-shell](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html)
to replicate the required dependencies (see `shell.nix` file).

## Customization

Of course you have to define certain information as variables to get a reasonable
result but if you don't have any reasonable value to set, you still have to
define the required variables as empty like ´\def\MyExample{}´.

You can provide any number of images of scanned documents to attach **in the data folder**
like `data_example/*.{png,jpg}`.
Once all required and wanted images are present you can refer to them in your
`my_data.tex` file, in the `\def\CVDocs` section, in a relative fashion.  
Please consider a propper format and aspect ratio because the images will get
stretched to varying spaces left on a single page.

```tex
\subsubsection{Additional Certificate Title}
\PageFillImage{some_cert_page_1.png}
\PageFillImage{some_cert_page_2.png}
% and so on
```

Besides the images you explicitly define the PDF creation also requires fixed
images, ´profile_pic.jpg´ and ´signature.jpg´ to be presend in the `my_data.tex`
folder.

## Licence

I don't really care and picked MIT out of habit.
