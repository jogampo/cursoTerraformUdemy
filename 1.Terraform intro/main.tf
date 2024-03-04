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

resource "azurerm_resource_group" "ejemploCursoTerraformIntroDepAndGraphs" {
  name     = "gr-curso-udemy-terraform-intro-dep-and-graphs"
  location = "West Europe"
  tags = {
    dependency = azurerm_resource_group.ejemploCursoTerraformIntro.name
  }
}

resource "azurerm_resource_group" "ejemploCursoTerraformIntroDepAndGraphsRg3" {
  name     = "gr-curso-udemy-terraform-intro-rg3"
  location = "West Europe"
  depends_on = [
    azurerm_resource_group.ejemploCursoTerraformIntroDepAndGraphs
  ]
}


output "output-terraform-intro" {
  value = azurerm_resource_group.ejemploCursoTerraformIntro.id
}

output "output-terraform-intro-2" {
  value = azurerm_resource_group.ejemploCursoTerraformIntro.name
}

variable "image_id" {
  type        = list(string)
  default     = ["dato_predeterminado"]
}

variable "project_name"{
  type = string
}


resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntro" {
  name     = var.project_name
  location = "West Europe"
}

variable "docker_port"{
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 5000
      external = 4000
      protocol = "tcp"
    }
  ]  
}
