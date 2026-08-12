/*
    Author: Yuri Zoko
    Web site: www.the-programmer.com
    Discord: discord.the-programmer.com

    Terms of use:
      - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
      - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
      - Out of respect for the author please do not delete this information.
*/
#define true 1
#define false 0

class The_Programmer_Credit_System {
    default_lang = "fr"; // fr / en / de / es

    textures_base_path = "The-Programmer\Credit_System\textures";
    tonic_version = 5; // 5 if you are on version 5.0 or 4 if you are on version 4.X

    credit_to_bank_account = true; // Receive credit money to bank account.

    /* Debit for payment for the credit */
    bank_debit = 4; // The person pay his credit in X debits
    delay_debit = 24; // Every X hours, the player will be debited
    // With the default settings, every 24 hours during 4 days, the player will pay a part of his credit

    /* Error on credit payment */
    incident_maximum = 3; // Max incidents (per credit) before blacklist the player
    incident_multiplicator = 0.10; // Penalty (out of the total) in case of an incident

    /* Deliver credits conditions */
    min_interest = 5; // Minimum interest in % ; 5% = the price of the credit in interest -> amount to pay = 105% of the amount of the credit
    max_interest = 100; // Maximum interest in % ; 100% = the price of the credit in interest -> amount to pay = 200% of the amount of the credit
    create_credit_for_himself = true; // The creditor can create a loan for himself

    /* Vehicles shop */
    vehicle_shop[] = { "B_Quadbike_01_F", "C_Hatchback_01_F", "C_Offroad_01_F", "C_SUV_01_F", "C_Hatchback_01_sport_F", "C_Van_01_transport_F", "C_Offroad_02_unarmed_F" }; // Vehicle that can be bought with the credit

    class society {
        class society_1 {
            title_name = "The-Programmer Credit";
            bankacc = 50000;
            condition = "license_civ_driver";
        };

        class society_2 {
            title_name = "Zoko Credit";
            bankacc = 50000;
            condition = "";
        };
    };
};
