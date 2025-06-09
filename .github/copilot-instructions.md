This is a JASP module that contains a QML user-facing interface and R files responsible for the back-end computations.

The QML interface contains `Analyses` defined in the `inst/Descriptions/` directory. Each analysis links to the GUI defined in the `inst/qml/` directory and the R functions defined in the `R/` directory.

The QML interface defines a list of options that are passed to the R functions via the `options` argument.

The QML interface type-checks the `options` argument to ensure that the required options are present and have valid values. If any required option is missing or has an invalid value, the analysis will not run, and an error message will be displayed to the user.

Since the `options` argument is checked in the GUI, the R functions should not need to check the validity of the user input (the main exceptions are `TextField` and `FormulaField`, which can contain arbitrary text input).

The QML interface uses custom QML elements implemented in jasp-desktop (https://github.com/jasp-stats/jasp-desktop/).

Use the custom JASP QML elements wherever possible. See https://github.com/jasp-stats/jasp-desktop/blob/development/Docs/development/r-analyses-guide.md for more information on how to use the custom QML elements.

Use the existing QML files as examples for QML structure and style.

A QML element's `title`/`label` property is user-facing and should be concise and descriptive.

A QML element's `name` property is internal and should correspond to the `title`/`label` property translated into camelCase, inheriting prefixes from the hierarchy of the QML elements.

QML elements should be organized in a way that reflects the logical structure of the user interface, grouping related elements together.

QML elements should be documented using the `info` property. Document the elements in simple, non-technical, and accessible language.

Follow the JASP style guide for naming conventions summarized at https://github.com/jasp-stats/jasp-desktop/blob/development/Docs/development/guide-option-names.md#use-camelcase.

The R files should follow CRAN guidelines for code, documentation, and package structure.

R scripts should be organized in a way that reflects the logical structure of the analyses, grouping related functions together.

R functions common to multiple analyses should be placed in a common R file (there are multiple common files depending on whether the functions are common to all analyses or only a subset of analyses).

R files should always use camelCase for function and variable names throughout the codebase.

R files should follow the R-guidelines summarized at https://github.com/jasp-stats/jasp-desktop/blob/development/Docs/development/r-style-guide.md.

Never use `library()` or `require()` in the R files. Use the `package::function()` syntax to avoid conflicts.

Avoid adding dependencies unless absolutely necessary. If a simple R function would require a new dependency, re-implement the function without the dependency and acknowledge the source of the original function in a comment.

The `tests` directory contains unit tests for the R functions. The unit tests are run via the `jaspTools::testAll()` function.

Never add or delete unit tests.

Make sure that existing unit tests always pass before submitting a pull request.

If you add a new QML option, you might need to add the default value to the `options` list in the corresponding unit tests.

Avoid using non-CRAN dependencies to maintain CRAN compliance.