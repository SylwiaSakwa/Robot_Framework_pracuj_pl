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
    
Wpisanie niepoprawnego hasla
    Input text   ${passwords_input}   ${password_incorrect}
    Sleep   2
   
       
Klikniecie przycisku "Zaloguj sie"
    Click element    ${button_zaloguj}
    Sleep   8
      
    
Sprawdzenie czy uzytkownik sie zalogowal
    Page should contain    Rekomendowane oferty
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez @
    Element should contain    ${form_control_error_email}    Please include an '@' in the email address. '${e_mail_without_@}' is missing an '@'.
    Capture Page Screenshot   

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez domeny
    Element should contain    ${form_control_error_email}    Please enter a part following '@'. '${e_mail_without_domain}' is incomplete.
    Capture Page Screenshot
 
Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail
    Page should contain    Możliwe, że nie potwierdziłeś swojego konta lub 3 razy użyłeś złego hasła. Sprawdź pocztę lub spróbuj później.
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnej strukturze adresu e-mail
    Element should contain    ${form_control_error_email}    Please enter a part followed by '@'. '${e_mail_incorrect_structure}' is incomplete.
    Capture Page Screenshot

Sprawdzenie czy uzytkownik otrzymal komunikat o polskich znakach
    Element should contain    ${form_control_error_email}    A part followed by '@' should not contain the symbol 
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
    Element should contain    ${form_control_error_password}    Please fill out this field.
    Capture Page Screenshot
 
Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo
    Element should contain    ${form_control_error_email}    Please fill out this field.
    Element should contain    ${form_control_error_password}    Please fill out this field.
    Capture Page Screenshot
    
Sprawdzenie czy uzytkownik otrzymal komunikat o nieprawidlowym hasle
    Page should contain    Możliwe, że nie potwierdziłeś swojego konta lub 3 razy użyłeś złego hasła. Sprawdź pocztę lub spróbuj później.
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
${e_mail_without_@}   tester.testerskiint.pl
${e_mail_without_domain}    tester.testerski@
${e_mail_incorrect}    tester.testerski@intpl
${e_mail_incorrect_structure}    @int.pl
${e_mail_polish_characters}    ędwardącki@gmail.com
${e_mail_big_characters}    	TESTER.TESTERSKI@INT.PL
${e_mail_exist}    tester.testerski@int.pl
${e_mail_comma_domain}    tester.testerski@int,pl
${e_mail_comma}    tester,testerski@int.pl
${password}   tester1
${password_incorrect}   qwer
${form_control_error_email}    //*[@id="app"]/div/div[1]/div[2]/form/div[1]/div/div[2]
${form_control_error_password}    //*[@id="app"]/div/div[1]/div[2]/form/div[2]/div/div[2]



*** Test Cases ***


Test 1 - Poprawne logowanie uzytkownika na www.pracuj.pl
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik sie zalogowal
    Zamkniecie przegladarki

Test 2 - Logowanie niepoprawnym adresem e-mail bez @
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail bez @
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez @
    Zamkniecie przegladarki
    
Test 3 - Logowanie niepoprawnym adresem e-mail bez nazwy domeny
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail bez domeny
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail bez domeny
    Zamkniecie przegladarki
    
Test 4 - Logowanie niepoprawnym adresem e-mail
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie niepoprawnego adresu e-mail
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnym adresie e-mail
    Zamkniecie przegladarki
    
Test 5 - Logowanie adresem e-mail z niepoprawna struktura
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail z niepoprawna struktura
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o niepoprawnej strukturze adresu e-mail
    Zamkniecie przegladarki
    
Test 6 - Logowanie adresem e-mail z polskimi znakami
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail z polskimi znakami
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o polskich znakach
    Zamkniecie przegladarki
    
Test 7 - Logowanie adresem e-mail z duzych liter
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail z duzych liter
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik sie zalogowal
    Zamkniecie przegladarki
      
Test 8 - Logowanie adresem e-mail z przecinkiem w domenie
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail z przecinkiem w domenie
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku w domenie
    Zamkniecie przegladarki
    
Test 9 - Logowanie adresem e-mail z przecinkiem
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie adresu e-mail z przecinkiem
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o przecinku
    Zamkniecie przegladarki
 
Test 10 - Logowanie z pustym polem na adres e-mail 
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie poprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu e-mail
    Zamkniecie przegladarki

Test 11 - Logowanie z pustym polem na haslo
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie poprawnego adresu e-mail
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na haslo
    Zamkniecie przegladarki

Test 12 - Logowanie z pustym polem na adres e-mail oraz haslo
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o pustym polu na e-mail oraz haslo
    Zamkniecie przegladarki
  
Test 13 - Logowanie z nieprawidlowym haslem
    Otwarcie strony pracuj.pl w przegladarce
    Klikniecie w przycisk "Moje konto"
    Wybranie przycisku "Zaloguj sie"
    Wpisanie poprawnego adresu e-mail
    Wpisanie niepoprawnego hasla
    Klikniecie przycisku "Zaloguj sie"
    Sprawdzenie czy uzytkownik otrzymal komunikat o nieprawidlowym hasle
    Zamkniecie przegladarki
