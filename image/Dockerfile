FROM quay.io/jupyter/scipy-notebook:latest

USER root

# --- Install GitHub CLI (gh) + a few useful base tools ---
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates gnupg git openssh-client nano && \
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
      | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
      > /etc/apt/sources.list.d/github-cli.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends gh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY starter /opt/jupyter-starter
RUN chmod -R a+rX /opt/jupyter-starter && fix-permissions /opt/jupyter-starter

USER jovyan
WORKDIR /home/jovyan


