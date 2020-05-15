# docker shortcuts
dkstop () {
  docker ps -q | xargs -r docker stop
}

alias dkrm="dkstop; docker ps -aq | xargs -r docker rm"
alias dkex="docker exec -it"
alias dklo="docker logs -f"

# docker-compose shortcuts
alias dcup="docker-compose up -d"
alias dcupb="docker-compose up -d --build"
alias dcdown="docker-compose down"
alias dclo="docker-compose logs -f"

