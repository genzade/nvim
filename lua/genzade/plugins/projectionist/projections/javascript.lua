local multiline_str = require('genzade.core.utils').sanitize_str

M = {}

M.javascript_generic = {
  ['src/*.js'] = {
    alternate = 'test/{}.test.js',
    type = 'source',
  },
  ['test/*.test.js'] = {
    alternate = 'src/{}.js',
    type = 'test',
    template = {
      multiline_str([[
      describe('{camelcase|capitalize|colons}', () => {,
        it('does something', () => {,
          expect(true).toBe(false),
        }),
      })]]),
    },
  },
}

return M
