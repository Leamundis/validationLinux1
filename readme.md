# Readme
###### by Jon

> ## A quoi sert ce fichier?
> Il permet d'installer, si l'utilisateur le veut, Vagrant et Virtualbox.
> Après ça, il permet de configurer et de monter très simplement une jolie petit VM.

> ## Comment l'utiliser?
> Il suffit de le mettre dans un dossier, se placer au même endroit dans le terminale, et de lancer la commande :
>
> `bash scriptValidationLinux1.sh`

> ## Les hacks
> Quelques 'hacks' se cachent dans le code, comme :
> - Malgré que ce soit demandé, il n'y à pas d'install de virtualbox, trop de version différentes existent, c'est pour ne pas tout casser
> - dans la VM, je demande de faire un choix entre windows, Linux et MacOS, évidemment, quelque soit la réponse, ça installera un ubuntu/xenial64
> - et peut-être un ou deux autres trucs que j'ai plus en tête

> ## Feature intéresante
> Lors de la configuration de la VM, on peut nommer le dossier synchronisé comme l'on veut. Mais si on le nomme "data", lorsque l'on relance le script, le dossier data et le fichier Vagrantfile sont automatiquement supprimé, ce qui est un peu plus pratique.
>
> De plus, juste avant de monter la VM, tu aura le choix de continuer ou non. Si tu continue, ça lancer le vagrant up. Et sinon, ça relance le script, avec sa purge de data et Vagrantfile, si tu as envi de le tester, sans avoir à attendre 3 plombes le montage de la VM. Je suis pas gentil?