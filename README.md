# Terraform with Azure Cloud
## Mini tutorial for IaC using Terraform and Azure

This repo is for a university project where I have to create a tutorial in the subject of Cloud computing using Microsoft Azure .

### Step 1 : Intall Terraform

Through this link you can install Terraform : [LINK](https://developer.hashicorp.com/terraform/install?product_intent=terraform#windows)

Once installed extract the downloaded folder and you will have an executable file nnamed "terraform" .
You just have to add this file to your system variables . (eg. if your file is in C:\ just add C:\ in your environment variables path)

To be sure of the installation tap this command in your terminal:
```bash
terraform version
```

### Step 2 : Create an Azure subscription if you don't have one
You can use this [LINK](https://azure.microsoft.com/en-us/free/) for a free trial .

### Step 3 : Setup your Azure account
1. Login to your account through Azure Portal [LINK](portal.azure.com) .
2. Access your Cloud Shell (Button on the top-right of the page) .
3. Get your subscription id and type and replace "<id>" with your id .
```bash
az account set -s "<id>"
``` 
4. Terraform needs a Service Principal to be able to go into your Azure subscription and make changes.
So you will do this with RBAC through the cloud shell .
```bash
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/<id>"
``` 
You will get an output in the form of JSON .
5. Setup environment varibles in your cloud shell (replace <this> with yours from the previous JSON output).
```bash
export ARM_CLIENT_ID="<appId>"
export ARM_CLIENT_SECRET="<password>"
export ARM_SUBSCRIPTION_ID="<id>"
export ARM_TENANT_ID="<tenant>"
``` 

### Step 4 : Create a Resource group through code
1. Create a folder locally on your machine and create a file inside it named "main.tf"
2. Write this inside .tf file
```
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75.0"
    }
  }

  required_version = ">= 1.5.7"
}

provider "azurerm" {
  features {}
}
```
3. In your local terminal change the directory and go to the folder you just created and type this
```bash
terraform init
```
You will notice the creation of a new folder ".terraform" and a new file ".terraform.lock.hcl"

4. Add this to your "main.tf" file to create a resource group within your azure subscription through code
```
resource "azurerm_resource_group" "rg-wtf" {
  name     = "rg-with-terraform"
  location = "West Europe"
}
``` 
5. Type 
```bash
terraform plan
```
to preview changes that will be made .
then type 
```bash
terraform apply -auto-approve
```
to apply changes .
PS: You need Azure CLI installed on your local machine .
6. Check Azure portal and you will notice that a resource group has been created .

### Step 5 : Cleaning up
Type
```bash
terraform destroy
```
to delete all resources created from "main.tf" file .

Thanks for your attention and happy learning !