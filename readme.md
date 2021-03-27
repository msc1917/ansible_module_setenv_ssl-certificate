# Konfiguration fuer den Service "SSL-CERTIFICATE" im Baikonur-Netzwerk
Service-Beschreibung:

## Rolle "setenv_03_ssl-certificate"
Richtet die Software für folgende Services ein:
* [SOFTWAREBEZEICHNUNG]

## Verzeichnisse:
* **tasks:** Playbook-Tasks, welche in der Rolle durchgeführt werden
* **defaults:** Standard-Variablen für die Rolle (werden von anderen Variabledefinitionen übersteuert)
* **vars:** Weitere Variablen für die Rolle
* **templates:** Jinja2-Templates, welche von der Rolle benötigt werden könnten
* **files:** Files, welche von der Rolle benötigt werden könnten
* **handlers:** Ansible-Handler-Definitionen
* **meta:** Meta-Daten für die Rolle

## Todos:
* Certificate Chain funktioniert noch nicht
* Server-Certificate-Files müssen in /srv verschoben werden
* Samba integrieren

## Checks:
 openssl verify /home/schama/data/ssl-ca/baikonur.at/intermediate-ca/certs/intermediateCA.m19.baikonur.at.pem /etc/ssl/certs/rootCA.baikonur.at.pem /etc/ssl/crt/server-cert.pem
 openssl x509 -in /etc/ssl/crt/server-cert.pem -text -noout