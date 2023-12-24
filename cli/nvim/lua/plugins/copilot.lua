return function()
  require('copilot').setup({
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = "<Right>",
      },
    },
  })
end
