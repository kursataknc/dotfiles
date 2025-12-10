# ==============================================================================
# NUSHELL ENVIRONMENT CONFIG
# ==============================================================================
# version = "0.95.0"
#
# This file is loaded BEFORE config.nu and defines:
#   - Environment variables (EDITOR, VISUAL, etc.)
#   - PATH configuration
#   - Library and plugin directories
#
# Note: Prompt configuration is handled by Starship (loaded in config.nu)
#
# Structure:
#   1. Library & Plugin Directories
#   2. Environment Variables
#   3. PATH Configuration

# ==============================================================================
# 1. LIBRARY & PLUGIN DIRECTORIES
# ==============================================================================
# Directories where Nushell looks for scripts, completions, and plugins

$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')       # ~/.config/nushell/scripts
    ($nu.data-dir | path join 'completions')             # ~/.local/share/nushell/completions
]

$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')       # ~/.config/nushell/plugins
]

# ==============================================================================
# 2. ENVIRONMENT VARIABLES
# ==============================================================================

# Editor configuration
$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

# Prompt (Starship)
$env.STARSHIP_CONFIG = ($env.HOME | path join ".config" "starship.toml")

# Additional environment variables
$env.PYENV_ROOT = ($env.HOME | path join ".pyenv")

# Uncomment as needed:
# $env.GOPATH = ($env.HOME | path join "go")
# $env.KUBECONFIG = ($env.HOME | path join ".kube" "config")
# $env.NIX_CONF_DIR = ($env.HOME | path join ".config" "nix")

# ==============================================================================
# 3. PATH CONFIGURATION
# ==============================================================================
# Priority order: items at the top take precedence

$env.PATH = ($env.PATH | split row (char esep) | prepend [
    ($env.HOME | path join ".pyenv" "shims")             # Pyenv shims (highest priority)
    ($env.HOME | path join ".pyenv" "bin")               # Pyenv binaries
] | append [
    "/opt/homebrew/bin"                                  # Homebrew binaries
    "/opt/homebrew/sbin"                                 # Homebrew system binaries
    "/usr/local/bin"                                     # Local binaries
    "/run/current-system/sw/bin"                         # Nix binaries
    ($env.HOME | path join ".local" "bin")               # User local binaries
    ($env.HOME | path join ".cargo" "bin")               # Rust/Cargo binaries
    # ($env.HOME | path join "go" "bin")                 # Go binaries
] | uniq)
