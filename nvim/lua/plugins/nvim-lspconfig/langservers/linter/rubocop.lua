return {
    lintCommand = "bundle exec rubocop --force-exclusion --stdin ${INPUT}",
    lintIgnoreExitCode = true,
    lintStdin = true,
    lintFormats = {
      "%f:%l:%c = %m"
    },
    rootMarkers = {
      "Gemfile",
      "Rakefile",
      ".rubocop.yml"
    },
}
