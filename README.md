# CV LaTeX template

This LaTeX template uses `pdflatex` to creates a full job application letter and
attached CV when provided 2 input `.tex` files, containing personal and
recipient information.  
**Meant for german recipients**.

## Usage

You can use [`nix-shell`](https://nixos.org/manual/nix/stable/command-ref/nix-shell.html)
to load all dependencies.

To customize the PDF to your needs, you have to provide these files:
* `my_data.tex` -- contains your personal and CV information
* `recipient_file.tex` -- contains contact information of the recipient

You can use the `data_example/*` files to create a test PDF
and as guidance to create your on input files.
The easiest way to build an example PDF is:
```bash
nix-shell
make example
```

To pass these files to `make`/`pdflatex` you have to define the paths to them
as environment variables `CV` and `RECP`.  
Then you can start the PDF creation. The code below will generate a test PDF and
put it into the locally created `build` folder.

```bash
export CV=my_data.tex RECP=recp_file.tex
make
```

## Customization

In order to get a finished result, you have to define all requested variables in
mentioned `.tex` files above. If you don't have values or don't want to set them,
you still have to define them but you can leave them empty like `\def\MyExample{}`.

You can provide any number of images of scanned documents to attach **in the data folder**
like `data_example/*.{png,jpg}`.
Once all required and wanted images are present you can refer to them in your
`my_data.tex` file, in the `\def\CVDocs` section, via a relative path.  
Please consider a proper format and aspect ratio because the images will get
stretched in varying extends to fit a page.

```tex
\subsubsection{Additional Certificate Title}
\PageFillImage{some_cert_page_1.png}
\PageFillImage{some_cert_page_2.png}
% and so on
```

Besides the images you explicitly define the PDF creation also requires fixed
images, `profile_pic.jpg` and `signature.jpg` to be present in the `my_data.tex`
folder.

## Workings

To create a letter before a CV with a table of content, these two parts get created
separately and merged together afterwards. You can inspect these intermediates
in the `builds/tmp` folder, unless you didn't run a `make clean`.

## License

MIT.
