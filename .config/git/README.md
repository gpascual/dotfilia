# Git

These document explains how Git is configured by using this dotfiles project.

## Custom global configuration

In order to customize your global configurations, write down or move your global configs to a new file located in`~/.config/git/conf.d/user`.

An example of this file's contents:
```ini
; ~/.config/git/conf.d/user
[user]
	name = Jane Doe
	email = jane.doe@some.email.org
```

## Workspaces-specific configurations

Sometimes it's useful to use different git configurations.

Let's put that you work for a company and you also maintain a couple of open sourced projects.

Maybe you need to use different user configs, one for your company email and another one with your personal contact info.

Given this context, you could have these Git config files.

**~/.config/git/conf.d/user**

The one described in the previous example is ok for this.

*~/.config/git/conf.d/workspaces*

This file contains all `includeIf.*.path` necessary directives.

```ini
; ~/.config/git/conf.d/workspaces
[includeIf "gitdir:~/workspaces/some-awesome-unicorn-startup/"]
        path = ~/workspaces/some-awesome-unicorn-startup/.gitconfig
```

**~/workspaces/some-awesome-unicorn-startup/.gitconfig**

A workspace-specific `.gitconfig`.

```ini
; ~/workspaces/some-awesome-unicorn-startup/.gitconfig
[user]
	name = Jane M. Doe
	email = jane.marie.doe@some-awesome-unicorn-startup.com
```

To sum up, in order to add another workspace, you just need to add an `includeIf.gitdir.path` directive inside `~/.config/git/conf.d/workspaces` and a specific workspace `.gitconfig` inside the workspace's directory.

And that's it, this way you can define all workspaces you could possibly need.

## Final thoughts

If you forked this project into a private one of your own, then you can commit the files you just created to keep them forever.

