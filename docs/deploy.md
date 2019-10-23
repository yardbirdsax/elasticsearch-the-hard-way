# Deploying the base lab cloud infrastructure

1. Check out this repository (or download a copy of its contents and unzip) and navigate to the folder where it is stored in your command prompt.
1. Run the following command to deploy the base resources:

    ```bash
    terraform apply -var-file=./default.tfvars
    ```

    >**NOTE: The default values in the variable file will deploy an environment with 3 nodes and assumes your SSH public key file is at the path ~/.ssh/id_rsa.pub. Edit values according to your needs before deploying.**

The deployment will output several DNS names, which are the public FQDNs for the nodes deployed. You will need to use these to access the nodes over SSH for the remainder of the lessons.

```bash
Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

dnsNames = ec2-3-232-114-110.compute-1.amazonaws.com,ec2-34-231-15-64.compute-1.amazonaws.com,ec2-3-232-103-131.compute-1.amazonaws.com
```