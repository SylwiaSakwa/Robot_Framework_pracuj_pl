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

Wybranie przycisku "Zarejestruj sie"
    Click element   ${zarejestruj_sie}
    Sleep   5

Wpisanie poprawnego adresu e-mail  
    Input text   ${e_mail_input}   ${e_mail_correct} 
              
Wpisanie adresu e-mail bez @
    Input text   ${e_mail_input}   ${e_mail_without_@}  
        
Wpisanie adresu e-mail bez domeny
    Input text   ${e_mail_input}   ${e_mail_without_domain}
    
Wpisanie niepoprawnego adresu e-mail
    Input text   ${e_mail_input}   ${e_mail_incorrect}
    
Wpisanie adresu e-mail z niepoprawna struktura
    Input text   ${e_mail_input}   ${e_mail_incorrect_structure}
    
Wpisanie adresu e-mail z polskimi znakami
    Input text   ${e_mail_input}   ${e_mail_polish_characters}
    
Wpisanie adresu e-mail z duzych liter
    Input text   ${e_mail_input}   ${e_mail_big_characters}
    
Wpisanie istniejacego adresu e-mail istniejacego juz konta
    Input text   ${e_mail_input}   ${e_mail_exist}
    
Wpisanie adresu e-mail z przecinkiem w domenie
    Input text   ${e_mail_input}   ${e_mail_comma_domain}
    
Wpisanie adresu e-mail z przecinkiem
    Input text   ${e_mail_input}   ${e_mail_comma}
    
      
Wpisanie poprawnego hasla
    Input text   ${passwords_input}   ${password}
    Sleep   2
      
Wpisanie za krotkiego hasla   
    Input text   ${passwords_input}   ${too_short_password}
    Sleep   2
   
Zaznaczenie checkboxow
    Click element    //*[@id="app"]/div/div[1]/div[2]/form/label/span[1]
    Click element    //*[@id="app"]/div/div[1]/div[2]/form/div[3]/label[1]/span[1]
    Click element    //*[@id="app"]/div/div[1]/div[2]/form/div[3]/label[2]/span[1]
    Click element    //*[@id="app"]/div/div[1]/div[2]/form/div[3]/label[3]/span[1]

    
Klikniecie przycisku "Zarejestruj sie"
    Click element    //*[@id="app"]/div/div[1]/div[2]/form/button
    Sleep   5 
    
      
Sprawdzenie czy uzytkownik sie zarejestrowal
    Page should contain    Sprawdź pocztę
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez @
    Element should contain    ${form_control_error_email}    Please include an '@' in the email address. '${e_mail_without_@}' is missing an '@'.
    Capture Page Screenshot   

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez domeny
    Element should contain    ${form_control_error_email}    Please enter a part following '@'. '${e_mail_without_domain}' is incomplete.
    Capture Page Screenshot
 
Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail
    Page should contain    Niepoprawny format adresu e-mail
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnej strukturze adresu e-mail
    Element should contain    ${form_control_error_email}    Please enter a part followed by '@'. '${e_mail_incorrect_structure}' is incomplete.
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o polskich znakach
    Element should contain    ${form_control_error_email}    A part followed by '@' should not contain the symbol 
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o istniejacym juz koncie
    Page should contain    Przejdź do logowania. Masz już konto pod tym adresem e-mail. 
    Capture Page Screenshot
    
Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku w domenie   
    Element should contain    ${form_control_error_email}    A part following '@' should not contain the symbol ','.
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku
    Element should contain    ${form_control_error_email}    A part followed by '@' should not contain the symbol ','.
    Capture Page Screenshot
  
Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu e-mail 
    Element should contain    ${form_control_error_email}    Please fill out this field.
    Capture Page Screenshot
  
Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na haslo
    Element should contain   ${form_control_error_password}   Please fill out this field.
    Capture Page Screenshot
    
Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo   
    Element should contain    ${form_control_error_email}    Please fill out this field.
    Element should contain    ${form_control_error_password}    Please fill out this field.
    Capture Page Screenshot
    
Sprawdzenie czy uzytkownik otrzymal komunikat o za krotkim hasle
    Page should contain    Za krótkie hasło. Wpisz min. 6 znaków
    Page should contain    Hasło musi zawierać min. 6 znaków. Żeby hasło było silne, użyj przynajmniej jednej cyfry i wielkiej litery.
    Capture Page Screenshot
   
Sprawdzenie czy uzytkownik otrzymal komunikat o niezaznaczonym checkboxie
    Element should contain    ${checkbox_info}    Please check this box if you want to proceed.
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo i niezaznaczonym checkboxie
    Element should contain    ${form_control_error_email}    Please fill out this field.
    Element should contain    ${form_control_error_password}    Please fill out this field.
    Element should contain    ${checkbox_info}    Please check this box if you want to proceed.
    Capture Page Screenshot

    
