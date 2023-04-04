# makecachematrix function
makecachematrix <- function(x) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(inverse) inv <<- inverse
  getinv <- function() inv
  list(set = set, get = get, setinv = setinv, getinv = getinv)
}

# cachesolve function
cachesolve <- function(x, ...) {
  inv <- x$getinv()
  if (!is.null(inv)) {
    message("Retrieving cached inverse")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv
}