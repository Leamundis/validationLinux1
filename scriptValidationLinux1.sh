#!/usr/bin/env bash
clear

# First function loaded
start()
{
echo "Salut!"
#sleep 1
echo -e "Bienvenu dans ce script de Validation de \e[34mLinux 1!\e[0m"
#sleep 1
echo "Commenons par les paramètres de base"
#sleep 1
echo -e "Veux-tu installer Vagrant? (\e[32my\e[0m/\e[31mn\e[0m)"
askVagrant
}

# Vagrant installation
askVagrant()
{
    read vagrant
    if [ $vagrant == "y" ]
    then
        sudo apt-get install vagrant
        echo -e "\e[32mVagrant a bien été installé \e[0m"
        sleep 2
        clear
        echo -e "Veux-tu installer Virtualbox? (\e[32my\e[0m/\e[31mn\e[0m)"
        askVirtual
    elif [ $vagrant == "n" ]
    then
        echo "Ok, c'est ton choix"
        sleep 1
        clear
        echo -e "Veux-tu installer Virtualbox? (\e[32my\e[0m/\e[31mn\e[0m)"
        askVirtual        
    else
        echo -e "\e[31mUne erreur à été détecté dans votre cerveau, il faut taper \"y\" ou \"n\" : \e[0m"
        askVagrant
    fi
}

# Virtualbox installation
askVirtual()
{
    read virtual
    if [ $virtual == "y" ]
    then
        echo "Fait semblant d'installer VB"
        sleep 1
        clear
        echo "Fait semblant d'installer VB."
        sleep 1
        clear
        echo "Fait semblant d'installer VB.."
        sleep 1
        clear
        echo "Fait semblant d'installer VB..."
        sleep 1
        clear
        echo "Fait semblant d'installer VB....done!"
        sleep 1
        echo -e "\e[32mVirualbox a bien été installé \e[0m"
        sleep 1
        installVM
    elif [ $virtual == "n" ]
    then
        echo "Ok, c'est aussi ton choix"
        sleep 1
        installVM
    else
        echo -e "\e[31mUne erreur à été détecté dans votre cerveau, il faut taper \"y\" ou \"n\" : \e[0m"
        askVirtual
    fi
}

# install a VM with your parameters
installVM()
{

    clear
    rm -rf data
    rm -rf Vagrantfile

    # sync Directory
    echo "Paaaarfait! Passons à la configuration de la VM maitenant! J'espére que tu aimes l'anglais mon ami :"
    echo ""
    sleep 1
    vagrant init
    echo ""
    echo "Nom du dossier synchroniser?"
    read dirSync
    mkdir $dirSync
    sed -i "s/..\/data/.\/$dirSync/" 'Vagrantfile'
    sed -i 's/vagrant_data/var\/www\/html/' 'Vagrantfile'
    sed -i "s/inline:\ <<-SHELL/path: \"$dirSync\/install-update.sh\"/" 'Vagrantfile'

    # However the response, will mount a ubuntu/xenial64
    clear
    echo "Quelle Machine veux-tu monter?"
    echo "1. Linux"
    echo "2. Windows"
    echo "3. MacOS"
    read lie
    sed -i -e 's/base/ubuntu\/xenial64/' 'Vagrantfile'

    # set up ip
    clear
    echo "Quelle adresse IP"
    read ip
    sed -i s/192.168.33.10/$ip/ 'Vagrantfile'
    sed -i '35 s/#//; 46 s/#//; 66 s/#//' 'Vagrantfile'

    # initiate the install-update.sh for update after ssh
    echo "#!/usr/bin/env bash
    sudo apt-get update" > $dirSync/install-update.sh

    # VM configuation
    clear
    echo -e "\e[93mLe Vagrantfile est bien configuré, passons à la VM\e[39m"
    sleep 1

    # Apache installation
    echo "Est-ce que tu veux installer apache2?"
    echo "1. Oui"
    echo "2. Non"
    read apache
    while [ $apache != 1 ] && [ $apache != 2 ]
    do
        echo -e "\e[31mC'est vraiment si compliqué de taper sur \"1\" ou \"2\" \e[0m"
        echo -e "\e[31mAllé! Un petit effort! \e[0m"
        read apache
    done
    if [ $apache == 1 ]
    then
        echo "sudo apt install -y apache2" >> $dirSync/install-update.sh
        echo "sudo service apache2 restart" >> $dirSync/install-update.sh
        echo -e "\e[32mParfait! Apache sera bien installé"
    fi
    sleep 1

    # php7.0 installation
    clear
    echo -e "\e[93mLe Vagrantfile est bien configuré, passons à la VM\e[39m"
    echo -e "\e[97mEst-ce que tu veux installer php7.0?"
    echo "1. Oui"
    echo "2. Non"
    read php
    while [ $php != 1 ] && [ $php != 2 ]
    do
        echo -e "\e[31mC'est vraiment si compliqué de taper sur \"1\" ou \"2\" \e[0m"
        echo -e "\e[31mAllé! Un petit effort! \e[0m"
        read php
    done
    if [ $php == 1 ]
    then
        echo "sudo apt install -y php7.0" >> $dirSync/install-update.sh
        echo -e "\e[32mParfait! Php7.0 sera bien installé"
    fi
    sleep 1


    # libapache2-mod-php7.0 installation
    clear
    echo -e "\e[93mLe Vagrantfile est bien configuré, passons à la VM\e[39m"
    echo -e "\e[97mEst-ce que tu veux installer libapache2-mod-php7.0?"
    echo "1. Oui"
    echo "2. Non"
    read libapache
    while [ $libapache != 1 ] && [ $libapache != 2 ]
    do
        echo -e "\e[31mC'est vraiment si compliqué de taper sur \"1\" ou \"2\" \e[0m"
        echo -e "\e[31mAllé! Un petit effort! \e[0m"
        read libapache
    done
    if [ $libapache == 1 ]
    then
    echo "sudo apt install libapache2-mod-php7.0" >> $dirSync/install-update.sh
    echo "sudo service apache2 restart" >> $dirSync/install-update.sh
    echo -e "\e[32mParfait! libapache2-mod-php7.0 sera bien installé"
    fi
    sleep 1


    # Proof that unicorn are fatal security breach
    clear
    echo -e "\e[97mEst-ce que tu veux installer une licorne à moteur toute mignonne avec tout ça?"
    echo "1. Oui"
    echo "2. Non"
    read unicorn
    if [ $unicorn == 1 ]
    then
        echo -e "\e[96mMouahahah! Ça n'existe pas les licornes à moteur!\e[39m"
    else
        echo -e "\e[96mTu fais bien, c'est beaucoup trop d'entretien...\e[39m"
    fi
    sleep 2
    testing
}

