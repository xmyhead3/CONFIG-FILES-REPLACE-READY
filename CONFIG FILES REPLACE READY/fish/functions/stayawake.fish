function stayawake
    set -l current_user (whoami | tr '[:lower:]' '[:upper:]')
    set -l machine_name (hostname)
    set -l author "EPRAHEMI"
    set -l copyright "© 2026 $author"

    clear
    echo -e "\033[1;36mInitializing Sentinel Protocol...\033[0m"
    for i in (seq 1 5)
        echo -n -e "\033[1;34m⚡ OPTIMIZING AURA [ "
        for j in (seq 1 $i); echo -n "▓"; end
        for k in (seq $i 4); echo -n " "; end
        echo -n " ]\r"
        sleep 0.1
    end
    echo -e "\n\033[1;32m✅ SYSTEM DE-RUSTED | CREATED BY $author\033[0m"
    sleep 0.2

    echo -e "\033[1;35m"
    echo "  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗     "
    echo "  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║     "
    echo "  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║     "
    echo "  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║     "
    echo "  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗"
    echo "  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝"
    echo -e "             [ SECURITY LEVEL: SIGMA OVERRIDE ]\033[0m"
    echo -e "             \033[1;30m$copyright | Unauthorized sleep is beta behavior\033[0m"

    echo -e "\033[1;30m╔══════════════════════════════════════════════════════════════════╗\033[0m"
    printf "  \033[1;32mOPERATOR:\033[0m  %-20s \033[1;34mNODE:\033[0m %-20s \n" $current_user $machine_name
    echo -e "  \033[1;32mSTATUS:  \033[0m  LID-SLEEP/LOCK: \033[1;31mDISABLED\033[0m | \033[1;36mMODE:\033[0m MOGGING"
    echo -e "  \033[1;31mTERMINATE:\033[0m Press \033[1;37m[CTRL+C]\033[0m to restore mid security"
    echo -e "\033[1;30m╚══════════════════════════════════════════════════════════════════╝\033[0m"

    if command -v gsettings > /dev/null
        gsettings set org.gnome.desktop.screensaver lock-enabled false
    end

    systemd-inhibit --what=handle-lid-switch:idle:sleep --why="Sentinel Prime Active for $current_user" sleep 1d &
    set -l pid $last_pid

    function cleanup --on-signal SIGINT --inherit-variable pid --inherit-variable current_user --inherit-variable author
        echo -e "\n\n\033[1;31m🚨 SESSION ENDED | L + RATIO + BACK TO SLEEP...\033[0m"
        if command -v gsettings > /dev/null
            gsettings set org.gnome.desktop.screensaver lock-enabled true
        end
        kill $pid 2>/dev/null
        echo -e "\033[1;32m🔒 SECURITY RE-ARMED. Goodbye, $current_user.\033[0m"
        functions -e cleanup
        return 0
    end

    set -l seconds 0
    while kill -0 $pid 2>/dev/null
        # FIXED MATH FOR FISH SHELL
        set -l hours (math -s0 "$seconds / 3600")
        set -l mins (math -s0 "($seconds % 3600) / 60")
        set -l secs (math -s0 "$seconds % 60")
        
        set -l color_state (math "$seconds % 4")
        switch $color_state
            case 0; set p_color (set_color cyan); set t_color "\033[1;36m"
            case 1; set p_color (set_color blue); set t_color "\033[1;34m"
            case 2; set p_color (set_color magenta); set t_color "\033[1;35m"
            case 3; set p_color (set_color white); set t_color "\033[1;37m"
        end
        
        set -l cpu_usage (top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
        set -l ram_usage (free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }')
        set -l batt (upower -i (upower -e | grep 'BAT') | grep "percentage" | awk '{print $2}')
        
        set -l audio_app "SILENT"
        if command -v pactl > /dev/null
            set -l app (pactl list sink-inputs | grep "application.name" | head -n 1 | cut -d'"' -f2)
            if test -n "$app"; set audio_app (echo $app | tr '[:lower:]' '[:upper:]'); end
        end

        set -l mic_stat "OFF"
        if pactl list sources | grep -A 10 "Source #" | grep -q "Mute: no"; set mic_stat "ON 🔥"; end

        set -l brain_rot "Mewing"
        if test $seconds -lt 300; set brain_rot "Alpha Build";
        else if test $seconds -lt 3600; set brain_rot "Sigma Grind";
        else; set brain_rot "Skibidi God"; end

        # Dashboard Top Row
        echo -e -n "\r\033[K\033[1;30m[\033[1;32mCPU: $cpu_usage%\033[1;30m] [\033[1;35mRAM: $ram_usage\033[1;30m] [\033[1;33mBATT: $batt\033[1;30m] [\033[1;36mAUDIO: $audio_app\033[1;30m] [\033[1;31mMIC: $mic_stat\033[1;30m]"
        
        # 24-HOUR PROGRESS BAR (86400s)
        set -l bar_progress (math -s0 "$seconds * 40 / 86400")
        if test $bar_progress -gt 40; set bar_progress 40; end
        
        set -l bar ""
        for i in (seq 1 40)
            if test $i -le $bar_progress; set bar "$bar█"; else; set bar "$bar░"; end
        end

        # Dashboard Bottom Row
        # Added \033[1A to keep the cursor on the same two lines without scrolling
        printf "\n\033[K %b 🕒 ACTIVE: %02dh %02dm %02ds \033[1;30m| \033[0m%b%s\033[0m \033[1;30m| \033[1;32m%s\033[0m\033[1A" $t_color $hours $mins $secs $p_color $bar $brain_rot
        
        sleep 1
        set seconds (math "$seconds + 1")
    end
end
