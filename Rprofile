local({
  repos <- getOption("repos");

  # http://cran.r-project.org/
  # For a list of CRAN mirrors, see getCRANmirrors().
  # repos["CRAN"] <- "https://cran.microsoft.com";
  repos["CRAN"] <- "https://cloud.r-project.org/";

  # http://www.stats.ox.ac.uk/pub/RWin/ReadMe
  if (.Platform$OS.type == "windows") {
    repos["CRANextra"] <- "http://www.stats.ox.ac.uk/pub/RWin";
  }

  # http://r-forge.r-project.org/
  repos["R-Forge"] <- "http://R-Forge.R-project.org";

  # http://www.omegahat.org/
  repos["Omegahat"] <- "http://www.omegahat.org/R";

  options(repos=repos);
})
