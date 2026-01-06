vim.filetype.add({
  extension = {
    env = 'config',
    var = 'config',
  },
  filename = {
    ['.env'] = 'config',
    -- Set up for docker_compose_language_service, this lsp should only be
    -- for docker-compose files
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
  },
  pattern = {
    ['.*/etc/default/.*'] = 'config',
  },
})
