#' Use Custom GT theme.
#'
#' Customize Table Theme with the gt Package.
#'
#' @export

gt_theme_ms <- function(gt_tbl) {

    # Grab number of rows of data from gt object
    n_rows <- nrow(gt_tbl$`_data`)

    gt_tbl |>
        tab_options(
            data_row.padding = px(6),
            heading.align = 'left',
            column_labels.background.color = 'dodgerblue4',
            heading.title.font.size = px(26),
            heading.subtitle.font.size = px(14),
            table_body.hlines.width = px(0)
        ) |>
        tab_style(
            style = cell_text(
                color = 'dodgerblue4',
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
