
# CV LaTeX template

This LaTeX template is used by `pdflatex` to generate a dynamic full application plus CV into a PDF file. It targets the **german job market only**!

To customize it to your needs, you have to provide two files essentially:
* `my_data.tex` -- contains your data and CV information
* `recipient_file.tex` -- contains contact informarmation of the recipient

You can provice any number of images of scanned documents to attach in the `data folder`.

To put your data into the correct form, take a look at the example files in `data_example`.

To compile a new PDF for a given recipient, you have to launch `./compile_cv.sh [data folder] [recipient tex file]`.  
Example: `./compile_cv.sh data_example/ data_example/recp_file.tex`.


Remember, you need to **compile it twice to get a correct table of content.**
