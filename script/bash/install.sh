#!/bin/bash
to_install=($(ls $HOME/Repo/.dotfile/config))

for i in "${to_install[@]}";
do
	ln -s $HOME/Repo/.dotfile/config/$i .config/
done

ln -s $HOME/Repo/.dotfile/script/bash Script/
ln -s $HOME/Repo/.dotfile/image/wallpaper Image/
