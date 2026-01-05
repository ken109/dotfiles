#!/usr/bin/env bash

$env.config.show_banner = false

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

source $"($nu.home-path)/.cargo/env.nu"

$env.config = ($env.config | upsert hooks {
    env_change: {
        PWD: [
            { ||
                if (which direnv | is-empty) {
                    return
                }
                direnv export json | from json | default {} | load-env
            }
        ]
    }
})
