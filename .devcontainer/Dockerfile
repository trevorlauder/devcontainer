# syntax=docker/dockerfile:1
FROM mcr.microsoft.com/devcontainers/base:ubuntu26.04@sha256:1d830c67a2da5d42e2d43562abd0099f27f1be37afe9ec236c4ae3fc54d06d28

USER root

ENV _REMOTE_USER=devcontainer

ENV TZ=UTC \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    SHELL=/usr/bin/zsh \
    EDITOR=vi \
    VISUAL=vi \
    DISABLE_FEEDBACK_COMMAND=1 \
    DISABLE_ERROR_REPORTING=1 \
    DISABLE_TELEMETRY=1 \
    CLAUDE_CONFIG_DIR=/home/devcontainer/.claude

# homebrew
ENV HOMEBREW_NO_ANALYTICS=1 \
    HOMEBREW_NO_ENV_HINTS=1 \
    HOMEBREW_PREFIX=/home/linuxbrew/.linuxbrew \
    HOMEBREW_CELLAR=/home/linuxbrew/.linuxbrew/Cellar \
    HOMEBREW_REPOSITORY=/home/linuxbrew/.linuxbrew/Homebrew \
    PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH} \
    MANPATH=/home/linuxbrew/.linuxbrew/share/man: \
    INFOPATH=/home/linuxbrew/.linuxbrew/share/info:

RUN --mount=type=bind,source=.,target=/build \
    --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=cache,target=/var/cache/mise,uid=1000,gid=1000 \
    /build/install.sh

RUN --mount=type=bind,source=homebrew,target=/build/homebrew \
    /build/homebrew/install.sh

USER devcontainer
