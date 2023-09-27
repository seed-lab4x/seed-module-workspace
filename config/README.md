
# config

This is the config of the workspace.


## content

The config directory contains customize configuration about the target host,
Such as ansible inventory paths, file storage paths, sensitive passwords or tokens.

The config directory structure convention level.

1. group level
2. host level

The __level 1__ is mainly used to group hosts,
such as named by physical location, named by logical function, or superimposing multiple dimensions.

The __level 2__ will be the host directory.
The host can be a single machine or a group of clusters.
You can name this folder using the host domain name.

like this:

```bash
.
├── home@dev
│   ├── vm
│   ├── switch
│   └── wsl.local
├── home@vm
│   ├── ubuntu123.lan
│   └── debian123.lan
├── work@dev
│   ├── router.lan
│   └── vc.lan
└── work@vm
    ├── ci.lan
    └── git.lan
```


## location

The config directory location is determined by the seed meta file [seed.json](./../seed.json).

like this:

```json
{
  "config": {
    "name": ".config",
    "url": "../seed-module-config.git",
    "path": ".config",
    "branch": "main",
    "customize": {
      "prompt": true
    }
  }
}
```

## usage

The config directory is obtained separately from the workspace through `git submodule`.

When running commands, scripts or playbooks to host, should be switched to __level 2__ folder.

