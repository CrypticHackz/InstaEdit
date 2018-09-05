#!/bin/bash
#EditInsta
#Coded by: CrypticHackz


## Credentials here

default_username=""
default_password=""


banner() {

printf "\n"
printf "\e[1;77m" ██████╗██████╗ ██╗   ██╗██████╗ ████████╗██╗ ██████╗    \n"
printf "         ██╔════╝██╔══██╗╚██╗ ██╔╝██╔══██╗╚══██╔══╝██║██╔════╝\n"
printf "         ██║     ██████╔╝ ╚████╔╝ ██████╔╝   ██║   ██║██║     \n"
printf "         ██║     ██╔══██╗  ╚██╔╝  ██╔═══╝    ██║   ██║██║   \n"
printf "         ╚██████╗██║  ██║   ██║   ██║        ██║   ██║╚██████╗\n"
printf "          ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚═╝        ╚═╝   ╚═╝ ╚═════╝\n"
printf "\n"
printf "\e[1;92m https://www.twitter.com/CrypticHackz\e[0m\n"
printf "\n"
}

dependencies() {


command -v curl > /dev/null 2>&1 || { echo >&2 "I require curl but its not installed. Run apt-get install curl"; exit 1; }





login_user() {
csrftoken=$(curl https://www.instagram.com/accounts/login/ajax -L -i -s | grep "csrftoken" | cut -d "=" -f2 | cut -d ";" -f1)

if [[ "$default_username" == "" ]]; then
read -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Username: \e[0m' username
else
username="${username:-${default_username}}"
fi


if [[ "$default_password" == "" ]]; then
read -s -p $'\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Password: \e[0m' password
else
password="${password:-${default_password}}"
fi


printf "\e[\n1;77m[*] Trying to login as\e[0m\e[1;77m %s\e[0m\n" $username
check_login=$(curl -c cookies.txt 'https://www.instagram.com/accounts/login/ajax/' -H 'Cookie: csrftoken='$csrftoken'' -H 'X-Instagram-AJAX: 1' -H 'Referer: https://www.instagram.com/' -H 'X-CSRFToken:'$csrftoken'' -H 'X-Requested-With: XMLHttpRequest' --data 'username='$username'&password='$password'&intent' -L --compressed -s | grep -o '"authenicated": true')


if [[ "$check_login" == *'"authenicated": true'* ]]; then
printf "\e[1;93/[*] Login Successful!\e[0m\n"
else
printf "\e[1;93m[!] Check your login data or IP! Dont use Tor,VPN,Proxy. It requires your usual IP.\n\e[0m"
exit 1
fi


}


edit() {

printf "\n"
printf "\e[1;92m[\e[0m\e[1;77m+\e[0m\e[1;92m] Edit Profile:\e[0m\n"
default_new_username=$username
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] New username: \e[0m' new_username
new_username="${new_username:-${default_new_username}}"
default_old_pass=$password
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Old Password: \e[0m' old_pass
old_pass="${old_pass:-${default_old_pass}}"
default_new_pass=$password
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] New Password: \e[0m' new_pass
new_pass="${new_pass:-${default_new_pass}}"
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Gender (male: 1, female: 2, Undef: 3): \e[0m' gender
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Phone: \e[0m' phone
IFS=$'\n'
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] First Name: \e[0m' first_name
IFS=$'\n'
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Bio: \e[0m' bio
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] External Url: \e[0m' external_url
read -p $'\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Email: \e[0m' email

printf "\n\e[1;77m[\e[0m\e[1;92m+\e[0m\e[1;77m] Editing Profile...\e[0m\n"

curl -i -v -s -k -X $'POST' -H $'Host: www.instagram.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Referer: https://www.instagram.com/accounts/edit/' -H $'X-CSRFToken: '$csrftoken'' -H $'X-Instagram-AJAX: 1' -H $'Content-Type: application/x-www-form-urlencoded' -H $'X-Requested-With: XMLHttpRequest' -H $'Cookie: csrftoken='$csrftoken'; csrftoken='$csrftoken';' -H $'Connection: close' --data-binary $'first_name='$first_name'&email='$email'&username='$new_username'&phone_number='$phone'&gender='$gender'&biography='$bio'&external_url='$external_url'&chaining_enabled=' $'https://www.instagram.com/accounts/edit/' -b cookies.txt

curl -i -s -k -X $'POST' -H $'Host: www.instagram.com' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0' -H $'Accept: */*' -H $'Accept-Language: en-US,en;q=0.5' -H $'Accept-Encoding: gzip, deflate' -H $'Referer: https://www.instagram.com/accounts/password/change/' -H $'X-CSRFToken: '$csrftoken'' -H $'X-Instagram-AJAX: 1' -H $'Content-Type: application/x-www-form-urlencoded' -H $'X-Requested-With: XMLHttpRequest' -H $'Cookie: csrftoken='$csrftoken'; csrftoken='$csrftoken';' -H $'Connection: close' -b cookies.txt --data-binary $'old_password='$old_pass'&new_password1='$new_pass'&new_password2='$new_pass'' $'https://www.instagram.com/accounts/password/change/'

}
banner
dependencies
login_user
edit
