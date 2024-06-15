function ghcs --wraps "gh copilot suggest"
    set -f TARGET "shell"
    set -f GH_DEBUG $GH_DEBUG
    set -f GH_HOST $GH_HOST

    argparse "d/debug" "h/help" "hostname=" "t/target=" -- $argv

    if test -n "$_flag_debug"
        set -f GH_DEBUG api
    end

    if test -n "$_flag_help"
        set -l FUNCNAME (status current-command)
        set -l __USAGE "Wrapper around `gh copilot suggest` to suggest a command based on a natural language description of the desired output effort.
Supports executing suggested commands if applicable.

USAGE
  $FUNCNAME [flags] <prompt>

FLAGS
  -d, --debug              Enable debugging
  -h, --help               Display help usage
      --hostname           The GitHub host to use for authentication
  -t, --target target      Target for suggestion; must be shell, gh, git
                           default: \"$TARGET\"

EXAMPLES

- Guided experience
  \$ $FUNCNAME

- Git use cases
  \$ $FUNCNAME -t git \"Undo the most recent local commits\"
  \$ $FUNCNAME -t git \"Clean up local branches\"
  \$ $FUNCNAME -t git \"Setup LFS for images\"

- Working with the GitHub CLI in the terminal
  \$ $FUNCNAME -t gh \"Create pull request\"
  \$ $FUNCNAME -t gh \"List pull requests waiting for my review\"
  \$ $FUNCNAME -t gh \"Summarize work I have done in issues and pull requests for promotion\"

- General use cases
  \$ $FUNCNAME \"Kill processes holding onto deleted files\"
  \$ $FUNCNAME \"Test whether there are SSL/TLS issues with github.com\"
  \$ $FUNCNAME \"Convert SVG to PNG and resize\"
  \$ $FUNCNAME :\"Convert MOV to animated PNG\"
"
        echo $__USAGE
        return 0
    end

    if test -n "$_flag_hostname"
        set -f GH_HOST $_flag_hostname
    end

    if test -n "$_flag_target"
        set -f TARGET $_flag_target
    end

    set -f TMPFILE (mktemp -t gh-copilotXXXXXX)
    if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$argv" --shell-out "$TMPFILE"
        if test -s "$TMPFILE"
            set -l FIXED_CMD (cat $TMPFILE)
            echo
            eval "$FIXED_CMD"
        end

        rm -f "$TMPFILE"
        return 0
    end

    rm -f "$TMPFILE"
    return 1
end

