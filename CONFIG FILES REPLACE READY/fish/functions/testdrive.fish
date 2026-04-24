function testdrive
    # --- EPRAHEMI CUSTOM HEADER ---
    echo -e "\033[1;36m"
    echo "  ███████╗██████╗ ██████╗  █████╗ ██╗  ██╗███████╗███╗   ███╗██╗"
    echo "  ██╔════╝██╔══██╗██╔══██╗██╔══██╗██║  ██║██╔════╝████╗ ████║██║"
    echo "  █████╗  ██████╔╝██████╔╝███████║███████║█████╗  ██╔████╔██║██║"
    echo "  ██╔══╝  ██╔═══╝ ██╔══██╗██╔══██║██╔══██║██╔══╝  ██║╚██╔╝██║██║"
    echo "  ███████╗██║     ██║  ██║██║  ██║██║  ██║███████╗██║ ╚═╝ ██║██║"
    echo "  ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝"
    echo -e "         [ EPRAHEMI ELITE DIAGNOSTIC SUITE - V.ULTIMATE ]\033[0m"
    
    if not set -q argv[1]
        echo -e "\n\033[1;31mERR: No Parameter Access Granted.\033[0m"
        echo -e "\033[1;33mCommands:\033[0m [\033[36mssd\033[0m|\033[36mhdd\033[0m|\033[36mram\033[0m|\033[36mnet\033[0m|\033[36mheat\033[0m|\033[36minfo\033[0m|\033[36mgpu\033[0m|\033[36mbatt\033[0m|\033[36mcpu\033[0m|\033[36mstress\033[0m]"
        return 1
    end
    
    set -l drive_type $argv[1]
    set -l test_file ""
    
    function draw_progress
        set -l duration $argv[1]
        set -l label $argv[2]
        echo -n -e "\033[1;30m$label\033[0m ["
        for i in (seq 1 40)
            echo -n "▓"
            sleep (math $duration / 40)
        end
        echo "] 100%"
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
            draw_progress 0.6 "Deep Scanning Controller"
            echo -e "\033[1;37mTEST A: Sequential Write (1GB)\033[0m"
            dd if=/dev/zero of=$test_file bs=1G count=1 oflag=dsync status=progress
            echo -e "\033[1;37mTEST B: Sequential Read (Flushing Cache)\033[0m"
            sudo /sbin/sysctl -w vm.drop_caches=3 > /dev/null
            dd if=$test_file of=/dev/null bs=1G count=1 status=progress
            rm $test_file
            
        case ram
            echo -e "🧠 \033[1;35mTARGET: SYSTEM RAM THROUGHPUT\033[0m"
            draw_progress 1.2 "Allocating 3GB Memory Blocks"
            dd if=/dev/zero of=/dev/null bs=1M count=3000 status=progress
            
        case net
            echo -e "🌐 \033[1;36mTARGET: GLOBAL NETWORK UPLINK\033[0m"
            draw_progress 1 "Establishing Secure Connection"
            speedtest-cli --simple
            
        case heat
            echo -e "🌡️ \033[1;31mTARGET: SYSTEM THERMAL SENSORS\033[0m"
            sensors | grep -E 'Core|temp|fan'
            
        case gpu
            echo -e "🎮 \033[1;32mTARGET: NVIDIA PERFORMANCE ENGINE\033[0m"
            nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu,memory.used --format=csv,noheader
            
        case batt
            echo -e "🔋 \033[1;33mTARGET: POWER CELL STATUS\033[0m"
            upower -i (upower -e | grep 'BAT') | grep -E "state|to\ full|percentage|capacity"
            
        case cpu
            echo -e "📟 \033[1;34mTARGET: PROCESSOR TOPOLOGY\033[0m"
            lscpu | grep -E "Model name|CPU\(s\):|Thread|Max MHz"
            
        case stress
            echo -e "🧨 \033[1;31mTARGET: SYSTEM OVERLOAD TEST (10s)\033[0m"
            draw_progress 0.5 "Priming Cores"
            timeout 10s cat /dev/urandom > /dev/null
            echo "Stress test complete. Monitor 'heat' for cooldown."
            
        case info
            echo -e "\033[1;33m╔══════════════════════════════════════════════════════════╗\033[0m"
            echo -e "\033[1;33m║           EPRAHEMI MASTER SYSTEM BLUEPRINT               ║\033[0m"
            echo -e "\033[1;33m╚══════════════════════════════════════════════════════════╝\033[0m"
            
            echo -e "\033[1;36m[💻 HARDWARE BASEBOARD]\033[0m"
            sudo dmidecode -s baseboard-manufacturer
            sudo dmidecode -s baseboard-product-name
            sudo dmidecode -s baseboard-version
            
            echo -e "\n\033[1;32m[🌐 NETWORK GATEWAY]\033[0m"
            echo -n "Local IP:  " ; ip route get 1 | awk '{print $7}'
            echo -n "MAC Addr:  " ; cat /sys/class/net/(ip route show default | awk '/default/ {print $5}')/address
            echo -n "Public IP: " ; curl -s https://ifconfig.me
            
            echo -e "\n\033[1;35m[📍 GEOLOCATION DATA]\033[0m"
            curl -s https://ipapi.co/json/ | grep -E "city|region|country_name|org"
            
            echo -e "\n\033[1;34m[💽 STORAGE MAPPING]\033[0m"
            lsblk -p -o NAME,SIZE,MODEL,FSTYPE,MOUNTPOINT | grep -v "loop"
            
            echo -e "\n\033[1;37m[📦 SYSTEM KERNEL]\033[0m"
            uname -rsv
            
        case '*'
            echo -e "❌ \033[1;31mParameter Error:\033[0m '$drive_type' is not recognized."
            return 1
    end
    
    # --- MASTER COMMAND DIRECTORY ---
    echo -e "\n\033[1;37m[ STATUS: MISSION SUCCESS - USER: EPRAHEMI ]\033[0m"
    echo -e "\033[1;30m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\033[1;33m📂 AVAILABLE MODULES:\033[0m"
    echo -e "  ➤ \033[36mssd\033[0m / \033[36mhdd\033[0m    : Storage I/O Speed Tests"
    echo -e "  ➤ \033[36mram\033[0m          : Memory Bandwidth Analysis"
    echo -e "  ➤ \033[36mnet\033[0m          : ISP Speed & Latency Check"
    echo -e "  ➤ \033[36mheat\033[0m / \033[36mgpu\033[0m    : Thermal & Graphics Health"
    echo -e "  ➤ \033[36mbatt\033[0m / \033[36mcpu\033[0m    : Power & Logic Performance"
    echo -e "  ➤ \033[36minfo\033[0m         : Hardware, IP, MAC & Location"
    echo -e "  ➤ \033[36mstress\033[0m       : Thermal Pressure Test"
    echo -e "\033[1;30m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
end
