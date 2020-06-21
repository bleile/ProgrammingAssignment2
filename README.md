### Programming Assignment 2 p/o JHU Learning R Course, C. Bleile, 21 Jun 2020

## Caching the Inverse of a Matrix

We cache the results of costly functions such as matrix inversion so that if we call for that result numerous times, we can use the already computed cached result.  In this case, there are two functions created: 

1. **makeCacheMatrix()** which is used to cache a matrix and create a list of functions to service the cached matrix in the global environment.  Example usage: *cachedmatrixvar <- makeCacheMatrix(A)*, where A is a predefined square matrix which is invertible.  The sub functions are:
	- *get* - Get the value of the matrix
 	- *set* - Set the value of the matrix
 	- *get_invert* - Get the inverse of the matrix
 	- *set_invert* - Set the inverse of the matrix

2.  **cacheSolve** which computes the inverse of the cached matrix created by **makeCacheMatrix**. If the inverse matrix has already been computed and cached without change; subsequent use returns the cached result rather than a re-calculation.  Note: usage does not test for change in the matrix.  The user signals the change through use of the *set* function of **makeCacheMatrix**, which then results in a new inverse matrix calculation.  Example usage *cachedmatrixvar$set(new_A)*, where new_A is your new square matrix that you want to invert.
    
## Usage

The following steps would be a typical use of these functions:

```
> source('cachematrix.R')

# Load some matrix A in the Global Environment
> A <- matrix( c(5,  1,  0,
                 3, -1,  2,
                 4,  0, -1), nrow=3, byrow=TRUE)

# Initialize the cache matrix in the Global environment to hold the inverted matrix
> iA <- makeCacheMatrix(A)

# First use calculates the inverted matrix and caches the result
> cacheSolve(iA)
       [,1]    [,2]   [,3][1,] 0.0625  0.0625  0.125[2,] 0.6875 -0.3125 -0.625[3,] 0.2500  0.2500 -0.500

#  Subsequent use returns the cached result
> cacheSolve(iA) #after first use
Attn: Getting cached inverse matrix, use the $set function to refresh the matrix if required       [,1]    [,2]   [,3][1,] 0.0625  0.0625  0.125[2,] 0.6875 -0.3125 -0.625[3,] 0.2500  0.2500 -0.500

# If you change the matrix and need to refresh the cached inverse matrix result then use the $set 
# function created by ‘makeCacheMatrix’ to re-calculate the cached inverted matrix, such as:
> new_A <- matrix( c(9,  2,  1,                     5,  2,  3,                     6,  2,  0), nrow=3, byrow=TRUE) #new matrix to invert
> iA$set(new_A)  #use the $set function to cache a new inverted matrix
> cacheSolve(iA) #get your new result
     [,1] [,2] [,3][1,]  0.3 -0.1 -0.2[2,] -0.9  0.3  1.1[3,]  0.1  0.3 -0.4

#Call it again to get the cached result
> cacheSolve(iA)Attn: Getting cached inverse matrix, use the $set function to refresh the matrix if required     [,1] [,2] [,3][1,]  0.3 -0.1 -0.2[2,] -0.9  0.3  1.1[3,]  0.1  0.3 -0.4
> 
```
## End README