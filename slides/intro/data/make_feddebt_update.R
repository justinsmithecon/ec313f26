# Extends the Finances of the Nation federal debt series (public_feddebt.csv,
# which ends at fiscal 2021-22) with recent years, using the same conventions
# FoN uses: date t = fiscal year ending March 31 of t; real dollars deflated by
# the calendar-year all-items CPI rebased to 2022 = 100; per capita uses the
# January 1 population estimate; percent of GDP uses calendar-year nominal GDP.
#
# Sources for the appended years:
#   Gross debt (total liabilities) and gross public debt charges:
#     Fiscal Reference Tables 2025, Tables 13 and 15 (Department of Finance).
#     Note FoN's gross-debt definition differs slightly from FRT total
#     liabilities (FoN is ~4% lower in the overlap years), so there is a small
#     definitional seam at 2022/2023 — flagged in the chart captions.
#   CPI (2002 = 100, annual average): Statistics Canada, Table 18-10-0005.
#   Population (January 1): Statistics Canada, Table 17-10-0009.
#   Nominal GDP (calendar year, $ millions): Statistics Canada via FRED
#     (NGDPXDCCAA); 2025 cross-checked against Spring Economic Update 2026.
#
# Output: feddebt_update.csv, bound onto the FoN data by the deck's chunks.

library(tidyverse)

cpi2022 <- 151.2
ext <- tribble(
  ~date, ~grossdebt, ~interest,   ~cpi, ~pop,      ~gdp,
  2022,  NA,         24487,       151.2, 38516137, 2864159,
  2023,  1925033,    34955,       157.1, 39566248, 2965201,
  2024,  2057782,    47273,       160.9, 40769890, 3108551,
  2025,  2182336,    53410,       164.3, 41528680, 3245257
)

rows <- ext %>%
  mutate(defl = cpi / cpi2022) %>%
  pivot_longer(c(grossdebt, interest), names_to = "series", values_to = "nom") %>%
  filter(!is.na(nom)) %>%
  mutate(item = if_else(series == "grossdebt", "Gross federal debt", "Interest on the debt")) %>%
  rowwise() %>%
  reframe(
    date = date, fiscalyear = as.character(date), item = item,
    itemid = NA_real_, normid = NA_real_,
    normalization = c("Nominal dollars (millions)", "Percent of GDP",
                      "Real dollars (millions)", "Real per capita dollars"),
    val = c(nom, nom / gdp * 100, nom / defl, nom / defl * 1e6 / pop)
  )

write_csv(rows, here::here("slides", "intro", "data", "feddebt_update.csv"))
