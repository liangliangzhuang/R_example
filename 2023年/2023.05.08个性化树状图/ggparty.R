# 代码来源：https://github.com/martin-borkovec/ggparty
# 代码解析/推文：https://mp.weixin.qq.com/s/8pP7IWLH-RaIxEtnyuCjhA


library(ggparty)
library(ARE)

data("TeachingRatings", package = "AER")
str(TeachingRatings)
tr <- subset(TeachingRatings, credits == "more")

tr_tree <- lmtree(eval ~ beauty | minority + age + gender + division + native +
                    tenure, data = tr, weights = students, caseweights = FALSE)

ggparty(tr_tree,
        terminal_space = 0.5,
        add_vars = list(p.value = "$node$info$p.value")) +
  geom_edge(size = 1.5) +
  geom_edge_label(colour = "grey", size = 6) +
  geom_node_plot(gglist = list(geom_point(aes(x = beauty,
                                              y = eval,
                                              col = tenure,
                                              shape = minority),
                                          alpha = 0.8),
                               theme_bw(base_size = 15)),
                 scales = "fixed",
                 id = "terminal",
                 shared_axis_labels = T,
                 shared_legend = T,
                 legend_separator = T,
                 predict = "beauty",
                 predict_gpar = list(col = "blue",
                                     size = 1.2)
  ) +
  geom_node_label(aes(col = splitvar),
                  line_list = list(aes(label = paste("Node", id)),
                                   aes(label = splitvar),
                                   aes(label = paste("p =", formatC(p.value, format = "e", digits = 2)))),
                  line_gpar = list(list(size = 12, col = "black", fontface = "bold"),
                                   list(size = 20),
                                   list(size = 12)),
                  ids = "inner") +
  geom_node_label(aes(label = paste0("Node ", id, ", N = ", nodesize)),
                  fontface = "bold",
                  ids = "terminal",
                  size = 5, 
                  nudge_y = 0.01) +
  theme(legend.position = "none")

