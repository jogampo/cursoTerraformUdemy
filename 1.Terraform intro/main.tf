terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "3.94.0"
    }
  }  
}

provider "azurerm"{
    features{}
}

resource "azurerm_resource_group" "ejemploCursoTerraformIntro" {
  name     = "gr-curso-udemy-terraform-intro-2"
  location = "West Europe"
}

output "output-terraform-intro" {
  value = azurerm_resource_group.ejemploCursoTerraformIntro.id
}

output "output-terraform-intro-2" {
  value = azurerm_resource_group.ejemploCursoTerraformIntro.name
}

