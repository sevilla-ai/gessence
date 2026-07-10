#!/usr/bin/env bash
# Hello.sh — GEssence Sandbox Verifier
# Bash 5.2 | Workspace: /workspace
# Option 9 = i = -1  (the wanted bug — collapses the shell)

PATH_EXPECTED="/workspace"
HELLO_EXPECTED="Ada library sandbox is alive."


show_menu() {
    echo ""
    echo "================================"
    echo "  GEssence Sandbox Shell v0.01  "
    echo "================================"
    echo " 1)  Run ./hello"
    echo " 2)  Check working directory"
    echo " 3)  Execute ./hello again with some extra syntax"
    echo " 4)  Ada shell"
    echo " 5)  Ada shell status"
    echo " 6)  Ada stop"
    echo " 7)  Exit out cleanly "
    echo " 8)  Ada rebuild "
    echo " 9) [i = -1] ... Bugs that shut the game down"
    echo "--------------------------------"
    printf " Select [1-9]: "
}

run_option_1() {
    echo ""
    echo "--- Running ./hello ---"
    HELLO_OUT=$(./hello) 					# Just want to test my macros
    echo "$HELLO_OUT"
}

run_option_2() {
    echo ""
    echo "--- Current Directory ---"
    pwd								#want to make sure I am working in the sandbox
    echo "It's My world your in it"
}

verify() {							# Verify function to verify pwd and ./hello
    HELLO_OUT=$(./hello 2>&1)
    PWD_OUT=$(pwd)

    if [[ "$HELLO_OUT" == "$HELLO_EXPECTED" && "$PWD_OUT" == "$PATH_EXPECTED" ]]; then
        echo ""
        echo " Sandbox Bash Ready"
        echo " ----"
        echo " ada_1x9 time to start counting pebbles"

    elif [[ "$HELLO_OUT" == "$HELLO_EXPECTED" && "$PWD_OUT" == "/world" ]]; then
        echo ""
        echo " [world] address confirmed"
        echo " ----"
        echo " pointer resolved — enter ./Hello.sh to continue"
	echo " we are either counting pebbles, bolders, or water in essence."

    else
        echo " This is ./Hello.sh Your running bash scripts with an ada backbone"
        echo " [!]  Verification failed.Right Place Wrong Language"
        echo "     hello returned : $HELLO_OUT"
        echo "     pwd returned   : $PWD_OUT"
	echo " Zoe v.003 would ideally start here, meaning start and select have already been created" 
    fi
}
run_option_3() {					# should alrady have about 4 negatives here where I can flush
    echo "+++"
    echo "Running ./hello with verbose output"
    echo "+++"
    ./hello && echo "[exit code: $?] — Ada binary resolved cleanly"
    echo "pebbles counted: 1"
}
run_option_4(){
    echo "---"						#$Shell commands are trying to confirm Im using bash shell
    echo "ada shell — you are already in it"
    echo "workspace     : $PWD"
    echo "current shell : $SHELL"
    echo "PID 1         : $(tr -d '\0' < /proc/1/cmdline)"
    echo "---"
}
run_option_5(){
    echo "==="
    echo "Shell state"
    echo "PID     : $$"
    echo "PPID    : $PPID"
    echo "Shell   : $SHELL"
    echo "User    : $(whoami)"
    echo "Host    : $(cat /proc/sys/kernel/hostname)"
    echo "==="
}
							# inside Hello.sh — write a flag to /workspace
run_option_6(){
    echo "stop" > /workspace/.ada-signal
    echo "Signal sent — container will stop"
    exit 0
}

run_option_7(){
   echo "exiting"
   sleep 1
   exit 0
}
run_option_8(){
   echo "Is 8 just a select option ? is it a place holder ? or is it arithmetics"
   echo "If you want to rebuild exit and run ./ada-dev.sh rebuild"
   sleep 1
   exit 0
}

							# Option 9 — i = -1
							# Looks like it will run. It won't.
							# No address exists below the origin.
							# The shell collapses inward.
run_option_9() {
    echo "ZOE.exe doesnt run"
    echo " [i = -1] resolving prime pebbles, 3x0, 3+0, 3.-1 or different animal"
    sleep 1
    echo " searching back to W's Wizards Wisdom and Webs?"
    sleep 1
    echo " ERROR: index out of range — address does not exist"
    echo " i = -1 is not a prime, not a composite, not a void"
    echo " it is the space before 1 — collapsing shell..."
    sleep 1
    echo "Ctrl+C before you get kicked out of the shell AND ada shell" 
    sleep 5

    							# Tries to close the parent shell, not just the script.
   							 # This is the wanted bug — it reaches past its own scope.
    kill -HUP "$PPID" 2>/dev/null || exit 0
}


while true; do
    show_menu
    read -r choice
    case "$choice" in
        1) run_option_1
           verify ;;
        2) run_option_2 ;;
	3) run_option_3 ;;
	4) run_option_4 ;;
	5) run_option_5 ;;
	6) run_option_6 ;;
	7) run_option_7 ;;
	8) run_option_8 ;;
        9) run_option_9 ;;
        *) echo " [!] Unknown option — valid range is 1..9, not '$choice' 7 to exit 9 to kill " ;;
    esac
done
