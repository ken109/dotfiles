#!/usr/bin/env nu

$env.config.show_banner = false

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# cargo は setup で入れないため、存在するときだけ PATH に足す。
# nushell の source はパース時解決で if ガードできないので、ここでは source しない。
let cargo_bin = ($nu.home-dir | path join ".cargo" "bin")
if ($cargo_bin | path exists) {
    $env.PATH = ($env.PATH | prepend $cargo_bin)
}

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
