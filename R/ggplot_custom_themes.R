
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
    ggplot2::theme_light(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(

            # Base Inherited Elements
            line = element_line(color = "black", size = .5,
                                linetype = 1, lineend = "butt"),
            rect = element_rect(fill = "white", color = "black",
                                size = .5, linetype = 1),
            text = element_text(family = base_family, face = "plain",
                                color = "black", size = base_size,
                                lineheight = .9, hjust = .5, vjust = .5,
                                angle = 0, margin = margin(), debug = FALSE),

            # Axes
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

            # Legend
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

            # Panel
            panel.background = element_rect(fill = "white", color = NA),
            panel.border = element_rect(color = "gray30",
                                        fill = NA, size = .5),
            panel.grid.major = element_line(color = "gray90", size = 0.5),
            panel.grid.minor = element_blank(),
            panel.spacing = unit(base_size, "pt"),
            panel.spacing.x = NULL,
            panel.spacing.y = NULL,
            panel.ontop = FALSE,

            # Strip (Used with multiple panels)
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

            # Plot
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

            # Complete theme
            complete = TRUE,
            ...
        )
}


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
theme_ms_dark <- function(base_size = 11, base_family = "", ...) {

    # Starts with theme_ms and then invert some colors
    theme_ms(base_size = base_size, base_family = base_family) %+replace%
        ggplot2::theme(

            # Axes
            axis.ticks         = element_line(color = "gray30"),

            # Panel
            panel.background   = element_rect(fill = "#CCCCCC", color = NA),
            panel.grid.major   = element_line(color = "white"),

            # Complete theme
            complete = TRUE,
            ...
        )
}
