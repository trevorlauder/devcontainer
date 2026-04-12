# Base Development Environment (base)

Base devcontainer image layer

## Example Usage

```json
"features": {
    "ghcr.io/trevorlauder/devcontainers/base:1": {}
}
```

## Options

| Options Id     | Description                                                                           | Type   | Default Value    |
| -------------- | ------------------------------------------------------------------------------------- | ------ | ---------------- |
| timezone       | Container timezone                                                                    | string | America/Edmonton |
| chezmoiVersion | chezmoi version to install                                                            | string | 2.70.0           |
| homeDirs       | Space-separated list of directories relative to $HOME to create as the container user | string | -                |

## Customizations

### VS Code Extensions

- `anthropic.claude-code`
- `eamodio.gitlens`
- `github.vscode-pull-request-github`
- `ms-azuretools.vscode-containers`
- `ms-python.python`

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/trevorlauder/devcontainers/blob/main/src/base/devcontainer-feature.json). Add additional notes to a `NOTES.md`._
