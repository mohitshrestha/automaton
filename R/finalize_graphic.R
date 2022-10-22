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

save_plot <- function (plot_grid, width, height, save_filepath) {
    grid::grid.draw(plot_grid)
    #save it
    ggplot2::ggsave(filename = save_filepath,
                    plot=plot_grid, width=(width/72), height=(height/72),  bg="white")
}

#Left align text
left_align <- function(plot_name, pieces){
    grob <- ggplot2::ggplotGrob(plot_name)
    n <- length(pieces)
    grob$layout$l[grob$layout$name %in% pieces] <- 2
    return(grob)
}

create_footer <- function (source_name, copyright, logo_image_path) {
    #Make the footer
    footer <- grid::grobTree(grid::linesGrob(x = grid::unit(c(0, 1), "npc"), y = grid::unit(1.1, "npc")),
                             grid::textGrob(source_name,
                                            x = 0.004, hjust = 0, gp = grid::gpar(fontsize=9)),
                             grid::textGrob(copyright,
                                            x = 0.996, hjust = 1.05, gp = grid::gpar(fontsize=9)),
                             grid::rasterGrob(png::readPNG(logo_image_path), x = 0.5))
    return(footer)

}

finalize_plot <- function(plot_name,
                          source_name,
                          copyright,
                          save_filepath=file.path(Sys.getenv("TMPDIR"), "tmp-nc.png"),
                          width_pixels=240,
                          height_pixels=150,
                          logo_image_path = file.path(system.file("data", package = 'automaton'),"logo.png")
) {

    footer <- create_footer(source_name, copyright, logo_image_path)

    #Draw your left-aligned grid
    plot_left_aligned <- left_align(plot_name, c("subtitle", "title", "caption"))
    plot_grid <- ggpubr::ggarrange(plot_left_aligned, footer,
                                   ncol = 1, nrow = 2,
                                   heights = c(1, 0.030/(height_pixels/300)))
    ## print(paste("Saving to", save_filepath))
    save_plot(plot_grid, width_pixels, height_pixels, save_filepath)
    ## Return (invisibly) a copy of the graph. Can be assigned to a
    ## variable or silently ignored.
    invisible(plot_grid)
}
