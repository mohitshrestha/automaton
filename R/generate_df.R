#' Generate pseudorandom dataframes with specific parameters
#' @description This function is a small utility to create a specific length dataframe
#' with a set number of groups, specific mean/sd per group. Note that the total length
#' of the dataframe will be `n` * `n_grps`.
#' @param n An integer indicating the number of rows per group, default to `10`
#' @param n_grps An integer indicating the number of rows per group, defaults to `1`
#' @param mean A number indicating the mean of the randomly generated values, must be a vector of equal length to the `n_grps`
#' @param sd A number indicating the standard deviation of the randomly generated values, must be a vector of equal length to the `n_grps`
#' @param with_seed A seed to make the randomization reproducible
#' @return a tibble/dataframe
#' @export
#'
#' @examples
#' generate_df()
#' generate_df(n = 100L, n_grps = 5L, with_seed = NULL, mean = seq(10, 50, length.out = 5))
#'
#' library(dplyr)
#' generate_df(
#'   100L,
#'   n_grps = 5,
#'   mean = seq(10, 50, length.out = 5)
#' ) |>
#'   group_by(grp) |>
#'   summarise(
#'     mean = mean(values), # mean is approx mean
#'     sd = sd(values),     # sd is approx sd
#'     n = n(),             # each grp is of length n
#'     # showing that the sd default of mean/10 works
#'     `mean/sd` = round(mean / sd, 1)
#'   )
#' @family Utilities
#'
generate_df <- function(n = 10L, n_grps = 1L, with_seed = NULL, mean = c(10), sd = mean/10){

    # If a seed is specified, then use it, otherwise ignore
    if(!is.null(with_seed)){set.seed(with_seed)}

    # pad the values with repeated zeros
    pad_length <- paste0("%0", nchar(n), "d")
    random_int <- sample(1:n, replace = TRUE)
    padded_int <- sprintf(pad_length, random_int)

    # create a df with combined random letters and integers
    dplyr::tibble(
        row_id = 1:(n*n_grps),
        id = paste0(sample(LETTERS, n*n_grps, replace = TRUE), padded_int),
        grp = sprintf("grp-%s", 1:n_grps) |> rep(each = n),
        values = mapply(rnorm, n, mean, sd) |> as.vector()
    )

}
