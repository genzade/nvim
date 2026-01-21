return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = { '*', css = { rgb_fn = true } },
}
