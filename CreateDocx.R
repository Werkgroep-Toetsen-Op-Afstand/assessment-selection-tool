docs.all <- list.files("content/1-on-1/application/", pattern = "(\\.md|\\.Rmd)", recursive = T)

docs.nl <- grep("en", docs.all, invert = T, value = T)
docs.nl


yaml = "---
title: test
---\n"

chunks <- paste0("```{r, warning=FALSE, echo=FALSE, results='asis'}\n",
                 "if(!berryFunctions::is.error(yaml::read_yaml('", paste0("content/1-on-1/application/",docs.nl), "')) ) {\n",
                 "paste(",
                 "yaml::read_yaml('", paste0("content/1-on-1/application/",docs.nl), "')$title,\n", 
                 "yaml::read_yaml('", paste0("content/1-on-1/application/",docs.nl), "')$subtitle) -> title\n
cat(paste('##', title))\n}\n```\n \n",
                 "```{r child = '", paste0("content/1-on-1/application/",docs.nl), "'}\n```\n \n",
                 "---\n")


sink("temp.Rmd")
cat(yaml, sep = '\n' )
cat(chunks, sep = '\n')
sink()

bookdown::render_book(input         = "temp.Rmd", 
                      output_format = "word_document",
                      output_file   = "OneOnOneNL.docx")

file.remove("temp.Rmd")