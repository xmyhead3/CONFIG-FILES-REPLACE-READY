function stayawake --description 'High-End System Guard: Universal Edition'
    # --- DYNAMIC USER DETECTION ---
    set -l current_user (whoami | tr '[:lower:]' '[:upper:]')
    set -l machine_name (hostname)

    # --- STARTUP ANIMATION (High-End Graphics) ---
    clear
    echo -e "\033[1;36mInitializing Sentinel Protocol...\033[0m"
    for i in (seq 1 3)
        echo -n -e "\033[1;34m⚡ SCANNING SYSTEM CORES [ "
        for j in (seq 1 $i); echo -n "▓"; end
        echo -n " ]\r"
        sleep 0.2
    end
    echo -e "\n\033[1;32m✅ SYSTEM VULNERABILITY: PATCHED\033[0m"
    sleep 0.3

    # --- MAIN HEADER ---
    echo -e "\033[1;35m"
    echo "  ███████╗███████╗███╗   ██╗████████╗██╗███╗   ██╗███████╗██╗     "
    echo "  ██╔════╝██╔════╝████╗  ██║╚══██╔══╝██║████╗  ██║██╔════╝██║     "
    echo "  ███████╗█████╗  ██╔██╗ ██║   ██║   ██║██╔██╗ ██║█████╗  ██║     "
    echo "  ╚════██║██╔══╝  ██║╚██╗██║   ██║   ██║██║╚██╗██║██╔══╝  ██║     "
    echo "  ███████║███████╗██║ ╚████║   ██║   ██║██║ ╚████║███████╗███████╗"
    echo "  ╚══════╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝"
    echo -e "             [ SECURITY LEVEL: MAXIMUM ACCESS ]\033[0m"

    # --- DYNAMIC HUD ---
    echo -e "\033[1;30m╔══════════════════════════════════════════════════════════════════╗\033[0m"
    printf "  \033[1;32mOPERATOR:\033[0m  %-20s \033[1;34mNODE:\033[0m %-20s \n" $current_user $machine_name
    echo -e "  \033[1;32mSTATUS:  \033[0m  LID-SLEEP INHIBITED (System Invincible)"
    echo -e "  \033[1;36mOBJECTIVE:\033[0m Secure background session for \033[1;37m$USER\033[0m"
    echo -e "  \033[1;31mTERMINATE:\033[0m Press \033[1;37m[CTRL+C]\033[0m to release lock"
    echo -e "\033[1;30m╚══════════════════════════════════════════════════════════════════╝\033[0m"

    # --- START INHIBITOR ---
    systemd-inhibit --what=handle-lid-switch --why="Sentinel Active: $current_user Session" sleep 1d &
    set -l pid $last_pid

    # --- CLEANUP TRAP ---
    function cleanup --on-signal SIGINT --inherit-variable pid --inherit-variable current_user
        echo -e "\n\n\033[1;31m🚨 WARNING: SENTINEL DISENGAGING...\033[0m"
        kill $pid 2>/dev/null
        echo -e "\033[1;32m🔓 LID-RESTRICTION LIFTED. Goodbye, $current_user.\033[0m"
        functions -e cleanup
        return 0
    end

    # --- LIVE HUD LOOP ---
    set -l seconds 0
    while kill -0 $pid 2>/dev/null
        set -l mins (math -s0 $seconds / 60)
        set -l secs (math -s0 $seconds % 60)
        
        # Dynamic Pulse colors
        set -l color_state (math $seconds % 4)
        switch $color_state
            case 0; set pulse_color (set_color cyan)
            case 1; set pulse_color (set_color blue)
            case 2; set pulse_color (set_color magenta)
            case 3; set pulse_color (set_color white)
        end
        
        # High-End Visual Output
        set -l cpu_load (uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
        printf "\r %s 🌀 [ GUARD ACTIVE ] \033[1;37mUPTIME:\033[0m %02dm %02ds | \033[1;34mCPU LOAD:\033[0m %s | \033[1;32mUSER:\033[0m %s \033[0m" $pulse_color $mins $secs $cpu_load $current_user
        
        sleep 1
        set seconds (math $seconds + 1)
    end
end
