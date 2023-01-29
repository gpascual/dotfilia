eval $(ssh-agent -c) 2&> /dev/null

trap 'kill $SSH_AGENT_PID' EXIT

