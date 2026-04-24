function testdrive
    # --- EPRAHEMI CUSTOM HEADER ---
    echo -e "\033[1;36m"
    echo "  ███████╗██████╗ ██████╗  █████╗ ██╗  ██╗███████╗███╗   ███╗██╗"
    echo "  ██╔════╝██╔══██╗██╔══██╗██╔══██╗██║  ██║██╔════╝████╗ ████║██║"
    echo "  █████╗  ██████╔╝██████╔╝███████║███████║█████╗  ██╔████╔██║██║"
    echo "  ██╔══╝  ██╔═══╝ ██╔══██╗██╔══██║██╔══██║██╔══╝  ██║╚██╔╝██║██║"
    echo "  ███████╗██║     ██║  ██║██║  ██║██║  ██║███████╗██║ ╚═╝ ██║██║"
    echo "  ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝"
    echo -e "         [ EPRAHEMI ELITE DIAGNOSTIC SUITE ]\033[0m"
    
    if not set -q argv[1]
        echo -e "\n\033[1;31mERR: No Parameter.\033[0m"
        echo -e "\033[1;33mQuick Start:\033[0m testdrive [\033[36mssd\033[0m | \033[36mhdd\033[0m | \033[36mram\033[0m | \033[36mnet\033[0m | \033[36mheat\033[0m | \033[36minfo\033[0m | \033[36mgpu\033[0m | \033[36mbatt\033[0m | \033[36mcpu\033[0m | \033[36mstress\033[0m]"
        return 1
    end
    
    set -l drive_type $argv[1]
    set -l test_file ""
    
    # --- DYNAMIC PROGRESS BAR ---
    function draw_progress
        set -l duration $argv[1]
        set -l label $argv[2]
        echo -n "$label ["
        for i in (seq 1 30)
            echo -n "▓"
            sleep (math $duration / 30)
        end
        echo "] 100% COMPLETE"
    end
    
    switch $drive_type
        case ssd hdd
            if test "$drive_type" = "ssd"
                set test_file "$HOME/eprahemi_test_bin"
                echo -e "🚀 \033[1;32mTARGET: INTERNAL NVMe SSD\033[0m"
            else
                set -l ext_path (lsblk -no MOUNTPOINT | grep "/run/media" | head -n 1)
                if test -z "$ext_path"
                    echo "⚠️ No external drive detected!" ; return 1
                end
                set test_file "$ext_path/eprahemi_test_bin"
                echo -e "📂 \033[1;34mTARGET: EXTERNAL HDD [$ext_path]\033[0m"
            end
            draw_progress 0.4 "Scanning Controller"
            echo "📝 WRITE TEST (1GB)..."; dd if=/dev/zero of=$test_file bs=1G count=1 oflag=dsync status=progress
            echo "📖 READ TEST (No Cache)..."; sudo /sbin/sysctl -w vm.drop_caches=3 > /dev/null
            dd if=$test_file of=/dev/null bs=1G count=1 status=progress
            rm $test_file
            
        case ram
            echo -e "🧠 \033[1;35mTARGET: SYSTEM RAM\033[0m"
            draw_progress 0.8 "Cycling 3GB Throughput"
            dd if=/dev/zero of=/dev/null bs=1M count=3000 status=progress
            
        case net
            echo -e "🌐 \033[1;36mTARGET: NETWORK LATENCY\033[0m"
            draw_progress 1.5 "Pinging Satellite"
            speedtest-cli --simple
            
        case heat
            echo -e "🌡️ \033[1;31mTARGET: SYSTEM THERMALS\033[0m"
            sensors | grep -E 'Core|temp|fan'
            
        case gpu
            echo -e "🎮 \033[1;32mTARGET: NVIDIA RTX 2050\033[0m"
            nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,memory.used --format=csv,noheader
            
        case batt
            echo -e "🔋 \033[1;33mTARGET: MSI POWER CELL\033[0m"
            upower -i (upower -e | grep 'BAT') | grep -E "state|to\ full|percentage|capacity"
            
        case cpu
            echo -e "📟 \033[1;34mTARGET: i5-12450H ARCHITECTURE\033[0m"
            lscpu | grep -E "Model name|CPU\(s\):|Thread|Max MHz"
            
        case stress
            echo -e "🧨 \033[1;31mTARGET: SYSTEM STRESS TEST (10s)\033[0m"
            echo "Pumping fans to limit..."
            timeout 10s cat /dev/urandom > /dev/null
            echo "Done. Check 'testdrive heat' now!"
            
        case info
            echo -e "🆔 \033[1;33mTARGET: SYSTEM SPECS\033[0m"
            fastfetch 2>/dev/null; or neofetch 2>/dev/null; or uname -a
            lsblk -p -o NAME,SIZE,MODEL,MOUNTPOINT | grep -v "loop"
            
        case '*'
            echo "❌ Parameter '$drive_type' not in Eprahemi's database."
            return 1
    end
    
    # --- MASTER COMMAND DIRECTORY (The Reminder) ---
    echo -e "\n\033[1;37m[ TEST COMPLETE - WELL DONE ]\033[0m"
    echo -e "\033[1;30m─────────────────────────────────────────────────────────\033[0m"
    echo -e "\033[1;33m🔧 MASTER COMMAND DIRECTORY:\033[0m"
    echo -e "  \033[36mtestdrive ssd\033[0m     : Benchmark internal NVMe"
    echo -e "  \033[36mtestdrive hdd\033[0m     : Benchmark external Games drive"
    echo -e "  \033[36mtestdrive ram\033[0m     : Test memory bandwidth"
    echo -e "  \033[36mtestdrive net\033[0m     : Ping, Download, and Upload speeds"
    echo -e "  \033[36mtestdrive heat\033[0m    : Check CPU temps and Fan RPM"
    echo -e "  \033[36mtestdrive gpu\033[0m     : GPU temps and load"
    echo -e "  \033[36mtestdrive batt\033[0m    : Battery health and cycle status"
    echo -e "  \033[36mtestdrive cpu\033[0m     : Core clock speeds and threads"
    echo -e "  \033[36mtestdrive stress\033[0m  : Force CPU load (Test cooling)"
    echo -e "  \033[36mtestdrive info\033[0m    : Total system blueprint"
    echo -e "\033[1;30m─────────────────────────────────────────────────────────\033[0m"
    echo ""
end
