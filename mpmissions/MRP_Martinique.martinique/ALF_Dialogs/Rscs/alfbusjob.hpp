/*
    File: alfbusjob.hpp
    Auteur: MRP
    Description: Dialog F5 BusJob - menu moderne style Martinique RP
    
    À inclure dans : MRP_Martinique.martinique/ALF_Dialogs/CfgGameUserInterface.hpp
    Ligne à ajouter : #include "Rscs\alfbusjob.hpp"
*/

class ALF_BusJob_Menu
{
    idd = 9901;
    movingEnable = false;
    enableSimulation = true;
    duration = 1e10;
    fadeIn = 0.15;
    onLoad = "[] spawn ALF_fnc_busjob_onMenuLoad;";
    onUnload = "[] call ALF_fnc_busjob_onMenuUnload;";

    class controls
    {
        // ── Fond principal ────────────────────────────────────────────────
        class BG : RscText
        {
            idc = -1;
            x = 0.11; y = 0.08;
            w = 0.78; h = 0.84;
            colorBackground[] = { 0.04, 0.05, 0.10, 0.97 };
            text = "";
        };

        // ── Barre de couleur (accent top) ─────────────────────────────────
        class AccentTop : RscText
        {
            idc = -1;
            x = 0.11; y = 0.08;
            w = 0.78; h = 0.004;
            colorBackground[] = { 0.95, 0.72, 0.05, 1.0 };
            text = "";
        };

        // ── Barre laterale gauche ─────────────────────────────────────────
        class AccentLeft : RscText
        {
            idc = -1;
            x = 0.11; y = 0.08;
            w = 0.004; h = 0.84;
            colorBackground[] = { 0.95, 0.72, 0.05, 0.5 };
            text = "";
        };

        // ── Titre ─────────────────────────────────────────────────────────
        class Titre : RscText
        {
            idc = -1;
            x = 0.138; y = 0.092;
            w = 0.50; h = 0.032;
            text = "CHAUFFEUR DE BUS";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.95, 0.72, 0.05, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            style = 0;
            shadow = 0;
        };

        // ── Sous-titre ────────────────────────────────────────────────────
        class SousTitre : RscText
        {
            idc = -1;
            x = 0.138; y = 0.126;
            w = 0.50; h = 0.022;
            text = "Réseau de Transport — Martinique RP";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.55, 0.60, 0.75, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            style = 0;
            shadow = 0;
        };

        // ── Séparateur header ──────────────────────────────────────────────
        class SepHeader : RscText
        {
            idc = -1;
            x = 0.11; y = 0.170;
            w = 0.78; h = 0.002;
            colorBackground[] = { 0.95, 0.72, 0.05, 0.30 };
            text = "";
        };

        // ── Label section ─────────────────────────────────────────────────
        class LabelLignes : RscText
        {
            idc = -1;
            x = 0.138; y = 0.180;
            w = 0.35; h = 0.022;
            text = "CHOISIR UNE LIGNE";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.95, 0.72, 0.05, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            style = 0;
            shadow = 0;
        };

        // ── Stats service (affiché si en service) ─────────────────────────
        class LabelStats : RscText
        {
            idc = 9950;
            x = 0.400; y = 0.178;
            w = 0.475; h = 0.022;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.20, 0.85, 0.45, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            style = 2; // centré
            shadow = 0;
        };

        // ═══════════════════════════════════════════════════════════════════
        //  BOUTONS LIGNES (idc 9911 à 9916)
        // ═══════════════════════════════════════════════════════════════════

        // ── Ligne 1 ───────────────────────────────────────────────────────
        class BtnL1 : RscButton
        {
            idc = 9911;
            x = 0.122; y = 0.210;
            w = 0.756; h = 0.080;
            text = "Fort-de-France - Le Marin";
            font = "PuristaMedium";
            SizeEx = 0.032;
            style = 2;
            colorText[] = { 0.88, 0.92, 1.0, 1.0 };
            colorBackground[] = { 0.08, 0.12, 0.22, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.22, 0.40, 1.0 };
            colorFocused[] = { 0.14, 0.22, 0.40, 1.0 };
            colorBorder[] = { 0.95, 0.72, 0.05, 0.25 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0;
            offsetY = 0;
            offsetPressedX = 0;
            offsetPressedY = 0;
            action = "[""fdf_marin""] call ALF_fnc_busjob_selectLigne;";
        };
        // Icône ligne 1 (barre colorée gauche)
        class BtnL1Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.210;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.95, 0.80, 0.05, 1.0 };
            text = "";
        };

