setup:
	@echo "Linking config files"
	@bash link.sh
	@echo "Configuring packages:"
	@echo "- Git"
	@bash git.sh
