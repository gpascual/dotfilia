function nvm
  set -q NPM_CONFIG_PREFIX && echo "NPM_CONFIG_PREFFIX env variable is set, unset it please (`direnv help` may be useful)" || bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end

