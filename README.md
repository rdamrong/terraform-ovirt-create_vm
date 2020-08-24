# Create VM in oVirt from template with Terraform

```
brew install terraform@0.12
export PATH="/usr/local/opt/terraform@0.12/bin:$PATH"
export TF_VAR_ovirt_password="mypassword"
terraform init
terraform plan 
terraform apply -parallelism=5
```

```
Get template ID
export OVIRT_PASSWORD="mypassword"
curl --output ca.crt 'http://ovirt.example.com/ovirt-engine/services/pki-resource?resource=ca-certificate&format=X509-PEM-CA'
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api

curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/templates

Specific find out ID for tempalte-for-centos7
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/templates -s |grep -B 2 "template-for-centos7"


Specific find out ID for centos8
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/templates\?search\=centos8\&max\=1 -s | grep -B 4 ">centos8<"  |grep id |cut -d "\"" -f 4


Search Cluster ID
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/clusters\?search\=VELA0 -s |grep "id=" |grep cluster

```
