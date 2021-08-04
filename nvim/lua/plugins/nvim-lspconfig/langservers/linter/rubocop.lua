return {
  lintCommand = "bundle exec rubocop --format emacs --force-exclusion --stdin ${INPUT}",
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
  commands = {
    command = "bundle exec rubocop --auto-correct-all ${INPUT}",
    title = "rubocop fix"
  }
}
