variable "cidrBlock" {
  type = "string"
}

variable "sshPubKeyFilePath" {
  type = "string"
}

variable "nodeCount" {
  type = number
  default = 1
}