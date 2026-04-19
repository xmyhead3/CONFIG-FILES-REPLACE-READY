function clean --wraps='sudo dnf clean all && sudo dnf autoremove -y' --description 'alias clean=sudo dnf clean all && sudo dnf autoremove -y'
    sudo dnf clean all && sudo dnf autoremove -y $argv
end
