*** Settings ***


Library   RequestsLibrary
Library   Collections
Library   SSHLibrary
Library   SeleniumLibrary


*** Keywords ***



Otwarcie strony pracuj.pl w przegladarce
    Open browser   ${host}   ${browser}   options=add_argument("--disable-popup-blocking"); add_argument("--ignore-certificate-errors")
    Set Window Position   60   5
    Set Window Size   1865   965  

Klikniecie w przycisk "Moje konto"
    Sleep   5
    Click element   ${RODO}
    Sleep   2
    Click element   ${moje_konto_button}
    Sleep   2

Wybranie przycisku "Zaloguj sie"
    Click element   ${zaloguj_sie}
    Sleep   5

Wpisanie poprawnego adresu e-mail  
    Input text   ${e_mail_input}   ${e_mail_correct}  
                   
Wpisanie poprawnego hasla
    Input text   ${passwords_input}   ${password}
    Sleep   2
         
Klikniecie przycisku "Zaloguj sie"
    Click element    ${button_zaloguj}
    Sleep   8
        
Sprawdzenie czy uzytkownik sie zalogowal
    Page should contain    Rekomendowane oferty
    Capture Page Screenshot

Wyszukanie ofert pracy
    Click element    ${oferty_pracy_button}
    Sleep   3
    Click element     //*[@id="relative-wrapper"]/div[2]/div[2]/div[1]/div[1]/div/div[1]/div[2]/div/div/div[1]/span[2]/div/span[1]
    Click element     //*[@id="relative-wrapper"]/div[2]/div[2]/div[1]/div[1]/div/div[1]/div[2]/div/div/div[3]/span[2]/div/span[1]
    Input text    //*[@id="relative-wrapper"]/div[1]/div/div/div/div[1]/div[1]/div/div/div/input    tester oprogramowania
    Input text    //*[@id="relative-wrapper"]/div[1]/div/div/div/div[1]/div[3]/div/div[1]/div/input    Katowice
    Sleep   2
    Click element    //*[@id="relative-wrapper"]/div[1]/div/div/div/div[2]/div/button

Sprawdzenie czy wyszukano oferty pracy
    Page should contain    Tester
    Capture Page Screenshot

Zamkniecie przegladarki
    Close all browsers



*** Variables ***



${host}   https://www.pracuj.pl/
${browser}   chrome
${RODO}   //button[contains(text(),'Akceptuj')]
${moje_konto_button}   //*[@class='size-small variant-primary header_b1fqykql']
${zaloguj_sie}   //*[@class='main-button size-medium variant-primary header_b1fqykql']              
${e_mail_input}   //*[@class='form-control__input' and @type='email']
${passwords_input}    //*[@class='form-control__input' and @type='password']          
${button_zaloguj}   //*[@class='actions__submit']
${e_mail_correct}    tester.testerski@int.pl
${password}   tester1
${oferty_pracy_button}   //*[@id="pracuj_header"]/div/header/div[1]/div/nav/a[1]/span   



*** Test Cases ***



Test 1 - Poprawne logowanie uzytkownika na www.pracuj.pl
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik sie zalogowal
    Wyszukanie ofert pracy
    Sprawdzenie czy wyszukano oferty pracy
    Zamkniecie przegladarki


    

  

