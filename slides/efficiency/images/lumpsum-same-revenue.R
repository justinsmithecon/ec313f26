# Builds lumpsum-same-revenue.png for the efficiency deck: an ad valorem tax
# on barley versus a lump-sum tax that raises the same revenue.
# Run from the repo root: Rscript slides/efficiency/images/lumpsum-same-revenue.R
#
# Cobb-Douglas utility U = sqrt(B * C), income 100, P_B = P_C = 1, t = 100%.
#   Ad valorem: B2 = 25, C2 = 50, U1 = sqrt(1250); revenue = t * P_B * B2 = 25
#   Lump sum T = 25 at original prices: BL = CL = 37.5, UL = 37.5 > U1

library(ggplot2)
library(ragg)

inc <- 100; t <- 1; T <- t * 25
B2 <- 25; C2 <- 50; BL <- 37.5; CL <- 37.5
U1 <- B2 * C2; UL <- BL * CL            # level sets of B * C

red  <- "#E8432E"
blue <- "#2B6FD6"

ic <- function(k, from, to) {
  b <- seq(from, to, length.out = 400)
  data.frame(b = b, c = k / b)
}

p <- ggplot() +
  # budget lines
  geom_segment(aes(x = 0, y = inc, xend = inc, yend = 0), linewidth = 0.9) +
  geom_segment(aes(x = 0, y = inc, xend = inc / (1 + t), yend = 0), colour = red, linewidth = 0.9) +
  geom_segment(aes(x = 0, y = inc - T, xend = inc - T, yend = 0), colour = blue, linewidth = 0.9,
               linetype = "22") +
  # indifference curves
  geom_line(data = ic(U1, 13.5, 80), aes(b, c), colour = red, linewidth = 0.8) +
  geom_line(data = ic(UL, 15.5, 80), aes(b, c), colour = blue, linewidth = 0.8) +
  # drop lines
  geom_segment(aes(x = B2, y = 0, xend = B2, yend = C2), linetype = "dotted", colour = red) +
  geom_segment(aes(x = 0, y = C2, xend = B2, yend = C2), linetype = "dotted", colour = red) +
  geom_segment(aes(x = BL, y = 0, xend = BL, yend = CL), linetype = "dotted", colour = blue) +
  geom_segment(aes(x = 0, y = CL, xend = BL, yend = CL), linetype = "dotted", colour = blue) +
  geom_point(aes(x = c(B2, BL), y = c(C2, CL)), colour = c(red, blue), size = 2.6) +
  # point and curve labels
  annotate("text", x = B2, y = -4, label = "B2", size = 4.6) +
  annotate("text", x = BL, y = -4, label = "BL", size = 4.6) +
  annotate("text", x = -4.5, y = C2, label = "C2", size = 4.6) +
  annotate("text", x = -4.5, y = CL, label = "CL", size = 4.6) +
  annotate("text", x = 72, y = U1 / 72 - 4, label = "U1", size = 4.6, colour = red) +
  annotate("text", x = 72, y = UL / 72 + 4, label = "UL", size = 4.6, colour = blue) +
  # key for the three budget lines, in the empty upper right
  annotate("segment", x = 58, xend = 66, y = c(98, 91, 84), yend = c(98, 91, 84),
           colour = c("black", red, blue), linetype = c("solid", "solid", "22"), linewidth = 0.9) +
  annotate("text", x = 68, y = c(98, 91, 84),
           label = c("Original budget line", "Ad valorem tax", "Lump-sum tax, same revenue"),
           size = 4.2, hjust = 0) +
  coord_cartesian(xlim = c(-7, 105), ylim = c(-7, 105), expand = FALSE, clip = "off") +
  labs(x = "Barley", y = "Corn") +
  theme_void(base_family = "Helvetica") +
  theme(
    axis.line = element_line(colour = "black", linewidth = 0.6),
    axis.title.x = element_text(size = 13, margin = margin(t = 6)),
    axis.title.y = element_text(size = 13, angle = 90, margin = margin(r = 6)),
    plot.margin = margin(12, 16, 10, 10)
  )

# draw the axes from the origin rather than the panel edge
p <- p + annotate("segment", x = 0, y = 0, xend = 105, yend = 0, linewidth = 0.6) +
  annotate("segment", x = 0, y = 0, xend = 0, yend = 105, linewidth = 0.6) +
  theme(axis.line = element_blank())

agg_png("slides/efficiency/images/lumpsum-same-revenue.png", width = 1592, height = 1200, res = 200,
        background = "white")
print(p)
invisible(dev.off())
