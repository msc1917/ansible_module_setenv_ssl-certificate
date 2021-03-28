# Konfiguration fuer den Service "SSL-CERTIFICATE" im Baikonur-Netzwerk
Service-Beschreibung:

## Rolle "setenv_03_ssl-certificate"
Richtet die Software für folgende Services ein:
* Interne Zertifikatsverwaltung

## Verzeichnisse:
* **tasks:** Playbook-Tasks, welche in der Rolle durchgeführt werden
* **defaults:** Standard-Variablen für die Rolle (werden von anderen Variabledefinitionen übersteuert)
* **vars:** Weitere Variablen für die Rolle
* **templates:** Jinja2-Templates, welche von der Rolle benötigt werden könnten
* **files:** Files, welche von der Rolle benötigt werden könnten
* **handlers:** Ansible-Handler-Definitionen
* **meta:** Meta-Daten für die Rolle

## Notes:
index.db-File-Definition:
1. Certificate status flag (V=valid, R=revoked, E=expired).
2. Certificate expiration date in YYMMDDHHMMSSZ format.
3. Certificate revocation date in YYMMDDHHMMSSZ[,reason] format. Empty if not revoked.
4. Certificate serial number in hex.
5. Certificate filename or literal string ‘unknown’.
6. Certificate distinguished name.


## Todos:
* User-Zertifikate umsetzen
* Zertifikate für Appliancies umsetzen
* CRL umsetzen
# Index-File
* Protokoll-File umsetzen
* Export des root-Certifikates auf ca.baikonur.at Exportieren

## Checks:
 openssl verify /etc/ssl/certs/rootCA.baikonur.at.pem /home/schama/data/ssl-ca/baikonur.at/intermediate-ca/certs/intermediateCA.m19.baikonur.at.pem /etc/ssl/crt/server-cert.pem
 openssl x509 -in /etc/ssl/crt/server-cert.pem -text -noout