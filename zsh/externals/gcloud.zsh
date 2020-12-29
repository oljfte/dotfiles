# External sources
source $HOME/google-cloud-sdk/path.zsh.inc
source $HOME/google-cloud-sdk/completion.zsh.inc

# Functions
function update-gcloud() {
    gcloud -q components update
}
