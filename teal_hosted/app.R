#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(teal.modules.clinical)

ADSL <- teal.modules.clinical::tmc_ex_adsl
ADAE <- teal.modules.clinical::tmc_ex_adae
ADTTE <- teal.modules.clinical::tmc_ex_adtte

app <- init(
  data = cdisc_data(
    cdisc_dataset("ADSL", ADSL, code = "ADSL <- teal.modules.clinical::tmc_ex_adsl"),
    cdisc_dataset("ADAE", ADAE, code = "ADAE <- teal.modules.clinical::tmc_ex_adae"),
    cdisc_dataset("ADTTE", ADTTE, code = "ADTTE <- teal.modules.clinical::tmc_ex_adtte")
  ),
  modules = modules(
    # module
    tm_t_summary(
      "Demographic Table",
      "ADSL",
      arm_var = choices_selected(
        choices = c("ARMCD", "ARM"),
        selected = "ARM"
      ),
      summarize_vars = choices_selected(
        choices = c("SEX", "RACE", "BMRKR2", "EOSDY", "DCSREAS", "AGE"),
        selected = c("SEX", "RACE")
      )
    ),
    tm_t_events(
      "Adverse Event Table",
      "ADAE",
      arm_var = choices_selected(
        choices = variable_choices(ADSL, c("ARMCD", "ARM")),
        selected = "ARM"
      ),
      llt = choices_selected(
        choices = variable_choices(ADAE, c("AETERM", "AEDECOD")),
        selected = "AEDECOD"
      ),
      hlt = choices_selected(
        choices = variable_choices(ADAE, c("AEBODSYS", "AESOC")),
        selected = "AEBODSYS"
      )
    ),
    tm_g_km(
      "KM PLot",
      "ADTTE",
      arm_var = choices_selected(
        choices = variable_choices(ADSL, c("ARMCD", "ARM")),
        selected = "ARM"
      ),
      paramcd = choices_selected(
        choices = value_choices(ADTTE, "PARAMCD", "PARAM"),
        selected = "OS"
      ),
      strata_var = choices_selected(
        choices = c("SEX", "BMRKR2"),
        selected = NULL
      ),
      facet_var = choices_selected(
        choices = c("SEX", "BMRKR2"),
        selected = NULL
      ),
      plot_height	= c(600L, 400L, 5000L)
    )
  ),
  header = "R/Pharma 2023 teal Workshop"
)

shinyApp(app$ui, app$server)
