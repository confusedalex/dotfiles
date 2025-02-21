{ lib, pkgs, ... }:
{
  stylix.targets.helix.enable = false;

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      bash-language-server
      biome
      docker-compose-language-service
      eslint
      golangci-lint
      golangci-lint-langserver
      gopls
      gotools
      kotlin-language-server
      marksman
      nil
      nixd
      nixpkgs-fmt
      nodePackages.prettier
      python312Packages.python-lsp-server
      tailwindcss-language-server
      typescript
      typescript-language-server
      vscode-langservers-extracted
      yaml-language-server
    ];
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        line-number = "relative";
        bufferline = "multiple";
        color-modes = true;
        cursorline = true;
        auto-save = true;
        auto-format = true;
        end-of-line-diagnostics = "hint";
        popup-border = "popup";

        lsp = {
          display-messages = true;
        };

        indent-guides = {
          character = "┊";
          render = true;
          skip-levels = 1;
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
      keys = {
        normal = {
          space.space = "file_picker";
          space.l = ":toggle lsp.display-inlay-hints";
          ret = "goto_word";
          space."=" = ":fmt";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
        insert = {
          C-space = "completion";
        };
      };
    };
    languages.language-server = {
      nixd = {
        command = "nixd";
        config = {
          nixpkgs.expr = "import <nixpkgs> { }";
          options = {
            nixos = {
              expr = ''(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.work.options'';
            };
          };
        };
      };
    };
    languages.language = [
      {
        name = "bash";
        auto-format = false;
        language-servers = [
          "bash-language-server"
        ];
      }
      {
        name = "python";
        file-types = [ "py" ];
        roots = [
          "pyproject.toml"
          "setup.py"
          "poetry.lock"
          "pyrightconfig.json"
        ];
        language-servers = [
          "pylsp"
        ];
      }
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
        language-servers = [
          "nixd"
          "nil"
        ];
      }
      {
        name = "go";
        language-servers = [
          "gopls"
          "golangci-lint-lsp"
        ];
        formatter = {
          command = "goimports";
        };
        auto-format = true;
      }
      {
        name = "html";
        language-servers = [
          "vscode-html-language-server"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.html"
          ];
        };
        auto-format = true;
      }
      {
        name = "markdown";
        language-servers = [
          "marksman"
        ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.md"
          ];
        };
        auto-format = true;
      }
      {
        name = "tsx";
        language-servers = [
          {
            name = "typescript-language-server";
            except-features = [ "format" ];
          }
          "biome"
          "eslint"
          "tailwindcss-language-server"
        ];
        formatter = {
          command = "biome";
          args = [
            "format"
            "--indent-style"
            "space"
            "--stdin-file-path"
            "file.tsx"
          ];
        };
        auto-format = true;
      }
      {
        name = "typescript";
        language-servers = [
          {
            name = "typescript-language-server";
            except-features = [ "format" ];
          }
          "biome"
          "eslint"
        ];
        formatter = {
          command = "biome";
          args = [
            "format"
            "--indent-style"
            "space"
            "--stdin-file-path"
            "file.ts"
          ];
        };
        auto-format = true;
      }
      {
        name = "javascript";
        language-servers = [
          "typescript-language-server"
          "eslint"
        ];
      }
      {
        name = "yaml";
        language-servers = [ "yaml-language-server" ];
        formatter = {
          command = "prettier";
          args = [
            "--stdin-filepath"
            "file.yaml"
          ];
        };
        auto-format = true;
      }
      {
        name = "rust";
        auto-format = true;
      }

    ];
  };
}
