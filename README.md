# grenoble-inp-calendar-auth

This application allows you to fetch the Grenoble INP calendar directly and use it in services like Google Calendar.

The URL exported by the Grenoble INP calendar service cannot be used directly because it requires a login. Google Calendar does not support login for calendars. This application allows you to log in and create your own calendar URL, which you can then use.

## Usage Guide
There are three environment variables:
- `USERNAME`: your grenoble-inp username.
- `PASSWORD`: your grenoble-inp password.
- `URL`: the calendar URL, e.g., https://edt.grenoble-inp.fr/directCal/2024-2025/etudiant/ensimag?resources=20016,20066,20021,20010,20046.

To obtain the URL, follow this guide: [Online Timetables with ADE (Ensiwiki)](https://ensiwiki.ensimag.fr/index.php?title=Emplois_du_temps_en_ligne_avec_ADE#Importation_par_URL_avec_un_client_lourd_de_calendrier_.28e.g._Thunderbird.29)

Your URL changes every semester based on the courses you have taken. Don't forget to update it each semester.
