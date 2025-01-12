clear
# Colors
red="\033[31m"
green="\033[32m"
yellow="\033[33m"
blue="\033[34m"
magenta="\033[35m"
cyan="\033[36m"
rst="\033[0m"

echo -e "${cyan}Checking pkges${rst}"
sleep 1

check_pkg() {
    dpkg -s "$1" &> /dev/null
    if [[ $? -ne 0 ]]; then
        echo -e "${cyan}Installing '$1'...${rst}"
        pkg install "$1" -y &> /dev/null 2>&1
        echo -e "${green}'$1' installed successfully!!${rst}"
    else
        echo -e "${green}'$1' is already installed${rst}"
    fi
}

echo ""
check_pkg toilet
sleep 1
check_pkg figlet
sleep 1
check_pkg ncurses-utils
sleep 1

echo -e "${blue}Checking for updates...${rst}"
sleep 1
if apt list --upgradable 2> /dev/null | grep -v "WARNING" | grep -q "upgradable"; then
    echo -e "${yellow}Updating pkges...${rst}"
    pkg update > /dev/null 2>&1
    pkg upgrade -y > /dev/null 2>&1
    echo -e "${green}Pkges are now updated and upgraded${rst}"
else
    echo -e "${green}All pkges are already up-to date${rst}"
fi
sleep 1

clear
echo -e "${cyan}$(figlet -f slant "System Info")${rst}"
echo ""

# Fetch system information
os_name=$(uname -o)
kernel=$(uname -r)
arch=$(uname -m)
hostname=$(hostname)
uptime=$(uptime -p)
shell=$(basename "$SHELL")
cpu=$(lscpu | grep "Model name" | awk -F: '{print $2}' | xargs)
memory=$(free -h | grep "Mem" | awk '{print $2}')
disk=$(df -h / | awk 'NR==2 {print $2}')

# Display system info
echo -e "${yellow}Operating System:${rst} ${green}$os_name${rst}"
echo -e "${yellow}Kernel Version:${rst} ${green}$kernel${rst}"
echo -e "${yellow}Architecture:${rst} ${green}$arch${rst}"
echo -e "${yellow}Hostname:${rst} ${green}$hostname${rst}"
echo -e "${yellow}Uptime:${rst} ${green}$uptime${rst}"
echo -e "${yellow}Shell:${rst} ${green}$shell${rst}"
echo -e "${yellow}CPU:${rst} ${green}$cpu${rst}"
echo -e "${yellow}Total Memory:${rst} ${green}$memory${rst}"
echo -e "${yellow}Disk Size:${rst} ${green}$disk${rst}"
echo ""

# Print banner message
term_width=$(tput cols)
message=$(figlet -f digital "dark p")
cmessage=$(echo -e "${cyan}$message${rst}")
message_width=$(echo "$message" | wc -L)
padding_width=$(( (term_width - message_width) / 2 ))

while IFS= read -r line; do
    printf "%*s\n" $((message_width + padding_width)) "$line"
done <<< "$cmessage"

echo -e "${rst}"
sleep 4

clear
echo ""
echo ""
echo -e "${yellow}                    Made by${rst}"
term_width=$(tput cols)
message2=$(figlet -f digital "kazuya")
cmessage2=$(echo -e "${blue}$message2${rst}")
message_width=$(echo "$message2" | wc -L)
padding_width=$(( (term_width - message_width) / 2 ))

while IFS= read -r line; do
    printf "%*s\n" $((message_width + padding_width)) "$line"
done <<< "$cmessage2"

echo -e "${rst}"
echo -e "${cyan}                 With love${rst}"
echo ""
sleep 1

fn="$HOME/.name_dark_gang"
if [[ -f "$fn" ]]; then
    nm=$(cat "$fn")
else
    term_width=$(tput cols)
    message3=$(toilet "Dark Gang")
    cmessage3=$(echo -e "${green}$message3${rst}")
    message_width=$(echo "$message3" | wc -L)
    padding_width=$(( (term_width - message_width) / 2 ))

    while IFS= read -r line; do
        printf "%*s\n" $((message_width + padding_width)) "$line"
    done <<< "$cmessage3"

    echo ""
    echo ""

    read -p "Enter your name: " nm
    echo "$nm" > "$fn"
fi

sleep 2
clear
echo -e "${blue}$(figlet -f lean "$nm")${rst}"
sleep 1
time="$(date +%H)"
timee="$(date +%H:%M)"
tm="$(date +%H%M)"

if [[ $((10#$time)) -ge 5 && $((10#$time)) -le 10 ]]; then
    echo -e "${yellow}Hey '$nm'${rst} ${green}good morning${rst} "
elif [[ $((10#$time)) -ge 11 && $((10#$time)) -le 14 ]]; then
    echo -e "${yellow}Hey '$nm'${rst} ${green}good noon${rst} "
elif [[ $((10#$time)) -ge 15 && $((10#$time)) -le 17 ]]; then
    echo -e "${yellow}Hey '$nm'${rst} ${green}good afternoon${rst}"
elif [[ $((10#$time)) -ge 18 && $((10#$time)) -le 20 ]]; then
    echo -e "${yellow}Hey '$nm',${rst} ${green}good evening! ${rst}"
elif [[ $((10#$time)) -ge 21 && $((10#$time)) -le 2359 ]]; then
    echo -e "${yellow}Hey '$nm',${rst} ${green}its late night!!! ${rst} ${red}you must sleep now${rst}"
elif [[ $((10#$time)) -ge 1 && $((10#$time)) -le 4 ]]; then
    echo -e "${yellow}Hey '$nm',${rst} ${green}good night!!! ${rst}${rst}"
fi
sleep 1
echo -e "${blue}its ${green}$timee${rst}"

sleep 1
# heheh 😅 i love t-headers ps1, so i used it, ps1 cradit goes to remo773 
PS1='
\[\033[0;31m\]┌─[\[\033[1;34m\]$nm\[\033[1;33m\]@\[\033[1;36m\]dark_gang\[\033[0;31m\]]─[\[\033[0;32m\]\w\[\033[0;31m\]]
\[\033[0;31m\]└──╼ \[\e[1;31m\]❯\[\e[1;34m\]❯\[\e[1;90m\]❯\[\033[0m\] '
