## This project creates a pair of functions, the first makeCacheMatrix caches a matrix
## calculation result in a global environmental variable.  The second calculates the 
## inverse matrix if it has not been previously cached.

## makeCacheMatrix function as described above to cache a matrix calculation in the global environment.

## Example: Caching the Mean of a Vector

# In this example we introduce the `<<-` operator which can be used to
# assign a value to an object in an environment that is different from the
# current environment. Below are two functions that are used to create a
# special object that stores a numeric vector and caches its mean.
# 
# The first function, `makeVector` creates a special "vector", which is
# really a list containing a function to
# 
# 1.  set the value of the vector
# 2.  get the value of the vector
# 3.  set the value of the mean
# 4.  get the value of the mean
# 
# <!-- -->
# makeVector <- function(x = numeric()) {
#     m <- NULL
#     set <- function(y) {
#         x <<- y
#         m <<- NULL
#     }
#     get <- function() x
#     setmean <- function(mean) m <<- mean
#     getmean <- function() m
#     list(set = set, get = get,
#          setmean = setmean,
#          getmean = getmean)
# }
# The following function calculates the mean of the special "vector"
# created with the above function. However, it first checks to see if the
# mean has already been calculated. If so, it `get`s the mean from the
# cache and skips the computation. Otherwise, it calculates the mean of
# the data and sets the value of the mean in the cache via the `setmean`
# function.
# 
# cachemean <- function(x, ...) {
#     m <- x$getmean()
#     if(!is.null(m)) {
#         message("getting cached data")
#         return(m)
#     }
#     data <- x$get()
#     m <- mean(data, ...)
#     x$setmean(m)
#     m
# }

## makeCacheMatrix starts here

makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    set_invert <- function(invert) m <<- invert
    get_invert <- function() m
    list(set = set, get = get,
         set_invert = set_invert,
         get_invert = get_invert)
    
}

## Return a matrix that is the inverse of 'x', first checking if already lives in the Cache

cacheSolve <- function(x, ...) {
        m <- x$get_invert()
        if(!is.null(m)) {
            message("Attn: Getting cached inverse matrix, use the $set function to refresh the matrix if required")
            return(m)
        }
        i_matrix <- x$get()
        m <- solve(i_matrix, ...)
        x$set_invert(m)
        m
}

