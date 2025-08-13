[private]
default:
    @just --list

# analyze lua code
[group('dev')]
check:
    @luacheck --globals vim -- nvim

# lint and apply possible fixes to lua code
[group('dev')]
lint-fix *args:
    @stylua nvim {{ args }}

# lint lua code
[group('dev')]
lint: (lint-fix "--check")

# add required or optional plugins via npins
[group('dev')]
add-plugin vcs required repo *ref:
    #!/usr/bin/env sh        
    vcs={{ vcs }}
    repo={{ repo }}
    required={{ required }}
    ref={{ ref }}

    # Validate VCS system
    if [[ ! "$vcs" =~ ^(github|gitlab|bitbucket)$ ]]; then
      echo "Error: Unknown VCS system '$vcs'"
      echo "Known VCS systems: github, gitlab, bitbucket"
      exit 1
    fi

    # Determine lock file based on required flag
    if [ "${required,,}" = "true" ]; then
      lock_file="required"
    else
      lock_file="optional"
    fi

    # Split repo into owner and repo_name
    IFS="/" read -r owner repo_name <<< "$repo"

    # Build and execute command
    ref_param=""
    [ -n "$ref" ] && ref_param="--branch $ref"
    echo "Adding plugin: $vcs/$owner/$repo_name (required: $required, ref: $ref)"
    npins --lock-file "npins/${lock_file}.json" add "$vcs" "$owner" "$repo_name" $ref_param
