{
  vimUtils,
  yue,
  version,
}:
vimUtils.buildVimPlugin {
  pname = "lunavim";
  inherit version;
  src = ../src;
  buildInputs = [ yue ];

  preInstall = ''
    mkdir -p $out/lua/lunavim
    yue -m -t $out/lua/lunavim .
    cp -r assets $out/lua/lunavim
  '';
}
