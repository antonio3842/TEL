/*
    Fichier : fn_tuto_ensureConfig.sqf
    Retourne les onglets du guide : [id, titre, contenuHTML]
*/

if (isNil "MRP_Tuto_Config") then {
    MRP_Tuto_Config = [
        [
            "ile",
            "L'île",
            "
<t color='#F2B80D' size='1.2'>Arrivée à La Trinité</t><br/><br/>
À votre arrivée à La Trinité, il est important de suivre quelques étapes essentielles pour bien débuter votre nouvelle vie sur l'île. Dès vos premiers pas en ville, la priorité est de vous rendre à la banque, notamment au <t color='#FFCC00'>Crédit Mutuel</t>.<br/><br/>
<t color='#FFCC00' size='1.05'>Banque — étapes indispensables</t><br/>
1. <t color='#FFCC00'>Ouvrir un compte</t> (Livret A) : sans compte, vous ne pourrez ni recevoir de salaire, ni payer vos achats.<br/>
2. <t color='#FFCC00'>Acheter une carte bronze</t> auprès de la banque.<br/>
3. <t color='#FFCC00'>Lier votre carte à votre compte</t> via le menu de la banque — étape souvent oubliée, mais obligatoire pour utiliser votre carte au quotidien (paiements, retraits, etc.).<br/><br/>
Une fois ces démarches bancaires terminées, dirigez-vous vers les magasins de vêtements situés à proximité. Changer de style est une excellente manière de vous intégrer et de vous démarquer dès le début. Que vous optiez pour une tenue simple, élégante ou plus originale, votre apparence joue un rôle important dans votre identité sur l'île. Profitez-en pour choisir des vêtements qui correspondent à votre personnalité et à l'image que vous souhaitez renvoyer.<br/><br/>
Ensuite, juste à côté, vous trouverez une boutique de l'opérateur Orange. Il est fortement conseillé de vous y rendre pour acheter un téléphone ainsi qu'un abonnement. Cela vous permettra de communiquer avec les autres habitants, recevoir des appels importants, utiliser certaines applications utiles et rester connecté à tout moment. Sans téléphone, vos interactions seront limitées, ce qui peut freiner votre progression.<br/><br/>
Une fois ces étapes complétées — compte ouvert, carte bronze liée, nouveau style adopté et téléphone en main — vous serez enfin prêt à commencer votre aventure. À partir de ce moment-là, tout s'ouvre à vous : trouver un travail, rencontrer d'autres personnes, développer vos activités ou même créer votre propre histoire sur l'île. Trinité devient alors votre nouveau terrain de jeu, et votre vie peut réellement commencer.
            "
        ],
        [
            "metiers",
            "Métiers civils",
            "
<t color='#F2B80D' size='1.2'>Les métiers pour débuter</t><br/><br/>
Pour bien commencer votre vie sur l'île, certains métiers sont particulièrement recommandés aux nouveaux arrivants. Parmi eux, la poste et les éboueurs, taxi etc.. sont idéaux pour découvrir l'environnement, comprendre le fonctionnement du serveur et gagner vos premiers revenus de manière simple. D'autres activités comme le bus, le taxi ou le minage permettent ensuite de progresser et de diversifier vos gains.<br/><br/>
<t color='#FFCC00'>IMPORTANT :</t> toutes les licences de métiers s'achètent au PNJ France Travail, situé à Fort-de-France ou à Trinité. Pensez à vous y rendre avant de commencer votre activité.<br/><br/>
<t color='#FFCC00' size='1.05'>Métier Livreur la Poste</t><br/>
Le métier de la poste est souvent l'un des premiers choix des joueurs. Il consiste à effectuer des livraisons à travers toute l'île, en transportant des colis d'un point à un autre. Ce travail est parfait pour explorer la carte, apprendre à vous repérer et découvrir les différentes zones importantes. En plus d'être accessible rapidement, il vous permet de générer un revenu stable sans prendre de risques. C'est aussi une bonne manière de rouler, de vous habituer à la conduite et de croiser d'autres joueurs sur vos trajets.<br/><br/>
<t color='#FFCC00' size='1.05'>Métier d'éboueur</t><br/>
Le métier d'éboueur est tout aussi intéressant pour débuter. Il consiste à parcourir la ville ou certaines zones spécifiques pour ramasser les déchets et les transporter jusqu'aux points de traitement. Ce travail demande un peu de rigueur et de régularité, mais il reste très simple à prendre en main. Il vous permet de gagner de l'argent de manière honnête tout en participant au bon fonctionnement de l'île. Idéal si vous voulez progresser calmement et économiser sans vous mettre dans des situations compliquées.<br/><br/>
<t color='#FFCC00' size='1.05'>Chauffeur de bus</t><br/>
Rendez-vous au dépôt, prenez votre service puis choisissez une ligne de bus. Vous devrez respecter chaque arrêt de la ligne et valider vos passages pour être payé. Chaque arrêt vous rapporte un salaire, avec un bonus à la fin de la ligne complète. C'est un excellent métier pour apprendre les routes principales de l'île tout en transportant les habitants.<br/><br/>
<t color='#FFCC00' size='1.05'>Chauffeur de taxi</t><br/>
Prenez votre service et récupérez votre taxi au point d'emploi. Vous êtes payé tous les 2 km parcourus en conduisant, y compris pendant une course. Environ toutes les 10 minutes, une mission client peut apparaître sur la carte : allez le chercher (zone jaune, arrêt 3 secondes), puis déposez-le à destination (zone verte, arrêt 3 secondes). Vous pouvez aussi transporter les habitants de l'île sur demande. Les habitants peuvent également vous contacter via l'application Uber sur leur téléphone.<br/><br/>
<t color='#FFCC00' size='1.05'>Mineur</t><br/>
Le minage consiste à extraire des pierres précieuses sur l'île (fer, diamant ...). Rendez-vous dans les zones de carrières, utilisez votre pioche pour extraire les roches, puis collectez les pierres obtenues. Vous pouvez ensuite les fondre ou les transformer pour obtenir des matières vendables à la bourse. C'est un métier plus physique, idéal pour ceux qui préfèrent travailler en extérieur et revendre leurs ressources.<br/><br/>
<t color='#FFCC00' size='1.05'>Enedis</t><br/>
Rendez-vous au point d'emploi pour prendre votre service. Vous récupérez un véhicule de service et intervenez sur le réseau électrique de l'île : dépannages, maintenance et missions sur le terrain. C'est un métier idéal si vous aimez conduire, travailler en extérieur et avoir un rôle utile pour la communauté.<br/><br/>
<t color='#FFCC00' size='1.05'>Pêche</t><br/>
Vous pouvez pêcher à la canne à pêche où vous le souhaitez sur l'île : lancez votre ligne, attendez la touche, puis remontez vos prises. Vous pouvez aussi utiliser un filet depuis un bateau pour pêcher en mer. Chaque espèce a une valeur différente : vous pouvez revendre votre poisson aux points de vente prévus. C'est une activité calme et accessible, parfaite pour gagner de l'argent tout en découvrant les côtes et les zones de pêche de l'île.<br/><br/>
<t color='#FFCC00' size='1.05'>SAMU / Ambulanciers</t><br/>
Secours et soins aux blessés. Les ambulanciers prennent en charge les victimes sur place et les transportent vers les structures médicales. Ce métier permet aussi d'effectuer des transports d'organes entre les hôpitaux de l'île, ainsi que d'assister les sapeurs-pompiers sur appel de leur part lors des interventions.<br/><br/>
<t color='#FFCC00' size='1.05'>Pourquoi choisir ces métiers ?</t><br/>
Ces métiers ont un point commun important : ils sont accessibles, sans prérequis compliqué, et offrent une première expérience solide du roleplay. Ils vous permettent de vous faire vos premiers contacts, de comprendre les bases du serveur et surtout de commencer à construire votre personnage. Même s'ils peuvent sembler simples, ils sont essentiels pour poser les bases de votre aventure et économiser pour vos futurs projets.
            "
        ],
        [
            "entreprises",
            "Entreprises",
            "
<t color='#F2B80D' size='1.2'>Les entreprises de l'île</t><br/><br/>
L'économie de Martinique RP repose en grande partie sur les entreprises tenues par les habitants. Il en existe de nombreux types, chacune avec son activité, ses locaux et son équipe. Parmi les exemples que vous croiserez sur l'île :<br/>
• restaurants et bars<br/>
• garages et dépannage<br/>
• sociétés de sécurité<br/>
• concessionnaires<br/>
• distilleries<br/>
• casinos<br/>
• entreprises de ressources (minerais, bois, pêche...)<br/>
• communication et journalisme<br/>
• structures plus spécialisées : armureries, loueurs de véhicules, cabinets d'avocats...<br/><br/>
Pour travailler, acheter, vendre ou simplement vous intégrer, il est essentiel de vous rapprocher des entreprises sur l'île : rendez-vous sur place, échangez avec les responsables et les employés, et renseignez-vous sur leurs besoins. L'intranet peut aussi vous aider à suivre l'actualité des structures ou à postuler, mais le contact direct reste le meilleur moyen de trouver un emploi, un partenariat ou une opportunité. N'hésitez pas à explorer l'île, à frapper aux portes des sociétés qui vous intéressent et à construire votre réseau : c'est souvent ainsi que les meilleures opportunités se présentent sur Martinique RP.
            "
        ],
        [
            "services",
            "Services publics",
            "
<t color='#F2B80D' size='1.2'>Servir l'île</t><br/><br/>
Les services publics assurent la sécurité, l'ordre et les secours sur l'île. Chaque corps a un rôle précis en roleplay. Pour intégrer un service, vous devez postuler sur l'intranet : consultez les offres, envoyez votre candidature et attendez la réponse des responsables.<br/><br/>
<t color='#FFCC00' size='1.05'>Gendarmerie nationale</t><br/>
Force de police chargée de la sécurité publique et des enquêtes. Les gendarmes patrouillent, verbalisent, interpellent et mènent des investigations sur l'ensemble du territoire.<br/><br/>
<t color='#FFCC00' size='1.05'>Police municipale</t><br/>
Police de proximité en ville. Les agents assurent la tranquillité publique, la surveillance des espaces urbains et le contact direct avec les habitants.<br/><br/>
<t color='#FFCC00' size='1.05'>Sapeurs-pompiers</t><br/>
Interviennent sur les incendies, les accidents et les situations d'urgence. Ils protègent les biens et les personnes, souvent en première ligne lors des gros événements.<br/><br/>
<t color='#FFCC00' size='1.05'>DIR (Direction interdépartementale des routes)</t><br/>
Entreprise publique chargée de l'entretien des routes et de la voirie. Les agents interviennent sur les dégradations, ramassent les obstacles et assurent la bonne circulation sur le réseau routier.
            "
        ],
        [
            "touches",
            "Touches",
            "
<t color='#F2B80D' size='1.2'>Touches principales</t><br/><br/>
Cet onglet affiche en jeu une image récapitulative des touches principales du serveur.
            "
        ],
        [
            "intranet",
            "Intranet",
            "
<t color='#F2B80D' size='1.2'>Intranet Martinique RP</t><br/><br/>
L'île met à disposition de tous ses habitants un outil essentiel : l'intranet officiel de Martinique RP. Dès que vous commencez votre aventure, il est fortement recommandé de vous familiariser avec cette plateforme, car elle joue un rôle central dans votre progression et dans votre quotidien sur le serveur.<br/><br/>
<t color='#FFCC00' size='1.05'>Centre de gestion</t><br/>
L'intranet agit comme un véritable centre de gestion personnel. Il regroupe en un seul endroit une grande partie des fonctionnalités dont vous aurez besoin. Vous pouvez communiquer avec la préfecture, faire des demandes ou suivre certaines démarches administratives. C'est aussi ici que sont diffusées les informations importantes : annonces officielles, changements, événements ou décisions impactant la vie des citoyens.<br/><br/>
<t color='#FFCC00' size='1.05'>Réseau social</t><br/>
L'intranet vous permet de rester connecté socialement. Vous avez accès à une plateforme similaire à Twitter, idéale pour suivre l'actualité des habitants, partager des informations ou interagir avec la communauté.<br/><br/>
<t color='#FFCC00' size='1.05'>Données personnelles</t><br/>
Consultez votre compte bancaire, vérifiez vos transactions, voyez les véhicules que vous possédez ou gérez certains aspects de votre patrimoine. C'est un outil indispensable pour garder un œil sur votre situation.<br/><br/>
<t color='#FFCC00' size='1.05'>Communication</t><br/>
Envoyez des mails pour des échanges professionnels ou des contacts avec d'autres joueurs. Certaines démarches importantes passent par ce système : candidatures au service public, demandes officielles ou échanges nécessitant une trace écrite.<br/><br/>
<t color='#FFCC00' size='1.05'>Évoluer sur l'île</t><br/>
Pour rejoindre un métier, lancer un projet, contacter une entreprise ou une organisation, tout passe en grande partie par cet outil. Consultez-le régulièrement afin de ne rien manquer.<br/><br/>
En résumé, l'intranet n'est pas juste une option, c'est un élément clé de votre expérience sur Martinique RP.<br/><br/>
<t color='#FFCC00'>Lien intranet :</t> <a href='https://intranet-martinique-roleplay.fr/dashboard' color='#F2B80D'>https://intranet-martinique-roleplay.fr/dashboard</a>
            "
        ],
        [
            "chemin",
            "Ton chemin",
            "
<t color='#F2B80D' size='1.2'>À toi de choisir ton chemin</t><br/><br/>
Une fois les premières étapes complétées, il est temps de décider de l'avenir de votre personnage. Sur Martinique RP, chaque citoyen trace sa propre route : vos choix définissent votre histoire, vos relations et votre place sur l'île. Il n'y a pas de bon ou de mauvais chemin, seulement celui que vous souhaitez incarner avec cohérence.<br/><br/>
<t color='#FFCC00' size='1.05'>La voie légale</t><br/>
Rejoindre un métier classique, intégrer un service public, travailler dans une entreprise, entrer dans la police ou les secours, ou encore lancer votre propre activité. C'est la voie la plus stable pour progresser, gagner la confiance des habitants et construire une réputation solide sur le long terme.<br/><br/>
<t color='#FFCC00' size='1.05'>La voie illégale</t><br/>
Trafics, organisations, braquages ou activités clandestines. Cette voie est plus risquée et demande une vraie implication en roleplay. Chaque action a des conséquences : la gendarmerie, les rivalités et les erreurs peuvent vite vous rattraper. À vous de peser les risques avant de vous lancer.<br/><br/>
<t color='#FFCC00' size='1.05'>La voie neutre</t><br/>
Rester entre les deux mondes, être opportuniste et vous adapter aux situations. Vous pouvez alterner entre activités légales et choix plus douteux selon les opportunités et les personnes que vous croisez. C'est une approche flexible, idéale pour un personnage complexe et imprévisible.<br/><br/>
<t color='#FFCC00' size='1.05'>Conseils importants</t><br/>
Quel que soit votre choix, restez cohérent avec votre personnage et respectez le roleplay des autres joueurs. Votre réputation se construit au fil du temps : soyez patient, impliqué et fair-play. Si vous avez besoin d'aide ou de conseils, n'hésitez pas à vous rendre sur <t color='#FFCC00'>TeamSpeak</t> ou <t color='#FFCC00'>Discord</t> : la communauté et le staff sont là pour vous accompagner dans votre aventure.
            "
        ]
    ];
};

MRP_Tuto_Config
