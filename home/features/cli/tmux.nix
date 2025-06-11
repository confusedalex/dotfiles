{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    mouse = true;
    shortcut = "Space";
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      continuum
      resurrect
      sensible
      vim-tmux-navigator
      yank
    ];
    extraConfig = ''
      resurrect_dir="$HOME/.tmux/resurrect"
      set -g @resurrect-dir $resurrect_dir

      # Automatically restore session
      set -g @continuum-restore 'on'

      # Restore vim session
      set -g @resurrect-strategy-nvim 'session'

      # Use Alt-arrow keys without prefix key to switch panes
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Shift arrow to switch windows
      bind -n S-Left  previous-window
      bind -n S-Right next-window

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # open panes/windows in same path
      unbind '"'
      unbind %
      bind - split-window -v -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };

  home.persistence."/persist/home/alex/".directories = [
    ".tmux"
  ];
}
