# Konfiguration fuer den Service "SSL-CERTIFICATE" im Baikonur-Netzwerk
Service-Beschreibung:

## Rolle "setenv_03_ssl-certificate"
Richtet die Software für folgende Services ein:
* [SOFTWAREBEZEICHNUNG]

## Verzeichnis "templates"
Jinja2-Templates, welche von der Rolle benötigt werden könnten

## Files:
* **[DATEINAME]:** Beschreibung



openssl genrsa -out RootCA.key 4096
openssl req -new -x509 -days 1826 -key RootCA.key -out RootCA.crt

echo 'Root Certificate done, now intermediate begins'
openssl genrsa -out IntermediateCA.key 4096
openssl req -new -key IntermediateCA.key -out IntermediateCA.csr
openssl x509 -req -days 1000 -in IntermediateCA.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial  -out IntermediateCA.crt

echo 'intermediate done, now on to importing cert into the OS trust'
cp *.crt /usr/local/share/ca-certificates/
update-ca-certificates

echo 'now for the server specific material'
openssl genrsa -out server.key 2048
OPENSSL_CONF=~/openssl.conf openssl req -new -key server.key -out server.csr
openssl x509 -req -in server.csr -CA IntermediateCA.crt -CAkey IntermediateCA.key -set_serial 01 -out server.crt -days 500 -sha1

echo 'verification of sort here'
openssl x509 -in server.crt -noout -text |grep 'host.localism'


#optional​, not going over.
#echo​ 'for the sake of windows clients, we created a pkcs file, but lets create usable PEMs'
#openssl​ pkcs12 -export -out IntermediateCA.pkcs -inkey ia.key -in IntermediateCA.crt -chain -CAfile ca.crt
#openssl​ pkcs12 -in path.p12 -out newfile.crt.pem -clcerts -nokeys
#openssl​ pkcs12 -in path.p12 -out newfile.key.pem -nocerts -nodes

openssl s_client -connect 192.168.0.17:443

contents OPENSSL.conf
[req]
prompt = no
default_md = sha1 #for​ video use only, sha256 onwards
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C=US
ST=North Carolina
O=LazyTree
localityName=Redacted
OU=HomeLab
emailAddress=kondor6c@lazytree.us
CN=www.lazytree.us











[ca]
#/root/ca/root-ca/root-ca.conf
#see​ man ca
default_ca    = CA_default

[CA_default]
dir     = /root/ca/root-ca
certs     =  $dir/certs
crl_dir    = $dir/crl
new_certs_dir   = $dir/newcerts
database   = $dir/index
serial    = $dir/serial
RANDFILE   = $dir/private/.rand

private_key   = $dir/private/ca.key
certificate   = $dir/certs/ca.crt

crlnumber   = $dir/crlnumber
crl    =  $dir/crl/ca.crl
crl_extensions   = crl_ext
default_crl_days    = 30

default_md   = sha256

name_opt   = ca_default
cert_opt   = ca_default
default_days   = 365
preserve   = no
policy    = policy_strict

[ policy_strict ]
countryName   = supplied
stateOrProvinceName  =  supplied
organizationName  = match
organizationalUnitName  =  optional
commonName   =  supplied
emailAddress   =  optional

[ policy_loose ]
countryName   = optional
stateOrProvinceName  = optional
localityName   = optional
organizationName  = optional
organizationalUnitName   = optional
commonName   = supplied
emailAddress   = optional

[ req ]
# Options for the req tool, man req.
default_bits   = 2048
distinguished_name  = req_distinguished_name
string_mask   = utf8only
default_md   =  sha256
# Extension to add when the -x509 option is used.
x509_extensions   = v3_ca

[ req_distinguished_name ]
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name
localityName                    = Locality Name
0.organizationName              = Organization Name
organizationalUnitName          = Organizational Unit Name
commonName                      = Common Name
emailAddress                    = Email Address
countryName_default  = GB
stateOrProvinceName_default = England
0.organizationName_default = TheUrbanPenguin Ltd

[ v3_ca ]
# Extensions to apply when createing root ca
# Extensions for a typical CA, man x509v3_config
subjectKeyIdentifier  = hash
authorityKeyIdentifier  = keyid:always,issuer
basicConstraints  = critical, CA:true
keyUsage   =  critical, digitalSignature, cRLSign, keyCertSign

[ v3_intermediate_ca ]
# Extensions to apply when creating intermediate or sub-ca
# Extensions for a typical intermediate CA, same man as above
subjectKeyIdentifier  = hash
authorityKeyIdentifier  = keyid:always,issuer
# pathlen​:0 ensures no more sub-ca can be created below an intermediate
basicConstraints  = critical, CA:true, pathlen:0
keyUsage   = critical, digitalSignature, cRLSign, keyCertSign

[ server_cert ]
# Extensions for server certificates
basicConstraints  = CA:FALSE
nsCertType   = server
nsComment   =  "OpenSSL Generated Server Certificate"
subjectKeyIdentifier  = hash
authorityKeyIdentifier  = keyid,issuer:always
keyUsage   =  critical, digitalSignature, keyEncipherment
extendedKeyUsage  = serverAuth