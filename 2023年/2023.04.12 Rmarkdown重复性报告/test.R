library(rmarkdown)
school = c("A中学","B中学")
for(v in school){
  render("中文.Rmd",
         output_file=paste0("result/exploratory_", v, ".pdf"),
         params=list(new_title=v))
}
