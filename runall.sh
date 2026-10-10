#!/bin/bash

#I'm still learning writing scripts, please dont judge >_<
#bash is strict even about spaces
#Thought to me by chatgpt and claude -Thankyou 

#checks the tools if they exists
#create a custom commmand/function
check() {
    command -v "$1" >/dev/null 2>&1 || {
        #DISCARDS TEH OUTPUT AND EROOR
        echo "ERROR: '$1' was not found."
        return 1
        #RETURN EXITS THE FUNCTION
    }
}

#choice input with local variable ans and an infinite loop for y or n as input
choice() {
    local ans 
    while true; do
        read -r -n 1 -p "$1 [y|n]: " ans
        echo ""
        case "$ans" in
            [Yy]) return 0 ;;   #success
            [Nn]) return 1 ;;   #failed
            *) echo "Invalid input." ;;     #default case
        esac
    done 
    #end case branch ;;
    #anything else *
    #end of pattern )
}

synthesis() {
    local top_module synth_cmd prep_cmd
    
    check yosys ||      return 1
    check netlistsvg || return 1 

    read -r -p "Enter Top Module name (Enter blank to let Yosys decide)- " top_module
    if [[ -z "$top_module" ]]; then 
        synth_cmd="synth"
        prep_cmd="prep"
    else
        synth_cmd="synth -top  $top_module"
        prep_cmd="prep -top $top_module"
    fi

    #yosys -p : executes a command of strings
    yosys -p "
        read_verilog $module;
        $synth_cmd;
        stat;
        check;
        write_verilog ${BASE}_synth.v
    "
    if [ $? -ne 0 ]; then
        echo "Yosys Synthesis failed...."
        return 1
    fi

    yosys -q -p "
        read_verilog $module;
        $prep_cmd;
        write_json ${BASE}_synth.json
    "
    if [ $? -ne 0 ]; then
        echo "Yosys prep (Schematic JSON) failed...."
        return 1
    fi    

    #checking for json
    if [ ! -f "${BASE}_synth.json" ]  
    then 
        echo "Json not generated..."
        return 1
    fi

    #generating Schematic svg
    echo""
    echo "Generating Schematic svg..."
    netlistsvg "${BASE}_synth.json" -o "${BASE}_synth.svg" || return 1
    echo "Opening Schematic..."
    firefox "${BASE}_synth.svg" >/dev/null 2>&1 &
    #2>&1 & : discards outputs and continues the script without waiting
}

echo "-------------------------------------------------"
echo "Simulation flow Started."
echo ""

#picks the first Argument
module=$1

#check for no arguments or missing files
if [[ -z "$module" ]]; then
    echo "Invalid Input: NO arguments given."
    echo "Please write the main module first."
    exit 1
fi
#check if file exists
if [[ ! -f "$module" ]]; then
    echo "ERROR: file '$module' not found."
    exit 1
fi 

check iverilog || exit 1
check vvp || exit 1

BASE="${module%.v}"
OUT="${BASE}.OUT"

echo ""
echo "Cleaning Previous Files..."
rm -f "$OUT" "${BASE}_synth.v" "${BASE}_synth.json" "${BASE}_synth.svg" "${BASE}.vcd"
echo ""

#compiling verilog using iverilog
echo "Compiling Verilog..."
iverilog -o "$OUT" "$@"
#compilation error detection
if [ $? -ne 0 ]     #$?: op of last command if not equal to 0
then
    echo "ERROR: Compilation failed."
    exit 1
fi 

echo "Starting simulation..."
vvp "$OUT"
#simulation error detection
if [ $? -ne 0 ]     #$?: op of last command if not equal to 0
then
    echo "ERROR: Simulation failed."
    exit 1
fi 

WAVE=$(find . -maxdepth 1 -name '*.vcd' -newer "$OUT" | head -n 1)

if [[ -z "$WAVE" ]]; then
    echo "No Waveform found..."
    echo "Did you add the \$dumpfile and \$dumpvars in testbench? "
else
    echo "Simulation completed dumped signals into $WAVE."
fi

#options
echo ""
if choice "Synthesize and Generate a schematic SVG?"; then
    synthesis || echo "Synthesis Failed, Continuing..."
else
    echo "Skipped Schematic Generation."
fi

echo ""
if [[ -n "$WAVE" ]] && choice "Open $WAVE Waveform through GTKWAVE?"; then
    echo "Opening GTKWave $WAVE"
    gtkwave "$WAVE" >/dev/null 2>&1 &
fi

echo "" 
echo "Simulation Completed."
echo "-------------------------------------------------"