return {
	cmd = { 'pyright-langserver', '--stdio', '--lib', '--skipunannotated' },
	settings = {
		python = {
			analysis = {
				autoImportCompletions = true,
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "workspace",
				diagnosticSeverityOverrides = "none",
				-- typeCheckingMode = "off",
			}
		},
		pyright = {
			reportGeneralTypeIssues = "none",
			reportPropertyTypeMismatch = "info",
			reportFunctionMemberAccess = "info",
			reportMissingTypeStubs = "info",
			reportUnknownMemberType = "info",
			disableLanguageServices = false,
      		disableOrganizeImports = false,
		}
	}
}
