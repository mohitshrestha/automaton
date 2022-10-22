# load new font
if (!require("pacman")) install.packages("pacman")
pacman::p_load(
    showtext)
library(showtext)

# You will need to have internet connection
# If you restart R you will need to execute this code again to use the font
font_add_google(name = "Roboto Condensed",   # Name of the font on the Google Fonts site
                family = "roboto_condensed") # Name you want to use to call the font
showtext_auto()

ms_brand_colours <- c(
    "blue"   = "#00798c",
    "red"    = "#d1495b",
    "yellow" = "#edae49",
    "green"  = "#66a182",
    "navy"   = "#2e4057",
    "gray"   = "#8d96a3"
)

# First, start by defining the various colors we need.
#' Title
#'
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
ms_brand_colour <- function(...) {

    ms_brand_colours <- ms_brand_colours

    cols <- c(...)

    if (is.null(cols))
        return (ms_brand_colours)

    var <- var

    ms_brand_colours[cols]
}

ms_brand_color <- ms_brand_colour

## That `ms_brand_color` function then becomes the base of the `ms_brand_palette` function below, where those defined colors are combined into palettes.
## Your organization might have primary and secondary palettes, or palettes designed for specific uses,
## but here we’ll define a `main` palette as well as a `highlight` palette for when we want just two colors.
#' Title
#'
#' @param palette
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
ms_brand_palette <- function(palette = "main", ...) {

    ms_brand_palettes <- list(
        # main colors is inspired by hiroshige
        "main" = c("#e76254", "#ef8a47", "#f7aa58", "#ffd06f", "#ffe6b7", "#aadce0", "#72bcd5", "#528fad", "#376795", "#1e466e"),

        "highlight" = ms_brand_color("blue", "gray")
    )

    ms_brand_palettes[[palette]]

}

# The `show_col` function from the `scales` package is a nifty way to showcase all the colors available in a given palette:
## scales::show_col(ms_brand_palette("main"), cex_label = 2)
## scales::show_col(ms_brand_palette("highlight"), cex_label = 2)

# Creating your own `scale_color` and `scale_fill` functions
## Having the colors and palettes defined is a great first step, but you can go even further and apply those into your own `scale_fill` and `scale_color` functions.
## The first step is a helper function, here called `palette_gen`. This function has two arguments, the name of the palette (“main” will be our default) and the direction (so you can flip the scale if necessary),
## and essentially creates another function that will be used in the `scale_fill` and `scale_color` functions.
## (The `n` there refers to the number of colors that would be needed for a particular plot.)
palette_gen <- function(palette = "main", direction = 1) {

#' Title
#'
#' @param n
#'
#' @return
#' @export
#'
#' @examples
    function(n) {

        if (n > length(ms_brand_palette(palette)))
            warning("Not enough colors in this defined custom brand palette!")

        else {

            all_colors <- ms_brand_palette(palette)

            all_colors <- unname(unlist(all_colors))

            all_colors <- if (direction >= 0) all_colors else rev(all_colors)

            color_list <- all_colors[1:n]

        }
    }
}

## The function above is for discrete color scales.
## If you also want to use continuous color scales, the function below uses the existing `colorRampPalette` function
## to interpolate the necessary colors between the ones you have chosen in your palette.
#' Title
#'
#' @param palette
#' @param direction
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
palette_gen_c <- function(palette = "main", direction = 1, ...) {

    pal <- ms_brand_palette(palette)

    pal <- if (direction >= 0) pal else rev(pal)

    colorRampPalette(pal, ...)

}

## With that helper function created, you can write the actual functions to be used with `ggplot2`.
## I’ve called mine `scale_fill_ms`, which takes the same two arguments as before: `palette` and `direction`.
#' Title
#'
#' @param palette
#' @param direction
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
scale_fill_ms <- function(palette = "main", direction = 1, ...) {

    ggplot2::discrete_scale(
        "fill", "ms",
        palette_gen(palette, direction),
        ...
    )
}

## You can use the same syntax for `scale_color`.
## Fun fact: `ggplot2` convention is to create a `scale_colour` function and then replicate it as `scale_color`.
### For `discrete` color scales
#' Title
#'
#' @param palette
#' @param direction
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
scale_colour_ms <- function(palette = "main", direction = 1, ...) {

    ggplot2::discrete_scale(
        "colour", "ms",
        palette_gen(palette, direction),
        ...
    )
}

scale_color_ms <- scale_colour_ms

### For `continuous` color scales
#' Title
#'
#' @param palette
#' @param direction
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
scale_colour_ms_c <- function(palette = "main", direction = 1, ...) {

    pal <- palette_gen_c(palette = palette, direction = direction)

    scale_color_gradientn(colors = pal(256), ...)

}

scale_color_ms_c <- scale_colour_ms_c


## Below is the code for custom brand theme: `theme_ms`

