#!/bin/bash

# Printing a file

echo "Let's print a file! The default printer is: $(lpstat -d)"
echo "Remember: the file to print must be in your current directory!"

user=

while true; do
    echo
    while true; do
        read -p "Current user is: $user. Is that you? (yes/no/cancel) " isuser
        if [ $isuser = no ]; then
            read -p "Please write your short username: " user
            break 1
        elif [ $isuser = yes ]; then
            break 1
        elif [ $isuser = cancel ]; then
            exit
        else
            echo "Input for user is not valid. Try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Name of the file (include extension): ' filevar
        if [ -f "$filevar" ]; then
            break 1
        elif [ $filevar = cancel ]; then
            exit
        else
            echo "File does not exist or is not in current directory. Please try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Two-sided (yes/no/cancel): ' twosidedvar
        if [ $twosidedvar = yes ]; then
            echo
            while true; do
                read -p 'Flip on short or long edge? (short/long/cancel): ' flipvar
                if [ $flipvar = long ]; then
                    twosidedvar=two-sided-long-edge
                    break 2
                elif [ $flipvar = short ]; then
                    twosidedvar=two-sided-short-edge
                    break 2
                elif [ $flipvar = cancel ]; then
                    exit
                else
                    echo "Input is not valid, please try again."
                    continue
                fi
            done
        elif [ $twosidedvar = no ]; then
            twosidedvar=one-sided
            break 1
        elif [ $twosidedvar = cancel ]; then
            exit
        else
            echo "Input is not valid, please try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Orientation (horizontal/vertical/cancel): ' orientvar
        if [ $orientvar = horizontal ]; then
            orientvar=landscape
            break 1
        elif [ $orientvar = vertical ]; then
            orientvar=portrait
            break 1
        elif [ $orientvar = cancel ]; then
            exit
        else
            echo "Input is not valid, please try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Number of copies (1 to n/cancel): ' copiesvar
        if [[ "$copiesvar" =~ ^[0-9]+$ ]]; then
            break 1
        elif [ $copiesvar = cancel ]; then
            exit
        else
            echo "Input must be an integer, please try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Color (Col) or Black & White (BW)?: ' colorvar
        if [ $colorvar = Col ]; then
            colorvar=McGill_Color_cups_ncs_mcgill_ca
            break 1
        elif [ $colorvar = BW ]; then
            colorvar=McGill_Mono_Printers_cups_ncs_mcgill_ca
            break 1
        elif [ $colorvar = cancel ]; then
            exit
        else
            echo "Input is not valid, please try again."
            continue
        fi
    done

    echo
    while true; do
        read -p 'Paper size? (legal/A3/A4/letter/cancel): ' sizevar
        if [ $sizevar = legal ] || [ $sizevar = A3 ] || [ $sizevar = A4 ] || [ $sizevar = letter ]; then
            break 1
        elif [ $sizevar = cancel ]; then
            exit
        else
            echo "Input is not valid or size is not supported, please try again."
            continue
        fi
    done

   

    echo 'Please review the settings for your printing job:'

    printf "%20s %s\n" "User" $user "File" $filevar "Printer" $colorvar "Size" $sizevar "Orientation" $orientvar "Sides" $twosidedvar "Copies" $copiesvar

    echo
    read -p 'Is everything right? (yes/no): ' printvar

    echo
    if [ $printvar = yes ]; then
        echo
        echo 'I will proceed to send the job.'
        echo
        break 1
    elif [ $printvar = no ]; then
        read -p 'Do you want to try again? (yes/no): ' defeatvar 
            while true; do
            if [ $defeatvar = yes ]; then
                continue 2
            elif [ $defeatvar = no ]; then
                echo
                echo "Stopping the printing job. Please try again."
                echo
                exit
            else
                echo "Input is invalid. Try again."
                continue
            fi
        done
    else
        echo "Input is invalid. Try again."
        echo
        continue
    fi
done



# One or Two-sided
echo 'The command is:'
echo "lp -U $user -d $colorvar -n $copiesvar -o $orientvar -o media=$sizevar -o sides=$twosidedvar $filevar"
lp -U $user -d $colorvar -n $copiesvar -o $orientvar -o media=$sizevar -o sides=$twosidedvar $filevar

# For other commands, visit: https://www.linuxfordevices.com/tutorials/linux/lp-command-in-linux or https://www.cups.org/doc/options.html or https://www.cups.org/doc/man-lp.html
