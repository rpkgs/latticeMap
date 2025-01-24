#' panel.spatial
#'
#' @inheritParams lattice::panel.levelplot
#' @inheritParams sp_plot
#' @param par position of title, `list(title = list(x, y))`
#' @param list.mask NULL or list of masks. `mask` is a boolean vector, `TRUE`
#' indicates significant.
#'
#' @importFrom lattice panel.number panel.text
#' @importFrom sp sppanel panel.gridplot panel.polygonsplot
#' @importFrom grid viewport popViewport grid.layout rasterGrob nullGrob
#' @export
panel.spatial <- function(x, y, z, subscripts,
    contour = FALSE,
    class = NULL,
    interpolate = TRUE,
    list.mask = NULL,
    SpatialPixel = NULL,
    ...,
    sp.layout)
{
    dot <- list(...)
    # trellis.par.set("add.text" = list(fontfamily = get_family(), cex = 1.2))
    panel.spatialBasic(x, y, z, subscripts, class, contour, interpolate, ...,
        sp.layout = sp.layout)
    # bbox = c(194, max(xlim), -60, 90) + c(0, -10, 0, 0)
    # panel.annotation(grid.rect(), bbox = bbox, "native")
}

#' @rdname panel.spatial
#' @export
panel.spatialBasic <- function(x, y, z, subscripts,
    class, contour, interpolate,
    ..., sp.layout = NULL)
{
    sppanel(list(sp.layout), panel.number(), first = TRUE)
    if (is.null(class) || class %in% c("SpatialPixelsDataFrame", "SpatialGridDataFrame")) {
        panel.levelplot.raster(x, y, z, subscripts, ..., interpolate = interpolate)
        # panel.levelplot2(x, y, z, subscripts, lty = 0, col = "transparent", ..., interpolate = interpolate)
    } else {
        panel.polygonsplot(x, y, z, subscripts, ..., sp.layout = sp.layout)
    }
    if (contour) {
        panel.levelplot2(x, y, z, subscripts,
            region = TRUE, contour = TRUE, labels = TRUE, interpolate = FALSE)
    }
    sppanel(list(sp.layout), panel.number(), first = FALSE)
}

#' @export
panel.mask <- function(bbox = c(-180, 180, -90, -60)) {
    panel.annotation(
        grid.rect(gp = gpar(col = "transparent", fill = "white")),
        bbox = bbox, "native", clip = "off"
    )
}