        // ── Ligne 2 ───────────────────────────────────────────────────────
        class BtnL2 : RscButton
        {
            idc = 9912;
            x = 0.122; y = 0.300;
            w = 0.756; h = 0.080;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.88, 0.92, 1.0, 1.0 };
            colorBackground[] = { 0.08, 0.12, 0.22, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.22, 0.40, 1.0 };
            colorFocused[] = { 0.14, 0.22, 0.40, 1.0 };
            colorBorder[] = { 0.10, 0.45, 0.90, 0.25 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "[""trinite_fdf""] call ALF_fnc_busjob_selectLigne;";
        };
        class BtnL2Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.300;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.10, 0.55, 0.95, 1.0 };
            text = "";
        };

        // ── Ligne 3 ───────────────────────────────────────────────────────
        class BtnL3 : RscButton
        {
            idc = 9913;
            x = 0.122; y = 0.390;
            w = 0.756; h = 0.080;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.88, 0.92, 1.0, 1.0 };
            colorBackground[] = { 0.08, 0.12, 0.22, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.22, 0.40, 1.0 };
            colorFocused[] = { 0.14, 0.22, 0.40, 1.0 };
            colorBorder[] = { 0.15, 0.80, 0.35, 0.25 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "[""fdf_trinite""] call ALF_fnc_busjob_selectLigne;";
        };
        class BtnL3Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.390;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.15, 0.85, 0.35, 1.0 };
            text = "";
        };

        // ── Ligne 4 ───────────────────────────────────────────────────────
        class BtnL4 : RscButton
        {
            idc = 9914;
            x = 0.122; y = 0.480;
            w = 0.756; h = 0.080;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.88, 0.92, 1.0, 1.0 };
            colorBackground[] = { 0.08, 0.12, 0.22, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.22, 0.40, 1.0 };
            colorFocused[] = { 0.14, 0.22, 0.40, 1.0 };
            colorBorder[] = { 0.90, 0.45, 0.05, 0.25 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "[""trinite_grandriviere""] call ALF_fnc_busjob_selectLigne;";
        };
        class BtnL4Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.480;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.95, 0.50, 0.05, 1.0 };
            text = "";
        };

        // ── Ligne 5 ───────────────────────────────────────────────────────
        class BtnL5 : RscButton
        {
            idc = 9915;
            x = 0.122; y = 0.570;
            w = 0.756; h = 0.080;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.88, 0.92, 1.0, 1.0 };
            colorBackground[] = { 0.08, 0.12, 0.22, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.22, 0.40, 1.0 };
            colorFocused[] = { 0.14, 0.22, 0.40, 1.0 };
            colorBorder[] = { 0.85, 0.15, 0.15, 0.25 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "[""trinite_vauclin""] call ALF_fnc_busjob_selectLigne;";
        };
        class BtnL5Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.570;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.90, 0.15, 0.15, 1.0 };
            text = "";
        };

        // ── Ligne 6 — EN CONSTRUCTION ─────────────────────────────────────
        class BtnL6 : RscButton
        {
            idc = 9916;
            x = 0.122; y = 0.660;
            w = 0.756; h = 0.080;
            text = "";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.40, 0.43, 0.50, 1.0 };
            colorBackground[] = { 0.06, 0.07, 0.12, 0.85 };
            colorBackgroundActive[] = { 0.06, 0.07, 0.12, 0.85 };
            colorFocused[] = { 0.06, 0.07, 0.12, 0.85 };
            colorBorder[] = { 0.30, 0.32, 0.38, 0.20 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "['busjob_wip'] call ALF_fnc_busjob_selectLigne;";
        };
        class BtnL6Bar : RscText
        {
            idc = -1;
            x = 0.122; y = 0.660;
            w = 0.005; h = 0.080;
            colorBackground[] = { 0.40, 0.43, 0.50, 0.50 };
            text = "";
        };

        // ── Séparateur bas ─────────────────────────────────────────────────
        class SepBottom : RscText
        {
            idc = -1;
            x = 0.11; y = 0.752;
            w = 0.78; h = 0.002;
            colorBackground[] = { 0.95, 0.72, 0.05, 0.20 };
            text = "";
        };

        // ── Bouton TERMINER ────────────────────────────────────────────────
        class BtnTerminer : RscButton
        {
            idc = 9920;
            x = 0.122; y = 0.762;
            w = 0.28; h = 0.048;
            text = "TERMINER SERVICE";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 1.0, 0.30, 0.20, 1.0 };
            colorBackground[] = { 0.16, 0.04, 0.04, 0.92 };
            colorBackgroundActive[] = { 0.26, 0.06, 0.06, 1.0 };
            colorFocused[] = { 0.26, 0.06, 0.06, 1.0 };
            colorBorder[] = { 0.80, 0.15, 0.10, 0.35 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "closeDialog 2; [] call ALF_fnc_busjob_endService;";
        };

        // ── Bouton FERMER ──────────────────────────────────────────────────
        class BtnFermer : RscButton
        {
            idc = 9921;
            x = 0.738; y = 0.762;
            w = 0.14; h = 0.048;
            text = "FERMER";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.55, 0.62, 0.78, 1.0 };
            colorBackground[] = { 0.08, 0.10, 0.18, 0.92 };
            colorBackgroundActive[] = { 0.14, 0.18, 0.30, 1.0 };
            colorFocused[] = { 0.14, 0.18, 0.30, 1.0 };
            colorBorder[] = { 0.95, 0.72, 0.05, 0.20 };
            borderSize = 0.001;
            shadow = 0;
            offsetX = 0; offsetY = 0;
            offsetPressedX = 0; offsetPressedY = 0;
            action = "closeDialog 2;";
        };

        // ── Texte info bas ─────────────────────────────────────────────────
        class InfoBas : RscText
        {
            idc = -1;
            x = 0.11; y = 0.820;
            w = 0.78; h = 0.018;
            text = "Fermez ce menu (Echap) — repassez au gerant pour « Choix des lignes »";
            font = "PuristaMedium";
            SizeEx = 0.032;
            colorText[] = { 0.25, 0.28, 0.35, 1.0 };
            colorBackground[] = { 0, 0, 0, 0 };
            style = 2;
            shadow = 0;
        };

        // ── Barre de couleur (accent bottom) ──────────────────────────────
        class AccentBottom : RscText
        {
            idc = -1;
            x = 0.11; y = 0.920;
            w = 0.78; h = 0.003;
            colorBackground[] = { 0.95, 0.72, 0.05, 0.25 };
            text = "";
        };
    };
};
