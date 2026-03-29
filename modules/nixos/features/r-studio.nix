{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (rstudioWrapper.override {
      packages = with rPackages; [
        ggplot2
        dplyr
        tidyr
        readr
        swirl
        languageserver
      ];
    })
    pandoc
  ];
}
