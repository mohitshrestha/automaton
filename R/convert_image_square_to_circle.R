#' Function to convert square image with circle mask
#'
#' @param image_path
#' @param bg_color
#'
#' @return
#' @export
#'
#' @examples
#' convert_image_square_to_circle(image_path = "https://media-exp1.licdn.com/dms/image/C5103AQFH0b7BkENK1A/profile-displayphoto-shrink_800_800/0/1557701878024?e=1672272000&v=beta&t=YHCrjTU6McxfctCdD0-rZGJ3GNRhJ2WVLW3cCbB7tdg", bg_color = "white")
convert_image_square_to_circle <- function(image_path, bg_color = "white"){

    library(magick)
    im <- magick::image_read(image_path)

    # get height, width and crop longer side to match shorter side
    ii <- magick::image_info(im)
    ii_min <- min(ii$width, ii$height)
    im1 <- magick::image_crop(im, geometry=paste0(ii_min, "x", ii_min, "+0+0"), repage=TRUE)

    # create a new image with white background and black circle
    fig <- magick::image_draw(image_blank(ii_min, ii_min))
    symbols(ii_min/2, ii_min/2, circles=(ii_min/2)-3, bg='black', inches=FALSE, add=TRUE)
    dev.off()

    # create an image composite using both images
    im2 <- magick::image_composite(im1, fig, operator='copyopacity')

    # set background as white
    magick::image_background(im2, bg_color)

}