testing()
{
    # For testing
    clear
    echo "Et voila, on est fin prêt! Il ne reste plus qu'à monter la vagrant."
    sleep 1
    echo "Mais tu as le choix, soit de continuer et lancer la VM (mais c'est un peu long)."
    sleep 1
    echo "Soit d'arrêter la, et de relancer le programme (ça le fera tout seul, cf Readme)."
    sleep 2
    echo "Ton choix?"
    echo "1. Continuer"
    echo "Toutes les autres réponses : Tester le script"
    read testing
    if [ $testing == 1 ]
    then 
        vagrantUp
    else
        start
    fi
}

# Mount your Vagrant
vagrantUp()
{

    echo "Tout est prêt, cowboys! On peut lancer cette fichu VM, c'est pas trop tôt!"
    sleep 1
    vagrant up
    clear
    echo "Et voila! Enfin fini (enfin presque!)"
    sleep 0.5
    echo "C'est pas que je suis super motivé, mais apparemment, faut aussi te proposer de checker les autrs VM"
    echo "C'est donc parti pour la folie des Box!"
    sleep 2
    configBox
}

configBox()
{
    clear
    echo "Voici une liste des Vm qui tournent :"
    echo ""
    vagrant global-status
    echo ""    
    echo "1. Allumer une VM"
    echo "2. Éteindre une VM"
    echo "3. Kill une VM"
    echo "4. Passer en ssh sur la notre"
    read configBox
    if [ $configBox == 1 ]
    then
        turnOn
    elif [ $configBox == 2 ]
    then
        turnOff
    elif [ $configBox == 3 ]
    then
        killVM
    elif [ $configBox == 4 ]
    then
        vagrantSsh
    fi
}

turnOn()
{
    clear
    echo -e "\e[104m\e[1;4mVoici une liste des Vm qui tournent :\e[49m"
    echo ""
    vagrant global-status
    echo ""
    echo "Entre l'id de la VM que tu veux allumer"
    read id
    vagant up $id
    configBox
}

turnOff()
{
    clear
    echo -e "\e[104m\e[1;4mVoici une liste des Vm qui tournent :\e[49m"
    echo ""
    vagrant global-status
    echo ""
    echo "Entre l'id de la VM que tu veux éteindre"
    read id
    vagant halt $id
    configBox
}

turnOff()
{
    clear
    echo -e "\e[104m\e[1;4mVoici une liste des Vm qui tournent :\e[49m"
    echo ""
    vagrant global-status
    echo ""
    echo "Entre l'id de la VM que tu veux détruire"
    read id
    vagant destroy $id
    configBox
}

vagrantSsh()
{
    vagrant ssh
}

start