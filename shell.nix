#!/usr/bin/env nix-shell

{ pkgs ? import <nixpkgs> {} }:
	pkgs.mkShell {
		nativeBuildInputs = with pkgs.buildPackages; [
			pandoc
			#texlive.combined.scheme-full
			(texlive.combine {
				inherit (texlive) scheme-full; #isodate xcolor xstring;
			})
		];
	}
