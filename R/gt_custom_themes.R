#' Customize GT table
#'
#' @description Customize Table Theme with the gt Package.
#'
#' @param gt_tbl Input GT table not just data frame. First convert data frame/tibble to GT table then input that gt table to the function
#'
#' @return Returns the gt table using the customized theme
#' @export
#'
#' @examples
#' library(automaton)
#' library(gt)
#' tbl <- automaton::penguins
#' gt_tbl <- tbl |>
#'             dplyr::count(species) |>
#'             gt::gt()
#'
#' gt_tbl |> gt_theme_ms()

gt_theme_ms <- function(data = automaton::penguins) {

    # Ensure data entered is a gt table object
    if (is.data.frame(data) == TRUE) {
        gt_tbl <- data |> gt::gt()
    } else {
        gt_tbl <- data
    }

    # Grab number of rows of data from gt object
    n_rows <- nrow(gt_tbl$`_data`)

    gt_tbl |>
        gt::tab_options(
            data_row.padding = gt::px(6),
            heading.align = 'left',
            column_labels.background.color = ms_brand_palette("main")[length(ms_brand_palette("main"))],
            heading.title.font.size = gt::px(26),
            heading.subtitle.font.size = gt::px(14),
            table_body.hlines.width = gt::px(0)
        ) |>
        gt::tab_style(
            style = gt::cell_text(
                color = ms_brand_palette("main")[length(ms_brand_palette("main"))],
                weight = 'bold',
                font = gt::google_font('Merriweather')
            ),
            locations = gt::cells_title(groups = 'title')
        ) |>
        gt::tab_style(
            style = gt::cell_fill(color = 'grey90'),
            # Use number of rows from data set
            locations = gt::cells_body(rows = seq(1, n_rows, 2))
        )
}
