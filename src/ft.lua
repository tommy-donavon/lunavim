vim.filetype.add {
  extension = {
    jq = 'jq',
    tmpl = 'gohtmltmpl',
    rasi = 'scss',
    envrc = 'bash',
    tera = 'tera',
    tf = 'terraform',
  },
  pattern = {
    ['flake.lock'] = 'json',
    ['.*%.blade%.php'] = 'blade',
  },
  filename = {
    ['.Justfile'] = 'just',
    ['.justfile'] = 'just',
    ['Justfile'] = 'just',
    ['justfile'] = 'just',
  },
}
