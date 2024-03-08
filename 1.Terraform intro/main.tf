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
  description = "Nombre del grupo de recursos. Tiene que ser mayor a 4"
  validation{
    condition = length(var.project_name) > 4
    error_message = "Nombre del grupo de recursos tiene que ser mayor que 4 caracteres."
  }
}


resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntro" {
  name     = "${var.project_name}_main"
  location = "West Europe"
}


resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntroSecondary" {
  name     = "${var.project_name}_secondary"
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

locals {
  rg1 = azurerm_resource_group.ejemploVariablesCursoTerraformIntro.id
  tag = "development"
}

resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntroTercero" {
  name     = "${var.project_name}_secondary"
  location = "West Europe"
  tags = {
    "team" = local.tag
  }
}



