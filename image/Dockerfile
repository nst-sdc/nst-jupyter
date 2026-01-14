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

# --- Rename jovyan -> student (cleaner UX) ---
ARG NB_USER=student
ARG NB_UID=1000
ARG NB_GID=100

RUN usermod -l ${NB_USER} jovyan && \
    usermod -d /home/${NB_USER} -m ${NB_USER} && \
    fix-permissions /home/${NB_USER}

# --- Add a tiny starter notebook into the image (so it always exists) ---
# This avoids relying on git clone every time (home is ephemeral).
COPY starter /opt/jupyter-starter
RUN fix-permissions /opt/jupyter-starter

# --- Copy starter into home on every spawn (home is ephemeral, so this is fine) ---
COPY entrypoint.sh /usr/local/bin/nst-entrypoint.sh
RUN chmod +x /usr/local/bin/nst-entrypoint.sh

USER ${NB_USER}
WORKDIR /home/${NB_USER}

# IMPORTANT: keep the original start script behavior, but run our copy step first
ENTRYPOINT ["/usr/local/bin/nst-entrypoint.sh"]
CMD ["start-notebook.py"]