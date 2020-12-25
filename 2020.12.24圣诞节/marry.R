# https://www.data-imaginist.com/2016/Data-driven-x-mas-card/

library(jsonlite)
library(ggplot2)

greet <- fromJSON(readLines('F:/我的学习/R/R_example/2020.12.24圣诞节/1.json'))
layer_names <- greet$layers$name
heart <- greet$layers$paths[[which(layer_names == 'Heart')]]$points
merry <- greet$layers$paths[[which(layer_names == 'Merry')]]$points
x_mas <- greet$layers$paths[[which(layer_names == 'X-MAS')]]$points
range <- greet$layers$paths[[which(layer_names == 'back')]]$points[[1]]

ggplot(as.data.frame(heart[[1]])) +
  geom_polygon(aes(V1, V2))
#============
library(mgcv)
heart_points <- data.frame(
  x = runif(25000, min = min(range[,1]), max = max(range[, 1])),
  y = runif(25000, min = min(range[,2]), max = max(range[, 2])),
  colour = 'green',
  stringsAsFactors = FALSE
)
heart_points$colour[
  in.out(
    do.call(rbind, lapply(heart, rbind, c(NA, NA))),
    cbind(heart_points$x, heart_points$y)
  )
] <- 'red'

merry_points <- data.frame(
  x = runif(25000, min = min(range[,1]), max = max(range[, 1])),
  y = runif(25000, min = min(range[,2]), max = max(range[, 2])),
  colour = 'red',
  stringsAsFactors = FALSE
)
merry_points$colour[
  in.out(
    do.call(rbind, lapply(merry, rbind, c(NA, NA))),
    cbind(merry_points$x, merry_points$y)
  )
] <- 'green'

xmas_points <- data.frame(
  x = runif(25000, min = min(range[,1]), max = max(range[, 1])),
  y = runif(25000, min = min(range[,2]), max = max(range[, 2])),
  colour = 'red',
  stringsAsFactors = FALSE
)
xmas_points$colour[
  in.out(
    do.call(rbind, lapply(x_mas, rbind, c(NA, NA))),
    cbind(xmas_points$x, xmas_points$y)
  )
] <- 'green'

ggplot(merry_points) +
  geom_point(aes(x, y, colour = colour))

#===================

library(deldir)
library(ggforce)

heart_vor <- deldir(heart_points$x, heart_points$y)
heart_con <- split(c(heart_points$colour[heart_vor$delsgs$ind2],
                     heart_points$colour[heart_vor$delsgs$ind1]),
                   c(heart_vor$delsgs$ind1, heart_vor$delsgs$ind2))
heart_boring <- lengths(lapply(heart_con, unique)) == 1
heart_remove <- c(
  sample(which(heart_boring & heart_points$colour == 'red'),
         sum(heart_boring & heart_points$colour == 'red') -
           (1000 - sum(!heart_boring & heart_points$colour == 'red'))),
  sample(which(heart_boring & heart_points$colour == 'green'),
         sum(heart_boring & heart_points$colour == 'green') -
           (1000 - sum(!heart_boring & heart_points$colour == 'green')))
)
heart_points <- heart_points[-heart_remove, ]

merry_vor <- deldir(merry_points$x, merry_points$y)
merry_con <- split(c(merry_points$colour[merry_vor$delsgs$ind2],
                     merry_points$colour[merry_vor$delsgs$ind1]),
                   c(merry_vor$delsgs$ind1, merry_vor$delsgs$ind2))
merry_boring <- lengths(lapply(merry_con, unique)) == 1
merry_remove <- c(
  sample(which(merry_boring & merry_points$colour == 'red'),
         sum(merry_boring & merry_points$colour == 'red') -
           (1000 - sum(!merry_boring & merry_points$colour == 'red'))),
  sample(which(merry_boring & merry_points$colour == 'green'),
         sum(merry_boring & merry_points$colour == 'green') -
           (1000 - sum(!merry_boring & merry_points$colour == 'green')))
)
merry_points <- merry_points[-merry_remove, ]

xmas_vor <- deldir(xmas_points$x, xmas_points$y)
xmas_con <- split(c(xmas_points$colour[xmas_vor$delsgs$ind2],
                    xmas_points$colour[xmas_vor$delsgs$ind1]),
                  c(xmas_vor$delsgs$ind1, xmas_vor$delsgs$ind2))
xmas_boring <- lengths(lapply(xmas_con, unique)) == 1
xmas_remove <- c(
  sample(which(xmas_boring & xmas_points$colour == 'red'),
         sum(xmas_boring & xmas_points$colour == 'red') -
           (1000 - sum(!xmas_boring & xmas_points$colour == 'red'))),
  sample(which(xmas_boring & xmas_points$colour == 'green'),
         sum(xmas_boring & xmas_points$colour == 'green') -
           (1000 - sum(!xmas_boring & xmas_points$colour == 'green')))
)
xmas_points <- xmas_points[-xmas_remove, ]

