###
#Matlab and R mixture use
###

#Mixture of gaussian
x <- n <- numeric(length(10000))
n <- runif(1000)
x[n > 0.2] <- rnorm(length(n[n>0.2]), mean = -0.1, sd = 1) 
x[n < 0.2] <- rnorm(length(n[n<0.2]), mean = -0.2, sd = 3) 
quantile(x, probs = seq(0, 1, 0.05)) #quantile(x, 0.95)
mean(x[x>2.4157])
