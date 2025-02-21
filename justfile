default:
  just --list

# Run the npm dev server
srv_dev:
    cd single_page_book_app && npm run dev


gpt_files_content:
    for f in $(cat f.txt); do echo "===========================================================================";echo "File $f"; echo "==========================================================================="; echo '```'; cat $f; echo '```'; done

# Create a json version of the table of content (for Single Page HTML)
tutorial_json_toc:
    python scripts/convert_toc.py

tutorial_prepare: tutorial_json_toc
    cd single_page_book_app && npm install

tutorial_book:
    cd jbook && rm -rf _build && export PYTHONPATH=$(pwd)/sphinx_ext_imgui && jupyter-book build .

tutorial_book_pdf:
    cd jbook && jupyter-book build --builder pdfhtml .
