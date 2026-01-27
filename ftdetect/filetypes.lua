vim.filetype.add({
  extension = {
    env = 'config',
    var = 'config',
  },
  filename = {
    ['.env'] = 'config',
    ['.env.sample'] = 'config',
    -- Set up for docker_compose_language_service, this lsp should only be
    -- for docker-compose files
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
  },
  pattern = {
    ['.*/etc/default/.*'] = 'config',
    -- Borrowed from LazyVim. Mark huge files to disable features later.
    ['.*'] = function(path, bufnr)
      return vim.bo[bufnr]
          and vim.bo[bufnr].filetype ~= 'bigfile'
          and path
          and vim.fn.getfsize(path) > (1024 * 500) -- 500 KB
          and 'bigfile'
        or nil
    end,
  },
})
