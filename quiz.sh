#!/bin/bash
# Check if quiz.txt exists
if [ ! -f quiz.txt ]; then
    echo "The file quiz.txt does not exist. Please make sure it is in the same directory as this script."
    exit 1
fi

echo -e "This game is about guessing your knowledge of the computer science field.\n"
echo -e "You will be asked to answer by true or false.\n"
echo  "You will be given a score at the end of the game.\n" 
python3 -c "
import os
import time
import sys

def shout_congratulations():
    message = 'This game is developed by JCDigit, Enjoy it!'
    for char in message:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(0.1)
    print()

def graphic_effects():
    os.system('echo  \"\\033[1;32m\"')  # Green text
    shout_congratulations()
    os.system('echo  \"\\033[0m\"')  # Reset text color

graphic_effects()
"
read -p "Press Enter to continue..."
read -p "Please enter your name: " username
echo "Welcome , $username!"
echo "You must respect the case of the letters in the answers. for exemple:  if answer is True then you must right (Vrai) or False then you must right (Faux)"
read -p "Are you ready to start the game? (y/n): " suite
let 'count=0'
let 'note=0'
debut=$(date +%H:%M)
while [ $suite = "Y" ] || [ $suite = "y" ]; do
clear
    note=$(($note + 1))
    quizz=$(((RANDOM % 211) + 1))
    fil=$(sed -n "${quizz}p" quiz.txt)
    file=$(cut -d "-" -f2 <<< "$fil")
    echo " $file ?"
    read -p "Votre réponse: " -t 30 reponse
    capitale=$(cut -d "-" -f1 <<< "$fil")
    if [ "$reponse" = "$capitale" ]; then
        echo "Correct!"
        count=$((count + 1))

    else
        echo ", Incorect La reponse est  $capitale."
    fi
    read -p "Voulez-vous continuer? (y/n): " suite
done 
moy=$(($note / $count))

if [[ $moy -le 2 ]];
 then

python3 -c "
import os
import time
import sys

def shout_congratulations():
    message = 'Congratulation $username  you got $count/$note pts!'
    for char in message:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(0.1)
    print()

def graphic_effects():
    os.system('echo -e \"\\033[1;32m\"')  # Green text
    shout_congratulations()
    os.system('echo  \"\\033[0m\"')  # Reset text color

graphic_effects()
"
else 
python3 -c "
import os
import time
import sys

def shout_congratulations():
    message = 'Olaaaaaa $username  you got $count/$note pts!, you must improve your culture in computer science'
    for char in message:
        sys.stdout.write(char)
        sys.stdout.flush()
        time.sleep(0.1)
    print()

def graphic_effects():
    os.system('echo -e \"\\033[1;32m\"')  # Green text
    shout_congratulations()
    os.system('echo  \"\\033[0m\"')  # Reset text color

graphic_effects()
"
fi 

fin=$(date +%H:%M)
dates=$(date +%D)

echo "$username          $count/$note     $dates     $debut    $fin" >>score.txt
echo "Your score has been saved in the score.txt file."
echo "Thank you for playing!"
echo "Bye bye!"
