---@type vim.lsp.Config
return {
	cmd = { 'yaml-language-server', '--stdio' },
	filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
	settings = {
		-- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
		redhat = { telemetry = { enabled = false } },
		yaml = {
			schemaStore = {
				url = 'https://www.schemastore.org/api/json/catalog.json',
				enable = true,
			},
			schemas = {
				kubernetes = '*.yaml',
				['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
				['https://atmos.tools/schemas/atmos/atmos-manifest/1.0/atmos-manifest.json'] = 'stacks/**/*.{yml,yaml}',
				['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
				['http://json.schemastore.org/ansible-stable-2.9'] = 'roles/tasks/*.{yml,yaml}',
				['http://json.schemastore.org/circleciconfig'] = '.circleci/config.{yml,yaml}',
				['http://json.schemastore.org/chart'] = 'Chart.{yml,yaml}',
				['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
				['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose.{yml,yaml}',
				['https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json'] = '*flow*.{yml,yaml}',
			},
		},
	},
}
