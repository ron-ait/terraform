provider "github" {
  token = var.token
}
resource "github_repository" "terraform" {
  name        = "terraform"
  description = "My awesome codebase"

  visibility = "public"
}
variable "token" {
}

variable "doing" {
  default = "ADDDDFF"

}
variable "done" {
  default = "dfdf"
}