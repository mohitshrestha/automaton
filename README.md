# automaton

Task Automation Tools/Scripts Built in R

## Installing from GitHub

While CRAN is still by far the most popular repository for R packages, you will find quite a lot of packages that are only available from [GitHub](https://github.com/). Furthermore, if you'd liked to try out the latest development versions of the `{automaton}` package you will have to install them from GitHub.

Before you can install any package from GitHub, you need to install the `{remotes}` package from CRAN.

```         
install.packages("remotes")
```

Now you can install any package from GitHub by providing `"username/repository"` as argument to `remotes::install_github()`. For example, to install the latest development version of {automaton} from GitHub run this command.

```         
remotes::install_github("mohitshrestha/automaton")
```

Please note that installing a package from GitHub means that you have to install it from source. This requires a proper development environment including (at the minimum) a C and FORTRAN compiler. On Linux and macOS that's a given but on Windows it's not. More on that below where I discuss the difference between installing binaries vs. installing from source.

Copyright (c) 2022 <strong>`Mohit Shrestha, MSBA`</strong>
