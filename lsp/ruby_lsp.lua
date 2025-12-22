return {
  cmd = { './bin/bundle', 'exec', 'ruby-lsp' },
  filetypes = { 'ruby', 'eruby', 'rakefile' },
  root_markers = { 'Gemfile', '.git' },
  init_options = {
    formatter = 'auto',
  },
  settings = {},
}
