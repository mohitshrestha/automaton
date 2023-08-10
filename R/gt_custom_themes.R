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
#' gt_tbl <- tbl |> gt()
#'
#' gt_tbl |> gt_theme_ms()

gt_theme_ms <- function(gt_tbl = automaton::penguins |> gt()) {

    # Grab number of rows of data from gt object
    n_rows <- nrow(gt_tbl$`_data`)

    gt_tbl |>
        tab_options(
            data_row.padding = px(6),
            heading.align = 'left',
            column_labels.background.color = ms_brand_palette("main")[length(ms_brand_palette("main"))],
            heading.title.font.size = px(26),
            heading.subtitle.font.size = px(14),
            table_body.hlines.width = px(0)
        ) |>
        tab_style(
            style = cell_text(
                color = ms_brand_palette("main")[length(ms_brand_palette("main"))],
                weight = 'bold',
                font = google_font('Merriweather')
            ),
            locations = cells_title(groups = 'title')
        ) |>
        tab_style(
            style = cell_fill(color = 'grey90'),
            # Use number of rows from data set
            locations = cells_body(rows = seq(1, n_rows, 2))
        )
}
