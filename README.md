# lunavim

My personal overly complex neovim configuration packaged with nix

## Try it out

```bash
nix run github:tommy-donavon/lunavim
```

## Install

As mentioned before this is my personal config tailored to my workflow. If you want to apply any customizations I would recommend forking.

If you do want to use it as is
you may add it as a flake input and apply the outputted overlay

### Home Manager example

```nix
{
  inputs.lunavim.url = "github:tommy-donavon/lunavim";
  outputs = { nixpkgs,... }@inputs: {
    nixosConfigurations.yourSystem =  nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ config, pkgs, ...}: {
          # install the overlay
          nixpkgs.overlays = [ inputs.lunavim.overlays.default ];
        })
        ({ config, pkgs, ... }: {
          home-manager.users.yourHome = hm: {
            home.packages = with pkgs; [ lunavim ];
          };
        })
      ];
    };
  };
}
```

> [!NOTE]
> `lunavim` is a wrapped distribution of neovim.
> once installed it can be invoked with the regular `nvim` command

Thanks to [Gerg-L](github.com/Greg-L) for their fantastic work on [mnw](https://github.com/Gerg-L/mnw) which made wrapping my existing configuration a breeze
