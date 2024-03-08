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
  count = 3
  name     = "${var.project_name}_tercero_${count.index}"
  location = "West Europe"
  tags = {
    "team" = local.tag
  }
}

resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntroParaCount0" {
  count = 0
  name     = "${var.project_name}_tercero_${count.index}"
  location = "West Europe"
  tags = {
    "team" = local.tag
  }
}


locals{
  names = {
    name01 = "name01"
    name02 = "name02"
    name03 = "name03"
  }
}
resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntroParaCountDiferentesNames" {
  for_each = local.names
  name     = "${var.project_name}_foreach_${each.value}"
  location = "West Europe"
  tags = {
    "team" = local.tag
  }
}


locals{
  t_string = "Test"
  t_number = 823.23
  t_bool1 = false
  t_bool2 = true
  t_list = [
    "element1",
    89233,
    true
  ]
  t_map = {
    type = "Client"
  }

  t_customer = {
    name = "minombre",
    age = 200,
    lista_cosas_gustan = {
      deporte = "futbol"
      juegos = "fifa"
    }
  }
}

output "deporte"{
   value = local.t_customer.lista_cosas_gustan.deporte
}

locals {
  t_operacion = 1 + 3
  t_operacion2 = 1 * 3
  t_operacion3 = 1 / 3
}

locals {
  t_logical = 5 < 9
  t_logical2 = 5 > 9
  t_logical3 = (5 > 9) && (3 < 2)
}


variable "rg_count"{
  type = number  
}

locals{
  min_rg_number = 3
  rg_no = var.rg_count > 0 ? var.rg_count : local.min_rg_number
}


resource "azurerm_resource_group" "ejemploVariablesCursoTerraformIntroParaCountDesdeVariable" {
  count = local.rg_no
  name     = "rg_${var.project_name}_desdevariable_${count.index}"
  location = "West Europe"
}

locals{
  names1 = ["Jorge" , "Hector", "Juan"]
  mayus = [for i in local.names1: upper(i)]
  a_names = [for i in local.names1: i if substr(i,0,1) == "J"]
}

output "mayusculas" {
   value = local.mayus
}

output "filtered" {
   value = local.a_names
}