ggplot(xmas_points) +
  geom_voronoi_tile(aes(x, y, fill = colour), colour = 'black')


#=====================
heart_points <- heart_points[order(heart_points$colour), ]
heart_points$id <- seq_len(nrow(heart_points))
merry_points <- merry_points[order(merry_points$colour), ]
merry_points$id <- seq_len(nrow(merry_points))
xmas_points <- xmas_points[order(xmas_points$colour), ]

eu_dist <- function(x, y) {
  ifelse(
    merry_points$colour[x] != xmas_points$colour[y],
    1e5,
    sqrt((merry_points$x[x] - xmas_points$x[y])^2 +
           (merry_points$y[x] - xmas_points$y[y])^2)
  )
}
distance <- outer(seq_len(nrow(merry_points)),
                  seq_len(nrow(merry_points)),
                  eu_dist
)

pair <- Reduce(function(l, r) {
  pair_order <- order(distance[r, ])
  c(l, pair_order[which(!pair_order %in% l)[1]])
}, seq_len(nrow(merry_points)), init = integer())

xmas_points$id[pair] <- seq_len(nrow(xmas_points))
xmas_points <- xmas_points[order(xmas_points$id), ]


#=======================
library(tweenr)
tween_points <- function(from, to, length, stagger) {
  leave <- sample(seq_len(stagger), nrow(from), replace = TRUE)
  arive <- sample(seq_len(stagger), nrow(from), replace = TRUE)
  x <- tween_t(Map(function(.f, .t) c(.f, .t), .f = from$x, .t = to$x),
               length - leave - arive)
  y <- tween_t(Map(function(.f, .t) c(.f, .t), .f = from$y, .t = to$y),
               length - leave - arive)
  points <- Map(function(x, y, l, a) {
    data.frame(x = x, y = y)[c(rep(1, l), seq_along(x), rep(length(x), a)), ]
  }, x = x, y = y, l = leave, a = arive)
  points <- do.call(rbind, points)
  points$frame <- rep(seq_len(length), nrow(from))
  cbind(
    points,
    from[rep(seq_len(nrow(from)), each = length), !names(from) %in% c('x', 'y')])
}


#================
n_frames_still <- 36
n_frames_trans <- 60
n_frames_stagger <- 20
n_frames_stage <- 96

heart_to_merry <- tween_points(heart_points,
                               merry_points,
                               n_frames_trans,
                               n_frames_stagger)
merry_to_xmas <- tween_points(merry_points,
                              xmas_points,
                              n_frames_trans,
                              n_frames_stagger)
xmas_to_heart <- tween_points(xmas_points,
                              heart_points,
                              n_frames_trans,
                              n_frames_stagger)


#================
heart_still <- heart_points[rep(seq_len(nrow(heart_points)), n_frames_still), ]
heart_still$frame <- rep(seq_len(n_frames_still), each = nrow(heart_points))
heart_to_merry$frame <- heart_to_merry$frame + n_frames_still

merry_still <- merry_points[rep(seq_len(nrow(merry_points)), n_frames_still), ]
merry_still$frame <- rep(seq_len(n_frames_still), each = nrow(merry_points)) + n_frames_stage
merry_to_xmas$frame <- merry_to_xmas$frame + n_frames_stage + n_frames_still

xmas_still <- xmas_points[rep(seq_len(nrow(xmas_points)), n_frames_still), ]
xmas_still$frame <- rep(seq_len(n_frames_still), each = nrow(xmas_points)) + 2*n_frames_stage
xmas_to_heart$frame <- xmas_to_heart$frame + 2*n_frames_stage + n_frames_still

frames <- rbind(
  heart_still,
  heart_to_merry,
  merry_still,
  merry_to_xmas,
  xmas_still,
  xmas_to_heart
)


christmas_card <- function(data) {
  bound <- c(range(range[,1]), range(-range[,2]))
  ggplot(data, aes(x = x, y = y)) +
    geom_voronoi_tile(aes(fill = colour), bound = bound) +
    geom_voronoi_segment(alpha = 0.3, bound = bound) +
    scale_y_reverse() +
    scale_fill_manual(values = c('forestgreen', 'firebrick')) +
    labs(caption = 'www.data-imaginist.com') +
    coord_fixed(expand = FALSE) +
    theme_void() +
    theme(legend.position = 'none')
}
plot(christmas_card(heart_points))

for (i in seq_len(max(frames$frame))) {
  data <- frames[frames$frame == i, ]
  plot(christmas_card(data))
}

