# Create teamplate in oVirt from qcow2 with Terraform

```
export OVIRT_PASSWORD="mypassword"
terraform init
terraform plan -var="ovirt_password=$OVIRT_PASSWORD"
terraform apply -var="ovirt_password=$OVIRT_PASSWORD"
```

## Get template ID
```
curl --output ca.crt 'http://ovirt.example.com/ovirt-engine/services/pki-resource?resource=ca-certificate&format=X509-PEM-CA'
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api

curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/templates

#-- Specific find out ID for tempalte-for-centos7
curl -X GET -H "Accept: application/xml" -u admin@internal:$OVIRT_PASSWORD --cacert ca.crt https://ovirt.example.com:443/ovirt-engine/api/templates -s |grep -B 2 "template-for-centos7"

```
