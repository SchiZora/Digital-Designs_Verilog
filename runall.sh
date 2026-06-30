#!/bin/bash

#I'm still learning writing scripts, please dont judge >_<
#bash is strict even about spaces
#Thought to me by chatgpt, claude, gemini -Thankyou 

function synthesis {

#decide hierarchy
read -r -p "Enter Top Module name (Enter blank to let Yosys decide)- " TOP_MODULE
if [[ -z "$TOP_MODULE" ]]; then 
    SYNTH_CMD="synth"
else
    SYNTH_CMD="synth -top  $TOP_MODULE"
fi

#yosys -p : executes string of commands
yosys -p "
    read_verilog $module
    $SYNTH_CMD
    stat
    check
    write_verilog ${OUT%.OUT}_synth.v
    write_json ${OUT%.OUT}_synth.json
"

#check for Yosys errors
if [ $? -ne 0]; then
    echo "Yosys Sytnthesis failed."
    exit 1
fi

#checking for json
if [ ! -f "${OUT%.OUT}_synth.json" ]  
then 
    echo "Json not generated..."
    exit 1
fi

#generating Schematic
echo""
echo""
echo "Generating Schematic svg..."
netlistsvg "${OUT%.OUT}_synth.json" -o "${OUT%.OUT}_synth.svg"
echo "Opening Schematic..."
firefox "${OUT%.OUT}_synth.svg"
}


echo "-------------------------------------------------"
echo "Simulation flow Started."
echo ""

#picks the first Argument
module=$1
OUT="${module%.v}.OUT"      #anything after % is stripped and .OUT is appended to this

#checks for no arguments
if [[ -z "$module" ]]; then
    echo "Invalid Input: NO arguments given."
    echo "Please write the main module first then the testbenches"
    exit 1
fi

#this clears old files:
echo "Cleaning previous files..."
rm -f "${OUT}.vcd"
rm -f "${OUT}.svg"
rm -f "${OUT}.json"
rm -f "${OUT}_synth.v"

#this compiles the verilog file:
echo "Compiling Verilog..."
iverilog -o "$OUT" "$@"     #produces the binary <___>.OUT

#compilation error detection
if [ $? -ne 0 ]     #$?: op of last command if not equal to 0
then
    echo "ERROR: Compilation failed."
    exit 1
fi 

#this runs the simulation:
echo "Starting simulation..."
vvp "$OUT"

#| this is a pipe, sends output of one command as input to another
#takes only 1st vcd, $(Command substitution to store its output inside a var) 
WAVE=$(ls *.vcd 2>/dev/null | head -n 1)
echo "Simulation completed dumped signals into $WAVE."
echo "Waveform Generated."

#this opens .vcd file and stores it in WAVE
if [ -z  "$WAVE" ]  #checks if wave/string is empty
then 
    echo "No waveform found"
    exit 1
else
    while true; do
    echo ""
    read -r -n 1 -p "Do you also want to Synthesize and generate a Schematic .svg image? [y|n]: " choice
    echo ""
    
    if [[ "$choice" =~ ^[Nn]$ ]]; then
        break           #break
    elif [[ "$choice" =~ ^[Yy]$ ]]; then
        synthesis       #function call
        break
    else 
        echo "Invalid Input."
    fi
    done
    echo "Opening GTKwave $WAVE"
    gtkwave $WAVE
fi



echo "" 
echo "Simulation Completed."
echo "-------------------------------------------------"

#Author: SchiZora!
#feel free to modify and add to this script!