% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/acs.R
\name{get_acs}
\alias{get_acs}
\title{Obtain data and feature geometry for the five-year American Community Survey}
\usage{
get_acs(geography, variables, endyear = 2015, output = "tidy",
  state = NULL, county = NULL, geometry = FALSE, keep_geo_vars = FALSE,
  summary_var = NULL, key = NULL, moe_level = 90, ...)
}
\arguments{
\item{geography}{The geography of your data.}

\item{variables}{Character string or vector of character strings of variable
IDs. tidycensus automatically returns the estimate and the
margin of error associated with the variable.}

\item{endyear}{The endyear of the ACS sample.  2010 through 2015 are
available. Defaults to 2015 (for 2011-2015)}

\item{output}{One of "tidy" (the default) in which each row represents an
enumeration unit-variable combination, or "wide" in which each
row represents an enumeration unit and the variables are in the
columns.}

\item{state}{The state for which you are requesting data. State
names, postal codes, and FIPS codes are accepted.
Defaults to NULL.}

\item{county}{The county for which you are requesting data. County names and
FIPS codes are accepted. Must be combined with a value supplied
to `state`.  Defaults to NULL.}

\item{geometry}{if FALSE (the default), return a regular tibble of ACS data.
if TRUE, uses the tigris package to return an sf tibble
with simple feature geometry in the `geometry` column.  state, county, tract, block group,
block, and ZCTA geometry are supported.}

\item{keep_geo_vars}{if TRUE, keeps all the variables from the Census
shapefile obtained by tigris.  Defaults to FALSE.}

\item{summary_var}{Character string of a "summary variable" from the ACS
to be included
in your output. Usually a variable (e.g. total population)
that you'll want to use as a denominator or comparison.}

\item{key}{Your Census API key.
Obtain one at \url{http://api.census.gov/data/key_signup.html}}

\item{moe_level}{The confidence level of the returned margin of error.  One of 90 (the default), 95, or 99.}

\item{...}{Other keyword arguments}
}
\value{
A tibble or sf tibble of ACS data
}
\description{
Obtain data and feature geometry for the five-year American Community Survey
}
\examples{
\dontrun{
library(tidycensus)
library(tidyverse)
library(viridis)
census_api_key("YOUR KEY GOES HERE")

tarr <- get_acs(geography = "tract", variables = "B19013_001",
                state = "TX", county = "Tarrant", geometry = TRUE)

ggplot(tarr, aes(fill = estimate, color = estimate)) +
  geom_sf() +
  coord_sf(crs = 26914) +
  scale_fill_viridis(option = "magma") +
  scale_color_viridis(options = "magma")


vt <- get_acs(geography = "county", variables = "B19013_001", state = "VT")

vt \%>\%
mutate(NAME = gsub(" County, Vermont", "", NAME)) \%>\%
 ggplot(aes(x = estimate, y = reorder(NAME, estimate))) +
  geom_errorbarh(aes(xmin = estimate - moe, xmax = estimate + moe)) +
  geom_point(color = "red", size = 3) +
  labs(title = "Household income by county in Vermont",
       subtitle = "2011-2015 American Community Survey",
       y = "",
       x = "ACS estimate (bars represent margin of error)")

}
}
