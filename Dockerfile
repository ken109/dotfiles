FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Minimal dependencies for install.sh to start (curl/wget/git)
# We also install sudo because script/setup uses it.
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    make \
    build-essential \
    locales \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Generate locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Create a test user
RUN useradd -m -s /bin/bash testuser && \
    echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER testuser
WORKDIR /home/testuser

# Setup mock remote repository
# To test install.sh which clones from github, we can init a bare repo locally
# and override DOTFILES_GITHUB variable in install.sh or via env.
# However, mapping the local directory as a volume or copying it is easier.
# Let's copy the current directory to /tmp/dotfiles.git to simulate a remote.

COPY --chown=testuser:testuser . /tmp/dotfiles-repo

# Initialize git repo in /tmp/dotfiles-repo to allow cloning
RUN cd /tmp/dotfiles-repo && \
    git config --global user.email "you@example.com" && \
    git config --global user.name "Your Name" && \
    git init && \
    git add . && \
    git commit -m "Initial commit"

# Set environment variable to point to local repo
ENV DOTFILES_GITHUB="/tmp/dotfiles-repo"

# Run install.sh
# We pipe it to bash to simulate 'curl | bash' style execution,
# or run directly. install.sh expects to clone the repo.
RUN bash /tmp/dotfiles-repo/script/install.sh

# Set zsh as default entrypoint to verify configuration
CMD ["/home/linuxbrew/.linuxbrew/bin/zellij"]
