# Backend lokalny – stan Terraform przechowywany jest w pliku terraform.tfstate
# na dysku lokalnym. Idealne do nauki i demonstracji.
#
# UWAGA: W środowiskach produkcyjnych zaleca się używanie zdalnego backendu
# (np. S3, Azure Blob, GCS, Terraform Cloud), który umożliwia współpracę
# zespołową i przechowuje stan w bezpiecznym miejscu.

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

