#' Use Custom GT theme.
#'
#' Customize Table Theme with the gt Package.
#'
#' @export
#'
#' @examples
#' library(automaton)
#' library(tidyverse)
#' library(gt)
#'
<<<<<<< HEAD
<<<<<<< HEAD
#' # Assign penguins data set to tbl data frame 'tbl'
#' tbl <- penguins
#'
#' # Convert data frame to gt table format
#' gt_table <- tbl |> gt()
#'
#' # Apply customized gt theme
#' gt_table |> gt_theme_ms()
=======
=======
>>>>>>> 3771dc7000c54237e34c99c812a36266aa80d7e6
#' Assign penguins data set to tbl data frame 'tbl'
#' tbl <- penguins
#' # Convert data frame to gt table format
#' gt_table <- tbl |> gt()

#' # Apply customized gt theme
#' gt_table |> gt_theme_ms()
#' @family Utilities
#'
<<<<<<< HEAD
>>>>>>> 3771dc7000c54237e34c99c812a36266aa80d7e6
=======
>>>>>>> 3771dc7000c54237e34c99c812a36266aa80d7e6

gt_theme_ms <- function(gt_tbl) {

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
