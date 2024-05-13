----Surround
local ok, nvim_surround = pcall(require, 'nvim-surround')
if not ok then
  return
end

---@diagnostic disable-next-line: missing-fields
nvim_surround.buffer_setup({
  surrounds = {
    ---@diagnostic disable-next-line: missing-fields
    ['='] = {
      add = { '<%= ', ' %>' },
      find = '<%%= .- %%>',
      delete = '^(<%%= )().-( %%>)()$',
    },
    ---@diagnostic disable-next-line: missing-fields
    ['#'] = {
      add = { '<%# ', ' %>' },
      find = '<%%# .- %%>',
      delete = '^(<%%# )().-( %%>)()$',
    },
    ---@diagnostic disable-next-line: missing-fields
    ['-'] = {
      add = { '<% ', ' %>' },
      find = '<%% .- %%>',
      delete = '^(<%% )().-( %%>)()$',
    },
  },
})