Zamkniecie przegladarki
    Close all browsers



*** Variables ***



${host}   https://www.pracuj.pl/
${browser}   chrome
${RODO}   //button[contains(text(),'Akceptuj')]
${moje_konto_button}   //*[@class='size-small variant-primary header_b1fqykql']
${zarejestruj_sie}      //*[@class='size-medium variant-secondary header_b1fqykql']
${e_mail_input}    //*[@class='form-control__input' and @type='email']
${passwords_input}    //*[@class='form-control__input' and @type='password']
${button_zarejestruj_sie}   //*[@class='account-details__button-submit']
${e_mail_correct}   tester.testerski12344454674489@int.pl
${e_mail_without_@}   tester.testerskiint.com
${e_mail_without_domain}    tester.testerski@
${e_mail_incorrect}    tester.testerski@intpl
${e_mail_incorrect_structure}    @gmail.com
${e_mail_polish_characters}    ędwardącki@gmail.com
${e_mail_big_characters}    	TESTER.TESTERSKI84648444664645@INT.PL
${e_mail_exist}    tester.testerski@int.pl
${e_mail_comma_domain}    tester.testerski@int,pl
${e_mail_comma}    tester,testerski@int.pl
${password}    tester1
${too_short_password}    qwert
${form_control_error_email}    //*[@id="app"]/div/div[1]/div[2]/form/div[1]/div/div[2]
${form_control_error_password}    //*[@id="app"]/div/div[1]/div[2]/form/div[2]/div/div[2]
${checkbox_info}    //*[@id="app"]/div/div[1]/div[2]/form/label/span[2]/span[2]


*** Test Cases ***


    
Test 1 - Poprawna rejestracja uzytkownika na www.pracuj.pl
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik sie zarejestrowal
    Zamkniecie przegladarki

Test 2 - Rejestracja niepoprawnym adresem e-mail bez @
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail bez @
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez @
    Zamkniecie przegladarki
    
Test 3 - Rejestracja niepoprawnym adresem e-mail bez nazwy domeny
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail bez domeny
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez domeny
    Zamkniecie przegladarki
    
Test 4 - Rejestracja niepoprawnym adresem e-mail
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie niepoprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail
    Zamkniecie przegladarki
    
Test 5 - Rejestracja adresem e-mail z niepoprawna struktura
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail z niepoprawna struktura
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnej strukturze adresu e-mail
    Zamkniecie przegladarki
    
Test 6 - Rejestracja adresem e-mail z polskimi znakami
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail z polskimi znakami
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o polskich znakach
    Zamkniecie przegladarki
    
Test 7 - Rejestracja adresem e-mail z duzych liter
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail z duzych liter
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik sie zarejestrowal
    Zamkniecie przegladarki
    
Test 8 - Rejestracja istniejacym juz adresem e-mail
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie istniejacego adresu e-mail istniejacego juz konta
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o istniejacym juz koncie
    Zamkniecie przegladarki
    
Test 9 - Rejestracja adresem e-mail z przecinkiem w domenie
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail z przecinkiem w domenie
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku w domenie
    Zamkniecie przegladarki
    
Test 10 - Rejestracja adresem e-mail z przecinkiem
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie adresu e-mail z przecinkiem
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku
    Zamkniecie przegladarki
  
Test 11 - Rejestracja z pustym polem na adres e-mail 
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie" 
    Wpisanie poprawnego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu e-mail
    Zamkniecie przegladarki
    
Test 12 - Rejestracja z pustym polem na haslo
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie poprawnego adresu e-mail 
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na haslo
    Zamkniecie przegladarki
    
Test 13 - Rejestracja z pustym polem na adres e-mail oraz haslo
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo
    Zamkniecie przegladarki
    
Test 14 - Rejestracja z za krotkim haslem
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie za krotkiego hasla
    Zaznaczenie checkboxow
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o za krotkim hasle
    Zamkniecie przegladarki

Test 15 - Rejestracja z niezaznaczeniem wymaganego checkboxa
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niezaznaczonym checkboxie
    Zamkniecie przegladarki

Test 16 - Rejestracja z pustym polem na adres e-mail oraz haslo i z niezaznaczeniem wymaganego checkboxa
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zarejestruj sie"
    Klikniecie przycisku "Zarejestruj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo i niezaznaczonym checkboxie
    Zamkniecie przegladarki


  

