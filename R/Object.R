#  MIT License
#
#  Copyright (c) 2017-2020 TileDB Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in all
#  copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
#  SOFTWARE.

check_object_arguments <- function(uri, ctx = tiledb_get_context()) {
  if (!is(ctx, "tiledb_ctx")) {
    stop("argument ctx must a a tiledb_ctx")
  }
  if (missing(uri) || !is.scalar(uri, "character")) {
    stop("argument uri must be a string scalar ")
  }
  return(TRUE)
}

#' Creates a TileDB group object at given uri path
#'
#' @param uri path which to create group
#' @param ctx tiledb_ctx object (optional)
#' @return uri of created group
#' @examples
#' \dontshow{ctx <- tiledb_ctx(limitTileDBCores())}
#' pth <- tempdir()
#' tiledb_group_create(pth)
#' tiledb_object_type(pth)
#'
#'@export
tiledb_group_create <- function(uri, ctx = tiledb_get_context()) {
  check_object_arguments(uri, ctx)
  return(libtiledb_group_create(ctx@ptr, uri))
}

#' Return the TileDB object type string of a TileDB resource
#'
#' Object types:
#'  - `"ARRAY"`, dense or sparse TileDB array
#'  - `"GROUP"`, TileDB group
#'  - `"INVALID"``, not a TileDB resource
#'
#' @param uri path to TileDB resource
#' @param ctx tiledb_ctx object (optional)
#' @return TileDB object type string
#'
#' @export
tiledb_object_type <- function(uri, ctx = tiledb_get_context()) {
  check_object_arguments(uri, ctx)
  return(libtiledb_object_type(ctx@ptr, uri))
}

#' Removes a TileDB resource
#'
#' Raises an error if the uri is invalid, or the uri resource is not a tiledb object
#'
#' @param uri path which to create group
#' @param ctx tiledb_ctx object (optional)
#' @return uri of removed TileDB resource
#' @export
tiledb_object_rm <- function(uri, ctx = tiledb_get_context()) {
  check_object_arguments(uri, ctx)
  return(libtiledb_object_remove(ctx@ptr, uri))
}

#' Move a TileDB resource to new uri path
#'
#' Raises an error if either uri is invalid, or the old uri resource is not a tiledb object
#'
#' @param old_uri old uri of existing tiledb resource
#' @param new_uri new uri to move tiledb resource
#' @param ctx tiledb_ctx object (optional)
#' @return new uri of moved tiledb resource
#' @export
tiledb_object_mv <- function(old_uri, new_uri, ctx = tiledb_get_context()) {
  if (!is(ctx, "tiledb_ctx")) {
    stop("argument ctx must a a tiledb_ctx")
  }
  if (missing(old_uri) || !is.scalar(old_uri, "character")) {
    stop("argument old_uri must be a string scalar ")
  }
  if (missing(new_uri) || !is.scalar(new_uri, "character")) {
    stop("argument old_uri must be a string scalar ")
  }
  return(libtiledb_object_move(ctx@ptr, old_uri, new_uri))
}

#' List TileDB resources at a given root URI path
#'
#' @param uri uri path to walk
#' @param filter optional filtering argument, default is "NULL", currently unused
#' @param ctx tiledb_ctx object (optional)
#' @return a dataframe with object type, object uri string columns
#' @export
tiledb_object_ls <- function(uri, filter = NULL, ctx = tiledb_get_context()) {
  check_object_arguments(uri, ctx)
  return(libtiledb_object_walk(ctx@ptr, uri, order = "PREORDER"))
}

#' Recursively discover TileDB resources at a given root URI path
#'
#' @param uri root uri path to walk
#' @param order (default "PREORDER") specify "POSTORDER" for "POSTORDER" traversal
#' @param ctx tiledb_ctx object (optional)
#' @return a dataframe with object type, object uri string columns
#' @export
tiledb_object_walk <- function(uri, order = "PREORDER", ctx = tiledb_get_context()) {
  check_object_arguments(uri, ctx)
  return(libtiledb_object_walk(ctx@ptr, uri, order = order, recursive = TRUE))
}
