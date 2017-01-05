# spdlog-adapter
An adapter repository to plug the spdlog header-only logging library library into the NJOY21 build system

## Git Subtree
This repository uses a git subtree for the directory `src`. The remote from which the subtree is made is located at [https://github.com/gabime/spdlog.git](https://github.com/gabime/spdlog.git). Equivalently, you can use the ssh location at `https://github.com/gabime/spdlog.git`

To facilitate updating the subtree when it gets updated upstream, do the following:

```bash
# This only needs to be done once
git remote add spdlog https://github.com/gabime/spdlog.git

# Do this when you need to update the subtree
git subtree pull --prefix=src spdlog master
```

# License
The code contained in this repository is covered by the license contained in the [LICENSE}(LICENSE) file.
