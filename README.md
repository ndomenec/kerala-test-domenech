# kerala-test-domenech

Voici ma solution au test technique propose par Kerala Ventures>

La solution a ete faite en utilisant ruby 2.3.6 et rails 5.2.3

J'ai essaye de ne pas passer trop de temps sur ce test (je ne pense pas que ce soit l'objectif de celui-ci) et j'ai donc quelques idees d'ameliorations que je n'ai pas pu faire:

Tout d'abord en cours de developpement je me suis rendu compte que la maniere dont je gardais l'historique des changements pouvait etre amelioree, comme je l'ai fait si on change le modele Person ou Building les modeles associés a l'historique ne seront pas modifiés en conséquence. J'ai vu que j'aurais notamment pu utiliser la gem paper-trail qui aurait pu se charger de gerer l'historique de maniere optimale.

Ensuite il y a beaucoup de parties de codes que j'aurais pu refactoriser, notamment sur les modeles Person et Building ou une grosse partie du code est en commun pour l'import de csv.
