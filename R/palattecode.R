ms_brand_palette <- function(palette = "main", ...) {

    ms_brand_palettes <- list(
        # main colors is inspired by hiroshige
        "main" = c("#e76254", "#ef8a47", "#f7aa58", "#ffd06f", "#ffe6b7", "#aadce0", "#72bcd5", "#528fad", "#376795", "#1e466e"),

        "highlight" = c("blue", "gray")
    )

    ms_brand_palettes[[palette]]

}

# The `show_col` function from the `scales` package is a nifty way to showcase all the colors available in a given palette:
## scales::show_col(ms_brand_palette("main"), cex_label = 1)
## scales::show_col(ms_brand_palette("highlight"), cex_label = 1)
