## cgsimmons Helm Charts
Just a small collection of charts I have found helpful. Enjoy!

## Adding packages
- `helm create new-package`
- modify necessary chart yamls
- `helm lint new-package`
- add `helm package new-package -d ./docs` to `build.sh`
- run `build.sh`
