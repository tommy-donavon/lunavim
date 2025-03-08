{
  vimUtils,
  version,
}:
vimUtils.buildVimPlugin {
  pname = "lunavim";
  inherit version;

  src = ../src;
  nvimSkipModule = [ "init" ];

  preInstall = ''
    mkdir -p $out/lua/lunavim
    cp -r . $out/lua/lunavim
  '';
}
