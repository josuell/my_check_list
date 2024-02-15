# my_check_list

check my todo list

## Getting Started

## Design pattern 

Bloc(Business Logic Components) 
    Il permet de separer la logique metier de l'interface pour faciliter la maintenance du code
    
Provider 
    On utilise le package provider pour s'assurer qu'il n'y a qu'une seule instance de la classe de 
    service (MyToDoListService) dans toute l'application

## Démarche
Les affichages et le service sont liées par le Bloc

### Liste des tâches
A la page d'acceuil, on envoie un évènement(event) pour recupérer la liste des tâches vers le Bloc(CheckListBloc),
Celui-ci s'occupera d'effectuer l'appel vers le serveur par le biais de la classe service (MyToDoListService) 
Si la recupération de la liste des tâches est un succès, on envoie les données obtenues à l'interface par le biais de l'état(ShowCheckListState) 
Mais si c'est un échec, on émet l'erreur à l'écran par le biais de l'etat(CheckError)

### Ajout de tâche
En bas de l'écran principal, vous pourrez voir une icône d'ajout qui affichera une boîte de dialogue pour
désigner le nom de la tâche anfin de faire l'insertion dans la base de donnée via l'API REST 
dans la classe service (MyToDoListService) dans la fonction createTask()

### Marquer comme terminée
Un clic sur une tâche permet de marquer la tâche comme terminée: on envoie l'évènement (UpdateATodoEvent)
en marquant la tâche avec une valeur booléenne
Si tout s'est déroulé sans accroche alors on émet l'état (UpdateChecksuccèss) et dans l'écran
l'écouteur du Bloc gèrera les actions à faire en envoyant les messages de succès et en rafraîchissant
l'écran de la liste

### Modifier la designation de la tâche
Un appui prolongé sur une tâche ouvre une boite de dialogue pour modifier la désignation de cette tâche,
on envoie l'évènement (UpdateATodoEvent) au Bloc ensuite le prossessus reste semblable à celui de 
marquer comme terminé

### Suppression de tâche
En faisant glisser vers la gauche la tâche, un bouton apparaît pour supprimer celui-ci qui sera envoyé 
à l'évènement (DeleteOneTaskEvent) de là on obtient une boite de dialogue qui vous demande confirmation
en cas de succès l'écouteur du Bloc affichera un message de succès à l'écran
Si non l' erreur sera affiché en rouge en bas de l'ecran de la liste des tâches

### Triage
Il permet de faire un triage ascandant ou descendant en cliquant sur le bouton à droite de l'écran 
de la liste en haut de la page, deux options s'offre à nous: faire un triage par designation ou par date.
Pour le triage par désignation nous ferons appel à la fonction (sortTaskByDesignation) dans la classe 
de service (MyToDoListService) en donnant comme argument la liste des tâches et le type de triage(ascendant,descendant)
Pour le triage par date nous ferons également appel à une fonction de la même classe (sortTaskByDate)
Après cela nous aurons une liste triée à l'interface

### Recherche
La recherche se fait par comparaison de chaque mot taper sur la barre de recherche

## Lancement

```bash
  flutter pub get
  flutter run
```
    