#' Title
#'
#' @param base_size
#' @param base_family
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
theme_ms <- function(base_size = 12, base_family = "roboto_condensed", ...) {
    half_line <- base_size/2

    font <- base_family

    caption_text = paste("Graphic generated on:", format(Sys.time(), '%B, %Y'), "\nCopyright", "\u00A9","Mohit Shrestha | Website: mohitshrestha.com.np", sep=" ")

    # Starts with theme_grey and then modify some parts
    ggplot2::theme_minimal(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(

            line = element_line(color = "black", size = .5,
                                linetype = 1, lineend = "butt"),
            rect = element_rect(fill = "white", color = "black",
                                size = .5, linetype = 1),
            text = element_text(family = base_family, face = "plain",
                                color = "black", size = base_size,
                                lineheight = .9, hjust = .5, vjust = .5,
                                angle = 0, margin = margin(), debug = FALSE),
            axis.line = element_blank(),
            axis.line.x = NULL,
            axis.line.y = NULL,
            axis.text = element_text(size = base_size * 1.1, color = "gray30"),
            axis.text.x = element_text(margin = margin(t = .8 * half_line/2),
                                       vjust = 1),
            axis.text.x.top = element_text(margin = margin(b = .8 * half_line/2),
                                           vjust = 0),
            axis.text.y = element_text(margin = margin(r = .8 * half_line/2),
                                       hjust = 1),
            axis.text.y.right = element_text(margin = margin(l = .8 * half_line/2),
                                             hjust = 0),
            axis.ticks = element_line(color = "gray30", size = .7),
            axis.ticks.length = unit(half_line / 1.5, "pt"),
            axis.ticks.length.x = NULL,
            axis.ticks.length.x.top = NULL,
            axis.ticks.length.x.bottom = NULL,
            axis.ticks.length.y = NULL,
            axis.ticks.length.y.left = NULL,
            axis.ticks.length.y.right = NULL,
            axis.title.x = element_text(margin = margin(t = half_line),
                                        vjust = 1, size = base_size * 1.3,
                                        face = "bold"),
            axis.title.x.top = element_text(margin = margin(b = half_line),
                                            vjust = 0),
            axis.title.y = element_text(angle = 90, vjust = 1,
                                        margin = margin(r = half_line),
                                        size = base_size * 1.3, face = "bold"),
            axis.title.y.right = element_text(angle = -90, vjust = 0,
                                              margin = margin(l = half_line)),
            legend.background = element_rect(color = NA),
            legend.spacing = unit(.4, "cm"),
            legend.spacing.x = NULL,
            legend.spacing.y = NULL,
            legend.margin = margin(.2, .2, .2, .2, "cm"),
            legend.key = element_rect(fill = "gray95", color = "white"),
            legend.key.size = unit(1.2, "lines"),
            legend.key.height = NULL,
            legend.key.width = NULL,
            legend.text = element_text(size = rel(.8)),
            legend.text.align = NULL,
            legend.title = element_text(hjust = 0),
            legend.title.align = NULL,
            legend.position = "bottom",
            legend.direction = NULL,
            legend.justification = "center",
            legend.box = NULL,
            legend.box.margin = margin(0, 0, 0, 0, "cm"),
            legend.box.background = element_blank(),
            legend.box.spacing = unit(.4, "cm"),
            panel.background = element_rect(fill = "white", color = NA),
            panel.border = element_rect(color = "gray30",
                                        fill = NA, size = .5),
            panel.grid.major = element_line(color = "gray90", size = 0.5),
            panel.grid.minor = element_blank(),
            panel.spacing = unit(base_size, "pt"),
            panel.spacing.x = NULL,
            panel.spacing.y = NULL,
            panel.ontop = FALSE,
            strip.background = element_rect(fill = "white", color = "gray30"),
            strip.text = element_text(color = "black", size = base_size),
            strip.text.x = element_text(margin = margin(t = half_line,
                                                        b = half_line)),
            strip.text.y = element_text(angle = -90,
                                        margin = margin(l = half_line,
                                                        r = half_line)),
            strip.text.y.left = element_text(angle = 90),
            strip.placement = "inside",
            strip.placement.x = NULL,
            strip.placement.y = NULL,
            strip.switch.pad.grid = unit(0.1, "cm"),
            strip.switch.pad.wrap = unit(0.1, "cm"),
            plot.background = element_rect(color = NA),
            plot.title = element_text(size = base_size * 1.8, hjust = 0,
                                      vjust = 1, face = "bold",
                                      color = ms_brand_palette("main")[1],
                                      margin = margin(b = half_line * 1.2)),
            plot.title.position = "panel",
            plot.subtitle = element_text(size = base_size * 1.3,
                                         hjust = 0, vjust = 1,
                                         color = ms_brand_palette("main")[length(ms_brand_palette("main"))],
                                         margin = margin(b = half_line * .9)),
            plot.caption = element_text(size = rel(0.8), hjust = 1, vjust = 1,
                                        margin = margin(t = half_line * .9)),
            plot.caption.position = "panel",
            plot.tag = element_text(size = rel(1.2), hjust = .5, vjust = .5),
            plot.tag.position = "topleft",
            plot.margin = margin(base_size, base_size, base_size, base_size),

            complete = TRUE,
            ...
        )
}

