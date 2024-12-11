FROM golang:1.23.4

RUN apt-get update && apt-get install -y \
    vim \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Update pip and install online-judge-tools
RUN pip3 install --no-cache-dir -U pip --break-system-packages \
    && pip3 install --no-cache-dir online-judge-tools --break-system-packages

# Install atcoder-cli globally
RUN npm install -g atcoder-cli \
    && acc config default-test-dirname-format test \
    && acc config default-task-choice all

# Set up command aliases
RUN echo 'alias ojgo="oj t -c \"go run ./main.go\" -d test/"' >> ~/.bashrc \
    && echo 'alias addgo="cp /go/src/work/template.go ./main.go"' >> ~/.bashrc

# Enable Go modules
ENV GO111MODULE=on

WORKDIR /go/src/work

# Install Go development tools
RUN go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest \
    && go install github.com/ramya-rao-a/go-outline@latest \
    && go install github.com/nsf/gocode@latest \
    && go install github.com/acroca/go-symbols@latest \
    && go install github.com/fatih/gomodifytags@latest \
    && go install github.com/josharian/impl@latest \
    && go install github.com/haya14busa/goplay/cmd/goplay@latest \
    && go install github.com/go-delve/delve/cmd/dlv@latest \
    && go install golang.org/x/lint/golint@latest \
    && go install golang.org/x/tools/gopls@latest