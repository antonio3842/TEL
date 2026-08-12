/*
    Author: Robert
    Web site: www.the-programmer.com
    Discord: https://discord.the-programmer.com

    Terms of use:
        - This file is forbidden unless you have permission from the author. If you have this file without permission to use it please do not use it and do not share it.
        - If you have permission to use this file, you can use it on your server however it is strictly forbidden to share it.
        - Out of respect for the author please do not delete this information.
*/
#define true 1
#define false 0

class The_Programmer_BankingSystem {
    default_lang = "fr"; // fr / en / de
    devise = "€";

    cashVariable = "life_cash";  // Name of the variable that give the cash
    bankVariable = "life_atmbank"; // Name of the variable that give the bank

    textures_base_path = "The-Programmer\BankingSystem\textures";

    tax_rate = 0.05;
    /*
        tax_rate :
            If Territory Conquest is installed, this setting will have no influence: the tax will be determined by the gang that owns the territory and the gang will receive the tax money.
            If Government System is installed, the tax will be sent to the government account.
            If neither script is installed, the tax money will be deleted.
            --> Put 0 if you don't want a tax
    */

    interest_reboot_or_not = true; //If enabled, interest is added at server startup
    time_interest = 60; //Only if interest_reboot_or_not is set to false, time in minutes before interest is added

    money_log = true; // If you want basics withdraw / depostit / transfert livret logs
    
    // <!> This option is only available is code is either needed in atm or bank.
    display_terminal = true; // if you want to have the terminal displayed when paying with credit card in shops. 

    class atm {
        is_code_needed = true; // If you want to open the atm with a PIN code
        auto_login_time = 60; // Time during which you are connected after opening an atm

        item_type = "virtual"; // virtual ou physical
        card_object = ""; //Object to pay with the card and open the atm

        card_required_open_atm = true;

        cardTax = 0.10; //Credit card payment fees. 0.10 = 10% tax

        maximum_player_deposit = -1; // -1 = unlimited
        maximum_player_withdraw = -1; // -1 = unlimited
        maximum_gang_deposit = -1; // -1 = unlimited
        maximum_gang_withdraw = -1; // -1 = unlimited

        logo = "The-Programmer\BankingSystem\textures\atm\logo.paa"; // LOGO NEED TO BE 128*128 ()
    };

    class bank {
        is_code_needed = true; // If you want to open the bank menu with a PIN code
        auto_login_time = 300; // Time during which you are connected after opening the bank

        max_livret_A = 50000; //Maximum amount of money that can be deposited in the livret A
        max_livret_B = 10000; //Maximum amount of money that can be deposited in the livret B
        max_livret_C = 100000; //Maximum amount of money that can be deposited in the livret C

        open_A = 1000; // Price to create a livret
        open_B = 3000;
        open_C = 5000;

        code_price_reset = 5000; // Price to recreate your code

        interets_livret_A = 1.05; // Interests, 10% = 1.10
        interets_livret_B = 1.10; // Interests, 50% = 1.50
        interets_livret_C = 1.15; // Interests, 2% = 1.02
    };
};
