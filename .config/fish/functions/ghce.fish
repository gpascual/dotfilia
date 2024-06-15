function ghce --wraps "gh copilot explain"
    set -f GH_DEBUG $GH_DEBUG
    set -f GH_HOST $GH_HOST

    argparse "d/debug" "h/help" "hostname=" -- $argv

    if test -n "$_flag_debug"
        set -f GH_DEBUG api
    end

    if test -n "$_flag_help"
        set -l FUNCNAME (status current-command)
        set -l __USAGE "Wrapper around `gh copilot explain` to explain a given input command in natural language.

USAGE
  $FUNCNAME [flags] <command>

FLAGS
  -d, --debug      Enable debugging
  -h, --help       Display help usage
      --hostname   The GitHub host to use for authentication

EXAMPLES

# View disk usage, sorted by size
\$ $FUNCNAME 'du -sh | sort -h'

# View git repository history as text graphical representation
\$ $FUNCNAME 'git log --oneline --graph --decorate --all'

# Remove binary objects larger than 50 megabytes from git history
\$ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
"
        echo $__USAGE
        return 0
    end

    if test -n "$_flag_hostname"
        set -f GH_HOST $_flag_hostname
    end

    GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain "$argv"
end

