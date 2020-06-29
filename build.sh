helm package pypi-server -d ./docs
helm repo index ./docs --merge ./docs/index.yaml
