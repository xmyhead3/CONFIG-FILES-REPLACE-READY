function stayawake --description 'Keep laptop awake when lid is closed'
    echo "Lid-sleep inhibited. Press Ctrl+C to allow sleep again."
    systemd-inhibit --what=handle-lid-switch --why="Active" sleep 1d
end
