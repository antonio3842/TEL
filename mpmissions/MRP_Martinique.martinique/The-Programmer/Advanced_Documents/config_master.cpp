/* Copyright 2023 - Association Get Your Path. All rights reserved */
#define true 1
#define false 0

class Documents {
    default_lang = "fr"; // fr / en / de / es

    textures_base_path = "The-Programmer\Advanced_Documents\textures";

    allow_to_create_self_document = false; // The player can create a document for himself
    allow_to_create_copy_of_copy = false; // The player that received a copy can send a copy of the original document to another player

    class types_documents { // Add your own classes below :
        class weaponLicense {
            displayName = "Permis de port d'arme"; // FR : "Permis de port d'arme" // EN : "Weapon License" // DE : "Waffenlizenz" // ES : "Licencia de armas"
            type = "Official Certificate"; // Classname in localization for document type

            condition = life_publique_service; // Condition to create this document

            texture = "document.paa"; // Texture for document
            logo = "logo_civ.paa"; // Logo in document
            signature = "sign.paa"; // Signature in document

            force_duration = -1; // Number of days of validy for this document, it cannot be changed by the players. Put -1 to tell them choose the duration
            min_duration = 30; // Minimum duration that the user can choose
            max_duration = 180; // Maximum duration that the user can choose (-1 = unlimited)
        };

        class parking {
            displayName = "Dérogation de stationnement"; // FR : "Dérogation de stationnement" // EN : "Parking exemption" // DE : "Parkbefreiung" // ES : "Exención de estacionamiento"
            type = "Certificat officiel du Gouvernement";

            condition = "";

            texture = "document.paa";
            logo = "logo_west.paa";
            signature = "sign.paa";

            force_duration = -1;
            min_duration = 0;
            max_duration = -1;
        };

        class medCertificate {
            displayName = "Certificat Médical"; // FR : "Certificat Médical" // EN : "Medical certificate" // DE : "Ärztliches Attest" // ES : "Certificado médico"
            type = "Certificat officiel du Ministère de la Santé";

            condition = "";

            texture = "document.paa";
            logo = "logo_guer.paa";
            signature = "sign.paa";

            force_duration = -1;
            min_duration = 7;
            max_duration = -1;
        };

        class medCannabis {
            displayName = "Autorisation d'utiliser de la marijuana médicale"; // FR : "Autorisation d'utiliser de la marijuana médicale" // EN : "Authorization to use medical marijuana" // DE : "Genehmigung zur Verwendung von medizinischem Marihuana" // ES : "Autorización para usar marihuana medicinal"
            type = "Certificat officiel du Ministère de la Santé";

            condition = "";

            texture = "document.paa";
            logo = "logo_guer.paa";
            signature = "sign.paa";

            force_duration = 30;
            min_duration = 0;
            max_duration = 60;
        };

        class debt {
            displayName = "Reconnaissance de dette"; // FR : "Reconnaissance de dette" // EN : "Acknowledgment of debt" // DE : "Anerkennung von Schulden" // ES : "Reconocimiento de deuda"
            type = "Document écrit par un Citoyen";

            condition = "";

            texture = "document.paa";
            logo = "logo_civ.paa";
            signature = "sign.paa";

            force_duration = 15;
            min_duration = 0;
            max_duration = -1;
        };
    };
};
